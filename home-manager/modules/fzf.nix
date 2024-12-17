{ pkgs, ... }: {
	programs.fzf = {
		enable = true;
		defaultCommand = "${pkgs.fd}/bin/fd --type f";
		defaultOptions = [
			"--ansi"
			"--layout reverse"
			"--preview-window 'right:60%'"
			"--preview-label ' Preview '"
			"--preview '${pkgs.bat}/bin/bat --paging=never --color=always --wrap=never --style=header,grid,numbers --line-range :50 {}'"
			"--tmux 80%"
		];

		fileWidgetCommand = "${pkgs.fd}/bin/fd --type f";
		fileWidgetOptions = [
			"--border-label ' Select a file to be pasted into the command line '"
		];

		changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";
		changeDirWidgetOptions = [
			"--border-label ' Select a directory to navigate to '"
			"--preview '${pkgs.eza}/bin/eza --git --icons=always --long --all --group --header --links --color=always --no-quotes --smart-group --group-directories-first --time-style=\'+%H:%m_%d/%m/%y\' {} | head -n 50'"
		];

		historyWidgetOptions = [
			"--border-label ' Select a command to be pasted into the command line '"
			"--preview-window '0%'"
		];
	};
}
