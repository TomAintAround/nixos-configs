{
  pkgs,
  config,
  ...
}: {
  programs.fish = {
    functions =
      {
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
          wraps = "${pkgs.flatpak}/bin/flatpak uninstall --unused";
          body = "${pkgs.flatpak}/bin/flatpak uninstall --unused";
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
          wraps = "${pkgs.flatpak}/bin/flatpak info";
          body = "${pkgs.flatpak}/bin/flatpak info $argv";
        };

        flatins = {
          description = "Installs a flatpak";
          wraps = "${pkgs.flatpak}/bin/flatpak install flathub";
          body = "${pkgs.flatpak}/bin/flatpak install flathub $argv";
        };

        flatkill = {
          description = "Kills a flatpak";
          wraps = "${pkgs.flatpak}/bin/flatpak kill";
          body = "${pkgs.flatpak}/bin/flatpak kill $argv";
        };

        flatlist = {
          description = "Searches for an installed flatpak";
          body = "${pkgs.flatpak}/bin/flatpak list $argv";
        };

        flatrem = {
          description = "Uninstalls a flatpak";
          wraps = "${pkgs.flatpak}/bin/flatpak uninstall";
          body = "${pkgs.flatpak}/bin/flatpak uninstall $argv";
        };

        flatrun = {
          description = "Runs a flatpak";
          wraps = "${pkgs.flatpak}/bin/flatpak run";
          body = "${pkgs.flatpak}/bin/flatpak run $argv";
        };

        flatsear = {
          description = "Searches for a flatpak";
          wraps = "${pkgs.flatpak}/bin/flatpak search";
          body = "${pkgs.flatpak}/bin/flatpak search $argv";
        };

        flatup = {
          description = "Update flatpaks";
          wraps = "${pkgs.flatpak}/bin/flatpak update";
          body = "${pkgs.flatpak}/bin/flatpak update $argv";
        };

        packMgr = {
          description = "Package manager for NixOS and Flatpak";
          body = ''
            set -g exportConfigs "${config.xdg.userDirs.documents}/Personal/nixos-configs/export"
            set -g home ${config.xdg.configHome}/home-manager
            set -g homeFlake ${config.xdg.configHome}/Personal/nixos-configs/home-manager
            set -g system /etc/nixos
            set -g systemFlake ${config.xdg.userDirs.documents}/Personal/nixos-configs/system-config

            function fzfSelect
                command printf "%s\n" $argv | command ${pkgs.fzf}/bin/fzf \
                    --preview "" \
                    --tmux right,30
            end

            function nixOS
                if test "$argv[2]" = Rebuild
                    "$exportConfigs" system
                    command ${pkgs.nh}/bin/nh os switch --ask "$system"
                    commandline -f execute
                    return 1
                end

                if test "$argv[2]" = "Rebuild and upgrade"
                    command sudo nix flake update --flake "$systemFlake"
                    "$exportConfigs" system
                    command ${pkgs.nh}/bin/nh os switch --ask "$system"
                    commandline -f execute
                    return 1
                end

                if test "$argv[2]" = Search
                    commandline "${pkgs.nh}/bin/nh search "
                    return 1
                end

                if test "$argv[2]" = Clean
                    command ${pkgs.nh}/bin/nh clean
                    commandline -f execute
                    return 1
                end

                if test "$argv[2]" = Cancel
                    return 1
                end

                set -l list Rebuild "Rebuild and upgrade" Search Clean Cancel
                set -l selection (fzfSelect $list)
                packMgr $argv $selection
            end

            function homeManager
                if test "$argv[2]" = Rebuild
                    "$exportConfigs" home
                    command ${pkgs.nh}/bin/nh home switch --ask "$home"
                    commandline -f execute
                    return 1
                end

                if test "$argv[2]" = "Rebuild and upgrade"
                    command nix flake update --flake "$homeFlake"
                    "$exportConfigs" home
                    command ${pkgs.nh}/bin/nh home switch --ask "$home"
                    commandline -f execute
                    return 1
                end

                if test "$argv[2]" = Cancel
                    return 1
                end

                set -l list Rebuild "Rebuild and upgrade" Cancel
                set -l selection (fzfSelect $list)
                packMgr $argv $selection
            end

            function flatpak
                if test "$argv[2]" = Update
                    flatup
                    commandline -f execute
                    return 1
                end

                if test "$argv[2]" = Install
                    commandline "flatins "
                    return 1
                end

                if test "$argv[2]" = Clean
                    # This one in particular needs to be done like this,
                    # because the other way wouldn't let me press enter
                    commandline flatclean
                    and commandline -f execute
                    return 1
                end

                if test "$argv[2]" = Count
                    flatcount
                    commandline -f execute
                    return 1
                end

                if test "$argv[2]" = "Count apps"
                    flatcountapp
                    commandline -f execute
                    return 1
                end

                if test "$argv[2]" = "Count runtimes"
                    flatcountrun
                    commandline -f execute
                    return 1
                end

                if test "$argv[2]" = "Package information"
                    commandline "flatinfo "
                    return 1
                end

                if test "$argv[2]" = Kill
                    commandline "flatkill "
                    return 1
                end

                if test "$argv[2]" = List
                    flatlist
                    commandline -f execute
                    return 1
                end

                if test "$argv[2]" = Uninstall
                    commandline "flatrem "
                    return 1
                end

                if test "$argv[2]" = Run
                    commandline "flatrun "
                    return 1
                end

                if test "$argv[2]" = Search
                    commandline "flatsear "
                    return 1
                end

                if test "$argv[2]" = Cancel
                    return 1
                end

                set -l list \
                    Update \
                    Install \
                    Clean \
                    Count \
                    "Count apps" \
                    "Count runtimes" \
                    "Package information" \
                    Kill \
                    List \
                    Uninstall \
                    Run \
                    Search \
                    Cancel
                set -l selection (fzfSelect $list)
                packMgr $argv $selection
            end

            if test "$argv[1]" = NixOS
            	nixOS $argv
            	return 1
            end

            if test "$argv[1]" = Home-Manager
            	homeManager $argv
            	return 1
            end

            if test "$argv[1]" = Flatpak
            	flatpak $argv
            	return 1
            end

            if test "$argv[1]" = Cancel
            	return 1
            end

            set -l initialList NixOS Home-Manager Flatpak Cancel
            set -l selection (fzfSelect $initialList)
            packMgr $selection
          '';
        };
      }
      // (
        if (config.fileManager == "yazi")
        then {
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
        }
        else {}
      );

    shellAliases =
      {
        "cat" = "${pkgs.bat}/bin/bat --paging=never";
        "less" = "${pkgs.bat}/bin/bat --paging=always";
        "ls" = "${pkgs.eza}/bin/eza --git --icons=always --long --all --group --header --links --color=always --no-quotes --smart-group --group-directories-first --time-style='+%H:%m %d/%m/%y'";
        "man" = "${pkgs.bat-extras.batman}/bin/batman";
      }
      // (
        if (config.fileManager == "lf")
        then
          (
            if (config.terminal == "alacritty" || config.programs.tmux.enable)
            then {"lf" = "cd \"$(${config.xdg.configHome}/lf/lfimg -print-last-dir)\"";}
            else {"lf" = "cd \"$(command lf -print-last-dir $argv)\"";}
          )
        else {}
      );
  };
}
