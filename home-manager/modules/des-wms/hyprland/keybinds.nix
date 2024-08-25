{ pkgs, config, inputs, lib, ... }:
let
    cfg = config.wayland.windowManager.hyprland;
    split-monitor-workspaces = inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces;
in {
    wayland.windowManager.hyprland.settings = {
	bind = [
	    # Hyprland keybinds
	    "SUPER SHIFT, Q, killactive,"
	    "SUPER SHIFT, BackSpace, exit,"
	    "SUPER, V, togglefloating,"
	    "SUPER, P, pseudo," # dwindle
	    "SUPER, G, layoutmsg, addmaster"
	    "SUPER, Y, layoutmsg, removemaster"
	    "SUPER, F, fullscreen, 0"
	    "SUPER, M, fullscreen, 1"
	    "SUPER, R, exec, ${pkgs.hyprland}/bin/hyprpm reload -n"
	    "SUPER, U, exec, ${pkgs.hyprland}/bin/hyprpm update -n"
	    (let
		changeLayout = pkgs.writeShellScriptBin "changeLayout.bash" ''
		    ###################################################################################################################
		    # https://github.com/arcolinux/arcolinux-hyprland/blob/main/etc/skel/.config/hypr/scripts/changeLayout (modified) #
		    ###################################################################################################################

		    LAYOUT=$(${pkgs.hyprland}/bin/hyprctl -j getoption general:layout | ${pkgs.jq}/bin/jq '.str' | sed 's/"//g')

		    case "$LAYOUT" in
		    "master")
			${pkgs.hyprland}/bin/hyprctl keyword general:layout dwindle
			${pkgs.libnotify}/bin/notify-send --app-name="Layout change" "Dwindle Layout"
			;;
		    "dwindle")
			${pkgs.hyprland}/bin/hyprctl keyword general:layout master
			${pkgs.libnotify}/bin/notify-send --app-name="Layout change" "Master Layout"
			;;
		    *) ;;
		    esac
		'';
	    in
		"SUPER, S, exec, ${lib.getExe changeLayout}")

	    # Apps keybinds
	    "SUPER, Return, exec, ${pkgs.alacritty}/bin/alacritty"
	    "SUPER, C, exec, ${pkgs.clipman}/bin/clipman pick -t rofi -T'-theme ${config.xdg.configHome}/rofi/clipboard.rasi'"
	    "SUPER, Space, exec, ${pkgs.rofi}/bin/rofi -show drun -modi drun,window -theme ~/.config/rofi/launcher.rasi -show-icons -icon-theme Papirus-Dark"
	    "SUPER, F1, exec, ${pkgs.firefox}/bin/firefox -p"
	    "SUPER, F2, exec, ${pkgs.vesktop}/bin/vesktop"
	    "SUPER, F3, exec, ${pkgs.obsidian}/bin/obsidian"
	    "SUPER, F4, exec, ${pkgs.thunderbird}/bin/thunderbird"
	    "SUPER, F5, exec, ${pkgs.newsflash}/bin/io.gitlab.news_flash.NewsFlash"
	    "${if config.gaming.enable then "SUPER, F6, exec, ${pkgs.lutris}/bin/lutris" else ""}"
	    "SUPER, F10, exec, ${pkgs.hyprpicker}/bin/hyprpicker -a"
	    "SUPER, F11, exec, ${pkgs.alacritty}/bin/alacritty --class music -e ncmpcpp"
	    "SUPER, F12, exec, ${pkgs.alacritty}/bin/alacritty --class btop -e btop"
	    ",Print, exec, ${pkgs.grimblast}/bin/grimblast --notify --cursor --freeze copy area"

	    # Move focus
	    "SUPER, H, movefocus, l"
	    "SUPER, L, movefocus, r"
	    "SUPER, K, movefocus, u"
	    "SUPER, J, movefocus, d"

	    # Move windows
	    "SUPER SHIFT, H, movewindow, l"
	    "SUPER SHIFT, L, movewindow, r"
	    "SUPER SHIFT, K, movewindow, u"
	    "SUPER SHIFT, J, movewindow, d"

	    # Scroll through existing workspaces
	    "SUPER, mouse_down, workspace, e+1"
	    "SUPER, mouse_up, workspace, e-1"
	]
	++
	(builtins.concatLists (builtins.genList (
	    n: let
		split = "${if (builtins.elem split-monitor-workspaces cfg.plugins) then "split-" else ""}";
		ws = let
		    c = (n + 1) / 10;
		in
		    builtins.toString (n + 1 - (c * 10));
	    in [
		"SUPER, ${ws}, ${split}workspace, ${ws}"
		"SUPER SHIFT, ${ws}, ${split}movetoworkspace, ${ws}"
	    ]) 
	(if (builtins.elem split-monitor-workspaces cfg.plugins) then (cfg.numOfWorkspaces / 2) else cfg.numOfWorkspaces) ))
	++
	# I know what you're thinking: "What the hell am I reading? What kind of spaguetti mess is this?".
	# You think this sucks? THEN MAKE IT BETTER YOURSELF AND MAKE A PULL REQUEST. Let's see if you can
	# (please do it I beg you).
	(let
	    enabledMonitors = lib.lists.remove {} (builtins.map
		(m: if m.enable then { inherit (m) name x y; } else {})
		config.monitors);

	    length = builtins.length enabledMonitors;

	    sameXCoord = ((builtins.map (m: m.x) enabledMonitors) == (builtins.genList (x: 0) length));
	    coordinates_x = builtins.sort builtins.lessThan (builtins.map (m: m.x) enabledMonitors);
	    coordinates_y = builtins.sort builtins.lessThan (builtins.map (m: m.y) enabledMonitors);
	    coordinates =
		if sameXCoord
		    then coordinates_y
		else coordinates_x;
	    axis = "${if coordinates == coordinates_x then "x" else "y"}";

	    monSelector =
		n:
		    builtins.foldl' (x: y: x + y) "" (lib.lists.remove "" (builtins.map (
			m:
			    if (builtins.elemAt coordinates (n - 1)) == m.x
				then "${m.name}"
			    else ""
		    ) enabledMonitors));

	    firstMon = monSelector 1;
	    secondMon = monSelector 2;
	    thirdMon = monSelector 3;
	    fourthMon = monSelector 4;
	in
	    if coordinates != (lib.lists.unique coordinates)
		then throw "If your monitors are vertically distributed, each one must have a unique ordinate. If not, each one must have a unique abscissa"
	    else if length == 1
		then []
	    else if length == 2
		then [
		    "SUPER ALT, H, focusmonitor, ${firstMon}"
		    "SUPER ALT, L, focusmonitor, ${secondMon}"
		    "SUPER ALT SHIFT, H, movewindow, mon:${firstMon}"
		    "SUPER ALT SHIFT, L, movewindow, mon:${secondMon}"
		]
	    else if length == 3
		then [
		    "SUPER ALT, H, focusmonitor, ${firstMon}"
		    "SUPER ALT, K, focusmonitor, ${secondMon}"
		    "SUPER ALT, L, focusmonitor, ${thirdMon}"
		    "SUPER ALT SHIFT, H, movewindow, mon:${firstMon}"
		    "SUPER ALT SHIFT, K, movewindow, mon:${secondMon}"
		    "SUPER ALT SHIFT, L, movewindow, mon:${thirdMon}"
		]
	    else if length == 4
		then [
		    "SUPER ALT, H, focusmonitor, ${firstMon}"
		    "SUPER ALT, J, focusmonitor, ${secondMon}"
		    "SUPER ALT, K, focusmonitor, ${thirdMon}"
		    "SUPER ALT, L, focusmonitor, ${fourthMon}"
		    "SUPER ALT SHIFT, H, movewindow, mon:${firstMon}"
		    "SUPER ALT SHIFT, J, movewindow, mon:${secondMon}"
		    "SUPER ALT SHIFT, K, movewindow, mon:${thirdMon}"
		    "SUPER ALT SHIFT, L, movewindow, mon:${fourthMon}"
		]
	    else throw "WHAT THE HELL ARE YOU DOING WITH 5+ MONITORS???????");

	# Audio keybinds
	bindel = [
	    ",XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
	    ",XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
	];
	bindl = [
	    ",XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
	    ",XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
	    ",XF86AudioNext, exec, ${pkgs.wireplumber}/bin/playerctl next"
	    ",XF86AudioPrev, exec, ${pkgs.wireplumber}/bin/playerctl previous"
	    ",XF86AudioStop, exec, ${pkgs.wireplumber}/bin/playerctl stop"
	];
	
	# Resize windows
	binde = [
	    "SUPER CTRL, H, resizeactive, -10 0"
	    "SUPER CTRL, L, resizeactive, 10 0"
	    "SUPER CTRL, K, resizeactive, 0 -10"
	    "SUPER CTRL, J, resizeactive, 0 10"
	];

	# Move/resize windows
	bindm = [
	    "SUPER, mouse:272, movewindow"
	    "SUPER, mouse:273, resizewindow"
	];
    };
}
