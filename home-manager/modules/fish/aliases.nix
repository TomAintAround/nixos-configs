{ pkgs, config, ... }: {
	programs.fish = {
		functions = {
			reload = {
				description = "Reload fish";
				body = "clear && exec fish";
			};

			arduino-eject = {
				description = "Compile and upload arduino file into Arduino and open the serial monitor";
				body = ''
set file $argv[1]
set usb $argv[2]
set fqbn $argv[3]

arduino-cli compile --fqbn $fqbn $file
and arduino-cli upload -p $usb --fqbn $fqbn $file
and arduino-cli monitor -p $usb --fqbn $fqbn
				'';
			};

			flatclean = {
				description = "Removes orphaned flatpaks";
				body = ''
${pkgs.flatpak}/bin/flatpak uninstall --unused | grep -E 'Nothing unused to uninstall|Nada sin usar que desinstalar' >/dev/null
and printf '\n\\033[31;1m[ ERROR]\\033[0m Nothing to uninstall\n'
or ${pkgs.flatpak}/bin/flatpak uninstall --unused $argv
				'';
			};

			flatcountapp = {
				description = "Counts how many flatpak apps there are";
				body = "printf '\n\\033[36;1m[󰋼 INFO]\\033[0m You have '(${pkgs.flatpak}/bin/flatpak list --app | count)' flatpak applications\n' $argv";
			};

			flatcount = {
				description = "Counts how many flatpaks there are";
				body = "printf '\n\\033[36;1m[󰋼 INFO]\\033[0m You have '$(${pkgs.flatpak}/bin/flatpak list | count)' flatpaks\n' $argv";
			};

			flatcountrun = {
				description = "Counts how many flatpak runtimes there are";
				body = "printf '\n\\033[36;1m[󰋼 INFO]\\033[0m You have '$(${pkgs.flatpak}/bin/flatpak list --runtime | count)' flatpak runtimes\n' $argv";
			};

			flatinfo = {
				description = "Prints info about a flatpak";
				body = "${pkgs.flatpak}/bin/flatpak info $argv";
			};

			flatins = {
				description = "Installs a flatpak";
				body = "${pkgs.flatpak}/bin/flatpak install flathub $argv";
			};

			flatkill = {
				description = "Kills a flatpak";
				body = "${pkgs.flatpak}/bin/flatpak kill $argv";
			};

			flatrem = {
				description = "Uninstalls a flatpak";
				body = "${pkgs.flatpak}/bin/flatpak uninstall $argv";
			};

			flatrun = {
				description = "Runs a flatpak";
				body = "${pkgs.flatpak}/bin/flatpak run $argv";
			};

			flatsear = {
				description = "Searches for a flatpak";
				body = "${pkgs.flatpak}/bin/flatpak search $argv";
			};

			flatsearins = {
				description = "Searches for an installed flatpak";
				body = "${pkgs.flatpak}/bin/flatpak list $argv";
			};

			flatup = {
				description = "Update flatpaks";
				body = "${pkgs.flatpak}/bin/flatpak update $argv";
			};
		} // (if (config.fileManager == "yazi") then {
			yazi = {
				description = "Open yazi and change directory";
				body = ''
set tmp (mktemp -t "yazi-cwd.XXXXXX")
${pkgs.yazi}/bin/yazi $argv --cwd-file="$tmp"
if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
	cd -- "$cwd"
end
rm -f -- "$tmp"
				'';
			};

		} else {});

		shellAliases = {
			"cat" = "${pkgs.bat}/bin/bat --paging=never";
			"less" = "${pkgs.bat}/bin/bat --paging=always";
			"ls" = "${pkgs.eza}/bin/eza --git --icons=always --long --all --group --header --links --color=always --no-quotes --smart-group --group-directories-first --time-style='+%H:%m %d/%m/%y'";
			"man" = "${pkgs.bat-extras.batman}/bin/batman";
		} // (
			if (config.fileManager == "lf") then (
				if (config.terminal == "alacritty" || config.programs.tmux.enable) then
					{ "lf" = "cd \"$(${config.xdg.configHome}/lf/lfimg -print-last-dir)\""; }
				else 
					{ "lf" = "cd \"$(command lf -print-last-dir $argv)\""; }
			) else {}
		);
	};
}
