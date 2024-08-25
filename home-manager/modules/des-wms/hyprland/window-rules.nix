{
    wayland.windowManager.hyprland.settings = {
	windowrulev2 = [
	    "float,class:^(music)$"
	    "size 86% 660px,class:^(music)$"
	    "move 7% 35,class:^(music)$"
	    "animation slide windows,class:^(music)$"
	    "pin,class:^(music)$"
	    "suppressevent[fullscreen],class:^(music)$"

	    "float,class:^(btop)$"
	    "size 80% 95%,class:^(btop)$"
	    "move 10% 35,class:^(btop)$"
	    "animation slidefade 0%,class:^(btop)$"
	    "pin,class:^(btop)$"
	    "suppressevent[fullscreen],class:^(btop)$"

	    "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
	    "noanim,class:^(xwaylandvideobridge)$"
	    "nofocus,class:^(xwaylandvideobridge)$"
	    "noinitialfocus,class:^(xwaylandvideobridge)$"

	    "noanim,class:^(ueberzugpp)"
	    "noshadow,class:^(ueberzugpp)"
	    "noborder,class:^(ueberzugpp)"
	    "plugin:hyprbars:nobar,class:^(ueberzugpp)"
	];
    };
}
