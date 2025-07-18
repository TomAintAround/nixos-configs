{ pkgs, lib, config, ... }: lib.mkIf (config.fileManager == "lf" && (config.terminal == "kitty" && !config.programs.tmux.enable)) {
	xdg.configFile."lf/vidthumb.bash" = {
		executable = true;
		text = ''
#!/usr/bin/env bash

if ! [ -f "$1" ]; then
	exit 1
fi

cache="${config.xdg.cacheHome}/vidthumb"
index="$cache/index.json"
movie="$(realpath "$1")"

mkdir -p "$cache"

if [ -f "$index" ]; then
	thumbnail="$(${pkgs.jq}/bin/jq -r ". \"$movie\"" <"$index")"
	if [[ "$thumbnail" != "null" ]]; then
		if [[ ! -f "$cache/$thumbnail" ]]; then
			exit 1
		fi
		echo "$cache/$thumbnail"
		exit 0
	fi
fi

thumbnail="$(uuidgen).jpg"

if ! ${pkgs.ffmpegthumbnailer}/bin/ffmpegthumbnailer -i "$movie" -o "$cache/$thumbnail" -s 0 2>/dev/null; then
	exit 1
fi

if [[ ! -f "$index" ]]; then
	echo "{\"$movie\": \"$thumbnail\"}" >"$index"
fi
json="$(${pkgs.jq}/bin/jq -r --arg "$movie" "$thumbnail" ". + {\"$movie\": \"$thumbnail\"}" <"$index")"
echo "$json" >"$index"

echo "$cache/$thumbnail"
		'';
	};
}
