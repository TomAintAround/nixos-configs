{ pkgs, ... }: {
    programs.fish.interactiveShellInit = ''
        ${pkgs.bash}/bin/bash "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" 2>/dev/null

        # Greeting
        source "$XDG_CONFIG_HOME/home-manager/modules/fish/greeting.fish"

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
        bind \cl 'commandline -f kill-whole-line && ls && commandline -f execute'
        bind -M insert \cl 'commandline -f kill-whole-line && ls && commandline -f execute'
        bind -M visual \cl 'commandline -f kill-whole-line && ls && commandline -f execute'

        # Done Plugin
        set -a __done_exclude '^pgrep'

	# Tmux
	for sessions in (${pkgs.tmux}/bin/tmux list-sessions | command grep -v "(attached)\|keep" | sed 's/:.*$//')
	    ${pkgs.tmux}/bin/tmux kill-session -t "$sessions"
	end

        if not set -q TMUX
            ${pkgs.tmux}/bin/tmux list-sessions | command grep -v "(attached)" &>/dev/null
            and exec ${pkgs.tmux}/bin/tmux attach
            or exec ${pkgs.tmux}/bin/tmux
        end
    '';
}
