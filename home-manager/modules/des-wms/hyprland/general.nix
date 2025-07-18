{ config, ... }: {
	wayland.windowManager.hyprland.settings = {
		monitor = builtins.map (
			m: let
				screen = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
				coordinates = "${toString m.x}x${toString m.y}";
			in
				"${m.name}, ${if m.enable then "${screen}, ${coordinates}, ${toString m.scale}, bitdepth, 8" else "disable"}"
		) (config.monitors);

		general = {
			border_size = 2;
			gaps_in = 1;
			gaps_out = 2;
			layout = "master";
			resize_on_border = true;
			allow_tearing = true;
			snap.enabled = true;
		};

		decoration = {
			rounding = 10;
			dim_inactive = false;
			dim_strength = 0.1;
			blur = {
				size = 7;
				passes = 2;
			};
			shadow = {
				color = "rgba(00000080)";
				range = 15;
				render_power = 2;
				offset = "7 7";
			};
		};

		animations = {
			enabled = true;
			bezier = [
				"win, 0.3, 0.9, 0.5, 1.1"
				"winIn, 0.7, 1.1, 0.1, 1.1"
				"winOut, 0.35, -0.3, 0.25, 1"
				"liner, 1, 1, 1, 1"
			];
			animation = [
				"windowsIn, 1, 3, winIn, gnomed"
				"windowsOut, 1, 5, winOut, gnomed"
				"windowsMove, 1, 5, win, gnomed"
				"layersIn, 1, 3, winIn, gnomed"
				"layersOut, 1, 5, winIn, gnomed"
				"border, 1, 4, liner"
				"borderangle, 1, 30, liner, loop"
				"workspaces, 1, 5, win, slidevert"
			];
		};

		input = {
			kb_model = "QWERTY";
			kb_layout = "pt,es";
			kb_options = "grp:alt_shift_toggle";
			numlock_by_default = true;
			follow_mouse = 1;

			touchpad = {
				natural_scroll = true;
				scroll_factor = 0.50;
			};
		};

		gestures = {
			workspace_swipe = true;
			workspace_swipe_distance = 200;
		};

		misc = {
			disable_hyprland_logo = true;
			disable_splash_rendering = true;
			mouse_move_enables_dpms = true;
			key_press_enables_dpms = true;
		};

		binds = {
			workspace_back_and_forth = false;
		};

		xwayland.force_zero_scaling = true;

		cursor = {
			no_hardware_cursors = true;
			default_monitor = let
				monitor = builtins.elemAt (builtins.filter (m: m.default) config.monitors) 0;
			in monitor.name;
		};

		ecosystem.no_donation_nag = true;

		master = {
			mfact = 0.5;
		};

		workspace = [
			"w[tv1]s[false], gapsout:0, gapsin:0"
			"f[1]s[false], gapsout:0, gapsin:0"
		];

		windowrule = [
			"bordersize 0, floating:0, onworkspace:w[tv1]s[false]"
			"rounding 0, floating:0, onworkspace:w[tv1]s[false]"
			"bordersize 0, floating:0, onworkspace:f[1]s[false]"
			"rounding 0, floating:0, onworkspace:f[1]s[false]"
		];
	};
}
