{ pkgs, config, ... }: {
	xdg.dataFile."scripts/albumart.bash" = {
		executable = true;
		text = ''
#!/usr/bin/env bash

##########################################################################
# https://github.com/VishnuSanal/dotfiles/blob/main/bin/mpd-album-art.sh #
##########################################################################

THUMB="/tmp/mpdAlbumArt.jpg"

while true; do
	if [ $(${pkgs.mpc-cli}/bin/mpc status %state%) == "playing" ]; then
		FILE="${config.xdg.userDirs.music}/$(${pkgs.mpc-cli}/bin/mpc current -f %file%)"
	fi
	echo "$FILE"
	${pkgs.ffmpeg}/bin/ffmpeg -i "$FILE" "$THUMB" -y &> /dev/null
	${pkgs.mpc-cli}/bin/mpc idle player
done
		'';
	};

	home.file.".local/bin/wallpaper-change" = {
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
}
