{ pkgs, lib, config, ... }: lib.mkIf (config.fileManager == "lf") {
	xdg.configFile = {
		"lf/previewer.bash" = {
			executable = true;
			text = ''
#!/usr/bin/env bash

draw() {
${
	if (config.terminal == "alacritty" || config.programs.tmux.enable) then ''
	path="$(readlink -f -- "$1" | sed 's/\\/\\\\/g;s/"/\\"/g')"
	printf '{"action":"add","identifier":"preview","x":%d,"y":%d,"width":%d,"height":%d,"scaler":"contain","scaling_position_x":0.5,"scaling_position_y":0.5,"path":"%s"}\n' \
	"$x" "$y" "$width" "$height" "$path" >"$FIFO_UEBERZUG"
	''
	else ""
}
${
	if (config.terminal == "kitty" && !config.programs.tmux.enable) then ''
	${pkgs.kitty}/bin/kitten icat --stdin no --transfer-mode memory --place "''${width}x''${height}@''${x}x''${y}" "$1" </dev/null >/dev/tty
	''
	else ""
}
	exit 1
}

${ if (config.terminal == "alacritty" || config.programs.tmux.enable) then ''
hash() {
	cache="$HOME/.cache/lf/$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f -- "$1")" | sha256sum | cut -d' ' -f1).jpg"
}

cache() {
	if ! [ -f "$cache" ]; then
		dir="$(dirname -- "$cache")"
		[ -d "$dir" ] || mkdir -p -- "$dir"
		"$@"
	fi
	draw "$cache"
}
	''
	else ""
}

file="$1"
width="$2"
height="$3"
x="$4"
y="$5"

mime_preview() {
	case "$mime_type","$ran_guard" in
		image/*)
${ 
	if (config.terminal == "alacritty" || config.programs.tmux.enable) then ''
			if [ -p "$FIFO_UEBERZUG" ]; then
				# ueberzug doesn't handle image orientation correctly
				orientation="$(magick identify -format '%[orientation]\n' -- "''${file[0]}")"
				if [ -n "$orientation" ] \
				&& [ "$orientation" != Undefined ] \
				&& [ "$orientation" != TopLeft ]; then
					hash "$file"
					cache ${pkgs.imagemagick}/bin/magick -- "''${file[0]}" -auto-orient "$cache"
				else
					draw "$file"
				fi
			fi
	''
	else ""
}
${ 
	if (config.terminal == "kitty" && !config.programs.tmux.enable) then ''
			draw "$file"
	''
	else ""
}
		;;
		(video/webm,0)
			# file --mime-type doesn't distinguish well between "video/webm"
			# actual webm videos or webm audios, but exiftool does, thus
			# re-run this function with new mimetype
			mime_type="$(${pkgs.exiftool}/bin/exiftool -s3 -MIMEType "$file")" \
			ran_guard=$((ran_guard+1))
			mime_preview "$@"
		;;
		video/*)
${ 
	if (config.terminal == "alacritty" || config.programs.tmux.enable) then ''
			if [ -p "$FIFO_UEBERZUG" ]; then
				hash "$file"
				cache ${pkgs.ffmpegthumbnailer}/bin/ffmpegthumbnailer -i "$file" -o "$cache" -s 0
			fi
	''
	else ""
}
${
	if (config.terminal == "kitty" && !config.programs.tmux.enable) then ''
			draw $(${config.xdg.configHome}/lf/vidthumb.bash "$file")
	''
	else ""
}
		;;
		(text/html,0)
			${pkgs.lynx}/bin/lynx -width="$x" -display_charset=utf-8 -dump -- "$file"
		;;
		(text/troff,0)
			case "''${file##*.}" in
			([0-9] | [01]p | [23]*)
				man ./ "$file" | col -b
			;;
			(*)
				${pkgs.bat}/bin/bat --terminal-width "$(($x*7/9))" --style=numbers --paging=never "$file"
			esac
		;;
		(text/*,0 | */xml,0 | application/javascript,0 | application/x-subrip,0 )
			${pkgs.bat}/bin/bat --terminal-width "$(($x*7/9))" --style=numbers --paging=never "$file"
		;;
		(application/json,0)
			${pkgs.jq}/bin/jq -C < "$file"
		;;
		( application/x-pie-executable,0 | application/x-executable,0 | \
		application/x-sharedlib,0)
			objdump -d "$file" -M intel
			#readelf -WCa "$file"
			#hexdump -C "$file" || xxd "$file"
		;;
		(audio/*)
			${pkgs.exiftool}/bin/exiftool -j "$file" | jq -C
		;;
		(*opendocument*,0) # .odt, .ods
			CCt='	' \
			bytes=$(du -sb "$file") bytes="''${bytes%%"$CCt"*}"
			if [ "$bytes" -lt 150000 ]; then
				${pkgs.odt2txt}/bin/odt2txt "$file"
			else
				printf "file too big too preview quickly\n"
			fi
		;;
		(*ms-excel,0)  # .xls
			${pkgs.catdoc}/bin/xls2csv -- "$file" \
				| ${pkgs.bat}/bin/bat --terminal-width "$(($x*7/9))" --color=always -l csv --style=numbers --paging=never
		;;
		(application/pgp-encrypted,0)
			printf "PGP armored ASCII \033[1;31mencrypted\033[m file,\ntry using gpg to decrypt it\n\n"
			cat "$file"
			${pkgs.gnupg}/bin/gpg -d -- "$file"
		;;
		(application/octet-stream,0)
			#extension="''${file##*.}" extension="''${extension%"$file"}"
			case "''${file##*.}" in
			(gpg)
				printf "OpenPGP \033[1;31mencrypted\033[m file,\ntry using gpg to decrypt it\n\n"
			;;
			(*) ${pkgs.exiftool}/bin/exiftool -j "$file" | jq -C
			esac
		;;
	esac

	ext="$(printf '%s' "$file" | tr '[:upper:]' '[:lower:]')"
	ext="''${ext##*.}"
	case "$ext" in
		7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|\
		lha|lrz|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|\
		tbz2|tgz|tlz|txz|tZ|tzo|war|xz|Z|zip)
			${pkgs.atool}/bin/als -- "$file"
		;;
	esac

	return 1
}

main() {
	mime_type="$(${pkgs.file}/bin/file --dereference -b --mime-type -- "$1")" \
	ran_guard=0
	mime_preview "$@" || return $?
}

main "$@" || exit $?
${pkgs.file}/bin/file -Lb -- "$file" | fold -s -w "$width"
			'';
		};

		"lf/cleaner.bash" = {
			executable = true;
			text = ''
#!/usr/bin/env bash
${ 
	if (config.terminal == "alacritty" || config.programs.tmux.enable) then ''
[ -p "$FIFO_UEBERZUG" ] && printf '{"action":"remove","identifier":"preview"}\n' >"$FIFO_UEBERZUG"
	''
	else ""
}
${
	if (config.terminal == "kitty" && !config.programs.tmux.enable) then ''
${pkgs.kitty}/bin/kitty + kitten icat --clear --stdin no --transfer-mode memory --passthrough tmux </dev/null >/dev/tty
	''
	else ""
}
			'';
		};
	};
}
