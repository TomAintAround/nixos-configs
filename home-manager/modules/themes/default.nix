{ pkgs, config, lib, ... }: {
	imports = [ ./catppuccin-mocha-sky.nix ];

	gtk = {
		enable = true;

		font = {
			name = "Inter";
			size = 11.0;
			package = pkgs.inter;
		};

		gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
	};

	home = {
		pointerCursor = {
			gtk.enable = true;
			package = pkgs.bibata-cursors;
			name = "Bibata-Modern-Ice";
			size = 20;
		};

		activation.link-fonts = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
			run ln -s /run/current-system/sw/share/X11/fonts ${config.xdg.dataHome}/fonts 2>/dev/null
		'';

		sessionVariables = {
			GTK_THEME = config.gtk.theme.name;
			ICON_THEME = config.gtk.iconTheme.name;
			HYPRCURSOR_THEME = config.home.pointerCursor.name;
			HYPRCURSOR_SIZE = 20;
			KRITA_NO_STYLE_OVERRIDE = 1;
		};
	};

	qt = {
		enable = true;
		platformTheme.name = "kvantum";
		style.name = "kvantum";
	};

	wayland.windowManager.hyprland.settings.plugin.hyprfocus.bar_text_font = config.gtk.font.name;
}
