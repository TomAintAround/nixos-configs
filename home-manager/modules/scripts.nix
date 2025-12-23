{
  pkgs,
  config,
  ...
}: {
  xdg.dataFile."scripts/albumart.bash" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      ##########################################################################
      # https://github.com/VishnuSanal/dotfiles/blob/main/bin/mpd-album-art.sh #
      ##########################################################################

      THUMB="/tmp/mpdAlbumArt.jpg"

      while true; do
      	if [ $(${pkgs.mpc}/bin/mpc status %state%) == "playing" ]; then
      		FILE="${config.xdg.userDirs.music}/$(${pkgs.mpc}/bin/mpc current -f %file%)"
      	fi
      	echo "$FILE"
      	${pkgs.ffmpeg}/bin/ffmpeg -i "$FILE" "$THUMB" -y &> /dev/null
      	${pkgs.mpc}/bin/mpc idle player
      done
    '';
  };

  home.file = {
    ".local/bin/wallpaper-change" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        set -euo pipefail

        wallpapersDir="${config.xdg.userDirs.pictures}/Wallpapers"
        wallpaperSet="${config.xdg.cacheHome}/wallpaper-set"
        mkdir -p "$wallpapersDir"
        touch "$wallpaperSet"

        wallpapers=()
        while IFS= read -r -d ''' file; do
        	wallpapers+=("$file")
        done < <(find "$wallpapersDir" -maxdepth 1 -type f \( -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -o -name '*.webp' \) -print0 | sort -z)
        wallpaperCount="''${#wallpapers[@]}"
        if [ "$wallpaperCount" -eq 0 ]; then
        	echo "No wallpapers found in $wallpapersDir." >&2
        	exit 1
        fi
        selected=$(cat "$wallpaperSet" 2>/dev/null || echo "1")

        getNewIndex() {
        	local arg="''${1:-}"
        	if [[ "$arg" =~ ^[0-9]+$ ]] && [ "$arg" -ge 1 ] && [ "$arg" -le "$wallpaperCount" ]; then
        		printf "\033[0;32m[MODE]\033[0m Direct\n" >&2
        		echo "$arg"
        	elif [[ "$arg" == "startup" ]]; then
        		printf "\033[0;32m[MODE]\033[0m Startup\n" >&2
        		echo "$selected"
        	else
        		local next=$((selected + 1))
        		if [[ next -gt wallpaperCount ]]; then
        			next=1
        		fi
        		printf "\033[0;32m[MODE]\033[0m Cycle\n" >&2
        		echo "$next"
        	fi
        }
        new=$(getNewIndex "''${1:-}")
        wallpaper="''${wallpapers[$((new-1))]}"

        case "''${XDG_SESSION_TYPE:-}" in
        	wayland)
        		if pgrep swww-daemon &>/dev/null; then
        			printf "\033[0;32m[INFO]\033[0m Selecting wallpaper %s\n" "$wallpaper"
        			${pkgs.swww}/bin/swww img "$wallpaper" --transition-step 150 --transition-type wipe --transition-bezier .33,1,.67,1
        		else
        			echo "Error: swww-daemon is not initialized" >&2
        			exit 1
        		fi
        		;;
        	*)
        		printf "\033[0;32m[INFO]\033[0m Selecting wallpaper %s\n" "$wallpaper"
        		${pkgs.feh}/bin/feh --bg-fill "$wallpaper"
        esac

        echo "$new" > "$wallpaperSet"
      '';
    };

    ".local/bin/backupSystem" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        set -euo pipefail

        backupLocation="${config.home.homeDirectory}/Backup"
        lastBackupDir="$backupLocation/lastBackup"
        currentBackupDir="$backupLocation/currentBackup"
        backupList="$backupLocation/toBackup.txt"
        mkdir -p "$lastBackupDir" "$currentBackupDir"

        copyFiles() {
          src="$1"
          dest="$2"
          mkdir -p "$dest"
          ${pkgs.rsync}/bin/rsync -a --update "$src" "$dest/"
        }

        if [[ "''${1:-}" != "dontMove" ]]; then
          rm -rf "''${lastBackupDir:?}"/*
          if [ "$(ls -A "$currentBackupDir")" ]; then
            mv "$currentBackupDir"/* "$lastBackupDir"
          fi
        else
        	rm -rf "''${currentBackupDir:?}"/*
        fi

        while IFS= read -r fileOrDir; do
          [[ -z "$fileOrDir" || "$fileOrDir" =~ ^# ]] && continue

          parentDirs=$(dirname "$fileOrDir")
          backupDest="$currentBackupDir$parentDirs"
          copyFiles "$fileOrDir" "$backupDest" &
        done < "$backupList"
        wait

        echo "Backup complete."
      '';
    };

    ".local/bin/backupImages" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        set -euo pipefail

        backupPath="$HOME/Downloads"
        old="$backupPath/old"
        new="$backupPath/new"
        mkdir -p "$new"

        renameFile() {
          file="$1"
          ext="''${file##*.}"
          ext="''${ext,,}"
          datetime=$(date -r "$file" "+%Y-%m-%d_%H-%M-%S")
          dest="$new/''${datetime}.''${ext}"
          if [[ -e "$dest" ]]; then
            i=1
            while [[ -e "''${dest%.*}_$i.''${ext}" ]]; do ((i++)); done
            dest="''${dest%.*}_$i.''${ext}"
          fi
          mv -- "$file" "$dest"
        }

        convertImage() {
          ext="''${1##*.}"
          ext="''${ext,,}"
          case "$ext" in
            heic|jpg|jpeg|png|webp)
              ${pkgs.imagemagick}/bin/magick "$1" -auto-orient "''${1%.*}.jpeg" &&
            [ "$ext" != "jpeg" ] &&
            rm -- "$1"
              ;;
          esac
        }

        convertVideo() {
          ext="''${1##*.}"
          ext="''${ext,,}"
          case "$ext" in
            mov)
              ${pkgs.ffmpeg}/bin/ffmpeg -i "$1" -c:v libx264 -c:a aac "''${1%.*}.mp4" && rm -- "$1"
              ;;
          esac
        }

        export -f renameFile convertImage convertVideo
        export new

        printf "Copying images/videos...\n"
        cp -pru "$old"/* "$new" && printf "Done\n" || printf "An error occurred"
        printf "Renaming...\n"
        find "$new" -type f -print0 | ${pkgs.parallel}/bin/parallel -0 -j32 renameFile {} && printf "Done\n" || printf "An error occurred"
        printf "Converting images...\n"
        find "$new" -type f -print0 | ${pkgs.parallel}/bin/parallel -0 -j16 convertImage {} && printf "Done\n" || printf "An error occurred"
        printf "Converting videos...\n"
        find "$new" -type f ! -iname "*.mp4" -print0 | ${pkgs.parallel}/bin/parallel -0 -j2 convertVideo {} && printf "Done\n" || printf "An error occurred"
      '';
    };

    ".local/bin/backupToDrive" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        if [ $# -ne 1 ]; then
        	exit 1
        fi

        backupDrive="$1"

        while read -r fileOrDir; do
        	parentDir=$(dirname "$fileOrDir")
        	backupDir="$backupDrive""$parentDir"
        	mkdir -p "$backupDir"
        	rsync -a --update /home/tomm/Backup/currentBackup"$fileOrDir" "$backupDir/" &
        done < "$HOME/Backup/toBackup.txt"
        wait
      '';
    };
  };
}
