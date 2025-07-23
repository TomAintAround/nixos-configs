{
	wayland.windowManager.hyprland.settings = {
		windowrule = [
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

			"noanim,class:^ueberzugpp.*"
			"noshadow,class:^ueberzugpp.*"
			"noborder,class:^ueberzugpp.*"
			"plugin:hyprbars:nobar,class:^ueberzugpp.*"

			"bordersize 0, floating:0, onworkspace:w[tv1]s[false]"
			"rounding 0, floating:0, onworkspace:w[tv1]s[false]"
			"bordersize 0, floating:0, onworkspace:f[1]s[false]"
			"rounding 0, floating:0, onworkspace:f[1]s[false]"
		];
		workspace = [
			"w[tv1]s[false], gapsout:0, gapsin:0"
			"f[1]s[false], gapsout:0, gapsin:0"
		];
	};
}
