{ config, ... }: {
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
set -g focus-events on
set -g status-position top
set -g allow-passthrough on
set -ga update-environment TERM
set -ga update-environment TERM_PROGRAM

unbind t
unbind x
unbind c
unbind \[
bind-key -T root C-M-y copy-mode
bind-key -T root C-M-s kill-pane
bind-key -T root C-M-w new-window
bind-key -T root C-M-h previous-window
bind-key -T root C-M-l next-window
bind-key -T root C-M-n run-shell "tmux new-session -d"
bind-key -T root C-M-f run-shell "bash ${config.xdg.configHome}/home-manager/modules/tmux/sessions.sh"
		'';
	};
      # Keybinds
      set -g prefix C-a
}
