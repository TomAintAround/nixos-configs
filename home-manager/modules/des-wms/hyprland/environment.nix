{
	wayland.windowManager.hyprland.settings = {
		env = [
			# Toolkit Backend
			"GDK_BACKEND=wayland,x11"
			"QT_QPA_PLATFORM=wayland;xcb"
			"QT_AUTO_SCREEN_SCALE_FACTOR,1"
			"SDL_VIDEODRIVER=wayland" # if experiencing issues, replace with "x11"
			"CLUTTER_BACKEND=wayland"

			# XDG Variables
			"XDG_CURRENT_DESKTOP,Hyprland"
			"XDG_SESSION_TYPE,wayland"
			"XDG_SESSION_DESKTOP,Hyprland"

			# Hyprland
			"HYPRLAND_TRACE,1"
		];
	};
}
