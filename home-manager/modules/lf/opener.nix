{ pkgs, ... }: {
	programs.lf.commands = {
		open = ''
''${{
	dem() {
		{ setsid -f "$@" >/dev/null 2>&1& } \
		|| ({ nohup "$@" >/dev/null 2>&1& } &) \
		|| (exec "$@" >/dev/null 2>&1&)
	}

	real_f="$(readlink -f $f || realpath $f)" \

	mime_type="$(\
		${pkgs.exiftool}/bin/exiftool -s3 -MIMEType "$real_f" 2>/dev/null \
		|| ${pkgs.file}/bin/file --dereference -b --mime-type -- "$real_f" 2>/dev/null
	)"

	case "$mime_type" in
		(application/pdf | application/postscript | image/vnd.djvu |	application/epub*)
			dem "''${READER}" $fx
		;;
		(text/html)
			case "''${f##*.}" in
				(xls) dem localc $f ;;
				(*) dem "''${BROWSER}" $f
			esac
		;;
		(text/troff)
			case "''${f##*.}" in
				([0-9] | [01]p | [23]*) ${pkgs.bat-extras.batman}/bin/batman $fx ;;
				(*) "''${EDITOR}" $fx
			esac
		;;
		( text/* | application/json | application/javascript | \
		application/pgp-encrypted | inode/x-empty | application/octet-stream | \
		application/x-gettext-translation )
			"''${EDITOR}" $fx
		;;
		(image/x-*)
			dem "''${IMAGE_EDITOR}" $fx
		;;
		(image/* )
			dem "''${IMAGE_EDITOR}" $fx
		;;
		(audio/*)
			dem "''${AUDIO_PLAYER}" $fx
		;;
		(video/*)
			dem "''${VIDEO_PLAYER}" $fx
		;;
		(*)
			case "$f" in
				( *.tar.bz | *.tar.bz2 | *.tbz | \
				*.tbz2 | *.tar.gz | *.tgz | *.tar.lzma | \
				*.tar.xz | *.txz | *.zip | *.rar | *.iso)
					mntdir="$f-archive"
					if ! [ -d "$mntdir" ]; then
						mkdir -- "$mntdir"
						${pkgs.atool}/bin/atool -X "$mntdir" "$f"
						printf -- "%s\n" "$mntdir" >> "/tmp/__lf_archive_$id"
					fi
					${pkgs.lf}/bin/lf -remote "send $id cd '$mntdir'"
					${pkgs.lf}/bin/lf -remote "send $id reload"
				;;
			esac

			for f in $fx; do
				dem "''${OPENER}" $f
			done
		;;
	esac
}}
		'';

		openwith = ''
''${{
	dem() {
		{ setsid -f "$@" >/dev/null 2>&1& } \
		|| ({ nohup "$@" >/dev/null 2>&1& } &) \
		|| (exec "$@" >/dev/null 2>&1&)
	}

	real_f="$(readlink -f $f || realpath $f)" \
	mime_type="$(\
		${pkgs.exiftool}/bin/exiftool -s3 -MIMEType "$real_f" \
		|| file --dereference -b --mime-type -- "$real_f"
	)"

	menu_select() {
		nl -nln | ${pkgs.fzf}/bin/fzf --with-nth 2.. | cut -d' ' -f1
	}

	case "$mime_type" in
		( text/* | application/json | application/javascript | \
		application/pgp-encrypted | inode/x-empty | application/octet-stream )
			app=$(menu_select <<-\EOF
				$EDITOR
				nano
				EOF
			)
			case "$app" in
				(1) "''${EDITOR}" $fx ;;
				(2) ${pkgs.nano}/bin/nano $fx ;;
			esac
		;;

		(image/svg+xml | image/png | image/jpeg | image/gif )
			app=$(menu_select <<-\EOF
				gimp
				EOF
			)
			case "$app" in
				(1) dem gimp $fx ;;
			esac
		;;

		(image/x-*)
			app=$(menu_select <<-\EOF
				gimp
				EOF
			)
			case "$app" in
				(1) dem gimp $fx ;;
			esac
		;;

		(audio/*)
			app=$(menu_select <<-\EOF
				vlc
				EOF
			)
			case "$app" in
				(1) dem vlc $fx ;;
			esac
		;;

		(video/*)
			app=$(menu_select <<-\EOF
				vlc
				kdenlive
				EOF
			)
			case "$app" in
				(1) dem vlc $fx ;;
				(2) dem kdenlive $fx ;;
			esac
		;;
	esac
}}
		'';
	};
}
