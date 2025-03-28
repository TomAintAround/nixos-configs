{ pkgs, config, lib, ... }: 
let
	accent = "sky";
	flavor = "mocha";
in {
	imports = [ ./../trash-cli.nix ];

	gtk = {
		theme = {
			name = "catppuccin-${flavor}-${accent}-standard";
			package = pkgs.catppuccin-gtk.override {
				accents = [ accent ];
				variant = flavor;
			};
		};
	};

	catppuccin = {
		alacritty = {
			enable = true;
			inherit flavor;
		};

		bat = {
			enable = true;
			inherit flavor;
		};

		btop = {
			enable = true;
			inherit flavor;
		};

		delta = {
			enable = true;
			inherit flavor;
		};

		dunst = {
			enable = true;
			inherit flavor;
			prefix = "99";
		};

		fish = {
			enable = true;
			inherit flavor;
		};

		fzf = {
			enable = true;
			inherit accent flavor;
		};

		gtk.icon = {
			enable = true;
			inherit accent flavor;
		};

		kvantum = {
			enable = true;
			apply = true;
			inherit accent flavor;
		};

		mpv = {
			enable = false;
			accent = "mauve";
			inherit flavor;
		};

		obs = {
			enable = false;
			inherit flavor;
		};

		tmux = {
			enable = true;
			inherit flavor;
			extraConfig = ''
set -g @catppuccin_flavor "mocha"
set -g @catppuccin_window_status_style "rounded"
set -g status-left ""
set -g status-left-length 100

set -g status-right-length 100
set -g status-right "#{E:@catppuccin_status_user}"
set -ag status-right "#{E:@catppuccin_status_host}"
set -ag status-right "#{E:@catppuccin_status_directory}"
set -ag status-right "#{E:@catppuccin_status_application}"
set -ag status-right "#{E:@catppuccin_status_session}"
set -g @catppuccin_status_left_separator  " "
set -g @catppuccin_status_right_separator ""
set -g @catppuccin_status_fill "icon"
set -g @catppuccin_status_connect_separator "no"

set -g @catppuccin_directory_text "#{pane_current_path}"
set -g @catppuccin_user_color "#f38ba8"
set -g @catppuccin_host_color "#eba0ac"
set -g @catppuccin_application_color "#f9e2af"
set -g @catppuccin_directory_color "#fab387"
			'';
		};
	};

	# Script to copy the GTK theme to ~/.themes/ and the icon theme
	# to ~/.icons each time home-manager is updated for flatpak support
	home.activation.copy-themes = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
themeDir=${config.home.homeDirectory}/.themes
iconDir=${config.home.homeDirectory}/.icons

run mkdir "$themeDir" 2>/dev/null & # For some reason, "&" is needed
run mkdir "$iconDir" 2>/dev/null &
run sleep 1

# Because there's an override in catppuccin-gtk,
# it's more difficult to get the path
themePath=$(run nix-instantiate --eval --expr '
let
	pkgs = import <nixpkgs> {};
	myGtk = pkgs.catppuccin-gtk.override (old: {
		accents = [ "${accent}" ];
		variant = "${flavor}";
	});
in
	myGtk.outPath
' | run sed 's/\"//g')/share/themes/${config.gtk.theme.name}

newThemePath="$themeDir"/${config.gtk.theme.name}

copyTheme() {
	run cp -r "$themePath" "$themeDir"
	run chmod +w "$newThemePath"
}

if [ -e "$newThemePath" ]; then
	if ! run diff "$themePath" $newThemePath &>/dev/null; then
		${pkgs.trash-cli}/bin/trash-put "$newThemePath"
		copyTheme
	fi
else
	copyTheme
fi

iconPath=$(run nix-instantiate --eval --expr '
let
	pkgs = import <nixpkgs> {};
	myIcon = pkgs.catppuccin-papirus-folders.override (old: {
		accent = "${accent}";
		flavor = "${flavor}";
	});
in
	myIcon.outPath
' | run sed 's/\"//g')/share/icons/Papirus

newIconPath="$iconDir"/Papirus

copyIcon() {
	run cp -r "$iconPath""$1" "$iconDir"
	run chmod +w "$newIconPath""$1"
}

for extra in "" "-Dark" "-Light"; do
	if [ -e "$newIconPath""$extra" ]; then
		if ! run diff "$iconPath""$extra" "$newIconPath""$extra" &>/dev/null; then
			${pkgs.trash-cli}/bin/trash-put "$newIconPath""$extra"
			copyIcon "$extra"
		fi
	else
		copyIcon "$extra"
	fi
done
	'';

	wayland.windowManager.hyprland.settings = lib.mkIf config.wayland.windowManager.hyprland.enable {
		source = [ "${config.catppuccin.sources.hyprland}/${flavor}.conf" ];

		general = {
			"col.inactive_border" = "\$base \$overlay0 45deg";
			"col.active_border" = "\$sky \$blue 45deg";
		};

		plugin.hyprbars = {
			bar_color = "\$crust";
			"col.text" = "\$text";
			hyprbars-button = [
				"\$red, 15, , hyprctl dispatch killactive"
				"\$yellow, 15, , hyprctl dispatch fullscreen 1"
			];
		};
	};
}
