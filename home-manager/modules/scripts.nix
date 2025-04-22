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

wallpapersDir="${config.xdg.userDirs.pictures}"/Wallpapers
wallpaperSet="${config.xdg.cacheHome}"/wallpaper-set
if [ ! -f "$wallpaperSet" ]; then
	touch "$wallpaperSet"
fi

selected=$(cat "$wallpaperSet")
selected="''${selected:-1}"

mode() {
	if [[ $1 =~ ^[0-9]+$ ]] && [[ $(find "$wallpapersDir"/* | grep -ow "$1") ]]; then
		new="$1"
		printf "\033[0;32m[MODE]\033[0m Direct\n"
	elif [[ "$1" = "startup" ]]; then
		new=$selected
	else
		wallpapernum=$(find "$wallpapersDir"/* | wc -l)
		new="$(("$selected" + 1))"
		if [ "$new" -gt "$wallpapernum" ]; then
			new=1
		fi
		printf "\033[0;32m[MODE]\033[0m Cycle\n"
	fi
}

wayland() {
	mode "$1"
	if [[ $(pgrep swww-daemon) ]]; then
		printf "\033[0;32m[INFO]\033[0m Selecting wallpaper %s.jpg\n" "$new"
		swww img "$wallpapersDir"/"$new".jpg --transition-step 150 --transition-type wipe --transition-bezier .33,1,.67,1
	else
		echo "Error: swww-daemon is not initialized" >&2
		exit 1
	fi
}

if [ $# -lt 1 ]; then
	argument="placeholderThatDoesNothingButEnsuresAnArgumentExists"
else
	argument=$1
fi

case "$XDG_SESSION_TYPE" in
	"wayland")
		wayland "$argument"
	;;

	*)
		mode "$argument"
		printf "\033[0;32m[INFO]\033[0m Selecting wallpaper %s.jpg\n" "$new"
		feh --bg-fill "$wallpapersDir"/"$new".jpg
esac

echo "$new" > "$wallpaperSet"
		'';
	};
}
