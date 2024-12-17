{
	programs.alacritty = {
		enable = true;
		settings = {
			env.TERM = "xterm-256color";

			window.padding = {
				x = 5;
				y = 5;
			};

			font = {
				size = 13.0;
				normal.family = "JetBrains Mono Nerd Font";
			};

			cursor = {
				vi_mode_style = "None";
				style = {
					blinking = "Never";
					shape = "Beam";
				};
			};
		};
	};
}
