{ config, pkgs, lib, ... }: {
	wayland.windowManager.hyprland.settings = {
		"\$scriptsDir" = "${config.xdg.dataHome}/scripts";
		exec-once = [
			# Screensharing
			"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

			# Portals
			(let
				portal = pkgs.writeShellScriptBin "portal.bash" ''
#######################################################################
# https://wiki.hyprland.org/Useful-Utilities/Hyprland-desktop-portal/ #
#######################################################################

sleep 1
killall -e xdg-desktop-portal-hyprland
killall xdg-desktop-portal
${pkgs.xdg-desktop-portal-hyprland}/libexec/xdg-desktop-portal-hyprland &
sleep 2
${pkgs.xdg-desktop-portal}/libexec/xdg-desktop-portal &
				'';
			in
				"${lib.getExe portal}")

			# Polkit
			"${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"

			# Notification Daemon
			"${pkgs.systemd}/bin/systemctl --user start dunst.service"

			# Set wallpaper
			"${pkgs.swww}/bin/swww-daemon"
			"wallpaper-change startup"

			# Generate Album Arts
			"\$scriptsDir/albumart.bash"

			# MPD Playerctl Compatibility
			"${pkgs.mpd-mpris}/bin/mpd-mpris"

			# Clipboard Manager
			"${pkgs.wl-clipboard}/bin/wl-paste -t text --watch clipman store --no-persist"

			# Screenshot tool
			"${pkgs.flameshot.override { enableWlrSupport = true; }}/bin/flameshot"

			# Software for Peripherals
			"${if config.openrazer.enable then "${pkgs.polychromatic}/bin/polychromatic-tray-applet}" else "echo no"}"
			"${if config.openrgb.enable then "${pkgs.openrgb}/bin/openrgb --startminimized" else "echo no"}"

			# Easyeffects
			"${pkgs.systemd}/bin/systemctl --user start easyeffects.service"

			# KDE Connect Indicator
			"${pkgs.plasma5Packages.kdeconnect-kde}/bin/kdeconnect-indicator"
		];
	};
}
