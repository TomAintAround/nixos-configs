{ config, ... }: {
    wayland.windowManager.hyprland.settings = {
	monitor = builtins.map (
	    m:
	    let
		screen = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
		coordinates = "${toString m.x}x${toString m.y}";
	    in
		"${m.name}, ${if m.enable then "${screen}, ${coordinates}, ${toString m.scale}" else "disable"}"
	) (config.monitors);

	general = {
	    border_size = 2;
	    gaps_in = 1;
	    gaps_out = 2;
	    layout = "master";
	    resize_on_border = true;
	    allow_tearing = true;
	};

	decoration = {
	    rounding = 10;
	    shadow_range = 15;
	    shadow_render_power = 2;
	    "col.shadow" = "rgba(00000080)";
	    shadow_offset = "7 7";
	    dim_inactive = false;
	    dim_strength = 0.1;
	    blur = {
		size = 7;
		passes = 2;
	    };
	};

	animations = {
	    enabled = true;
	    bezier = [
		"win, 0.3, 0.9, 0.5, 1.1"
		"winIn, 0.7, 1.1, 0.1, 1.1"
		"winOut, 0.35, -0.3, 0.25, 1"
		"liner, 1, 1, 1, 1"
		"fade, 0, 0.7, 0.3, 1"
	    ];
	    animation = [
		"windowsIn, 1, 3, winIn, slide"
		"windowsOut, 1, 5, winOut, slide"
		"windowsMove, 1, 5, win, slide"
		"layersIn, 1, 3, winIn, slide"
		"layersOut, 1, 5, winIn, slide"
		"fade, 0, 3, fade"
		"border, 1, 4, liner"
		"borderangle, 1, 30, liner, loop"
		"workspaces, 1, 5, win, slidevert"
	    ];
	};

	input = {
	    kb_model = "QWERTY";
	    kb_layout = "pt,es";
	    numlock_by_default = true;
	    follow_mouse = 1;
	};

	gestures = {
	    workspace_swipe = true;
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

	cursor = {
	    no_hardware_cursors = true;
	};

	master = {
	    mfact = 0.5;
	};
    };
}