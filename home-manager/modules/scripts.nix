{ lib, pkgs, config, ... }: {
    xdg.dataFile = {
        "scripts/albumart.bash" = {
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

        "scripts/wallpaper/wallpaper.bash" = {
            executable = true;
            text = ''
            #!/usr/bin/env bash

            selected=$(cat $XDG_DATA_HOME/scripts/wallpaper/wallpaper-set)
            selected="''${selected:-1}"
            wallpapersDir="$XDG_PICTURES_DIR"/Wallpapers

            mode() {
                if [[ $1 =~ ^[0-9]+$ ]] && [[ $(ls $wallpapersDir | grep -ow "$1") ]]; then
                    new="$1"
                    printf "\033[0;32m[MODE]\033[0m Direct\n"
                elif [[ "$1" = "startup" ]]; then
                    new=$selected
                else
                    wallpapernum=$(ls $wallpapersDir | wc -l)
                    new="$(($selected + 1))"
                    if [ "$new" -gt "$wallpapernum" ]; then
                        new=1
                    fi
                    printf "\033[0;32m[MODE]\033[0m Cycle\n"
                fi
            }

            wayland() {
                mode "$1"
                if [[ $(ps -ef | grep swww-daemon | sed '/grep/d' | cat -s) ]]; then
                    printf "\033[0;32m[INFO]\033[0m Selecting wallpaper $new.jpg\n"
                    ${pkgs.swww}/bin/swww img $wallpapersDir/"$new".jpg --transition-step 150 --transition-type wipe --transition-bezier .33,1,.67,1
                else
                    printf "\033[0;32m[INFO]\033[0m Initializing SWWW and selecting wallpaper $new.jpg\n"
                    ${pkgs.swww}/bin/swww-daemon &
                    ${pkgs.swww}/bin/swww img $wallpapersDir/"$new".jpg
                fi
            }

            case "$XDG_SESSION_TYPE" in
                "wayland")
                    wayland "$1"
                ;;

                *)
                    mode "$1"
                    printf "\033[0;32m[INFO]\033[0m Selecting wallpaper $new.jpg\n"
                    ${pkgs.feh}/bin/feh --bg-fill $wallpapersDir/"$new".jpg
            esac

            echo "$new" > "$XDG_DATA_HOME"/scripts/wallpaper/wallpaper-set
            '';
        };
    };
}
