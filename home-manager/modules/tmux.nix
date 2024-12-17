{ pkgs, config, ... }: {
	home.packages = [ pkgs.tmux ];
	programs.tmux = {
		enable = true;
		extraConfig = ''
			# Settings
			set -g base-index 1
			setw -g pane-base-index 1
			setw -g display-panes-time 2000
			set -g mouse on
			set -g renumber-windows on
			set -g set-titles on
			set -g default-terminal "tmux-256color"
			set -sg terminal-overrides ",*:RGB"
			set -g mode-keys vi
			set -g status-keys vi
			set -g status-interval 1
			set -g clock-mode-style 24
			set -g escape-time 0
			set-option -g status-position top

			# Keybindings
			unbind t
			unbind x
			unbind c
			unbind \[
			bind-key -T root C-M-y copy-mode
			bind-key -T root C-M-s kill-pane
			bind-key -T root C-M-w new-window
			bind-key -T root C-M-h previous-window
			bind-key -T root C-M-l next-window
		'';
		plugins = with pkgs.tmuxPlugins; [
			tmux-fzf
		];
	};
}
