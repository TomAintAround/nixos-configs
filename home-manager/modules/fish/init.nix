{ pkgs, config, ... }: {
	programs.fish.interactiveShellInit = ''
${pkgs.bash}/bin/bash "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" 2>/dev/null

# Greeting
set fish_greeting ""

# Vi Mode
fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

# Keybindings
bind \cf 'commandline -f kill-whole-line && lf && commandline -f execute'
bind -M insert \cf 'commandline -f kill-whole-line && lf && commandline -f execute'
bind -M visual \cf 'commandline -f kill-whole-line && lf && commandline -f execute'
bind \ce 'commandline -f kill-whole-line && $EDITOR . && commandline -f execute'
bind -M insert \ce 'commandline -f kill-whole-line && $EDITOR . && commandline -f execute'
bind -M visual \ce 'commandline -f kill-whole-line && $EDITOR . && commandline -f execute'

# Done Plugin
set -a __done_exclude '^pgrep'

${
	if config.programs.tmux.enable then ''
# Tmux
set tmuxSession default
if ! tmux has-session -t $tmuxSession 2>/dev/null
	tmux new-session -d -s $tmuxSession
end
tmux attach-session -t $tmuxSession 2>/dev/null
		''
	else "# Tmux is disabled"
}
	'';
}
