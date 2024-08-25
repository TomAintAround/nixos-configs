# Greeting
set fish_greeting "                                    
             [38;2;7;83;89m.[38;2;15;173;193ml[38;2;15;172;193mlllllllllllllll[38;2;15;173;193ml[38;2;5;53;57m.    [0m╭──────────────────╮
            [38;2;6;60;65m.[38;2;17;200;225md[38;2;17;194;226md[38;2;17;195;226mddddddddddddd[38;2;17;197;226md[38;2;4;46;51m.      [0m│ [31;1m  User[0m          │  [31;5m$USER@$hostname
           [38;2;4;41;44m.[38;2;17;198;221md[38;2;17;195;226mddddddddddddd[38;2;17;197;226md         [0m├──────────────────┤
           [38;2;17;195;216mo[38;2;17;195;226mdddddddddddd[38;2;17;198;226md           [0m│ [32;1m  Distro[0m        │  [32;5m$(command cat /etc/os-release | command grep "PRETTY_NAME" | sed 's/.*=//' | tr -d '"')
          [38;2;16;189;207mo[38;2;17;195;226mddddddddddd[38;2;17;198;226md             [0m│ [33;1m  DE/WM[0m         │  [33;5m$XDG_CURRENT_DESKTOP
         [38;2;15;180;197ml[38;2;17;195;226mdddddddddd[38;2;16;187;213mo               [0m│ [34;1m󰏗  Packages[0m      │  [34;5m$(math (count /nix/store/*) + (command flatpak list | count))
        [38;2;14;169;183ml[38;2;17;196;227md[38;2;17;195;226mdddddddd[38;2;17;196;226md[38;2;17;204;226md[38;2;14;158;171mc[38;2;10;105;116m,[38;2;10;106;116m,,,,,,,[38;2;8;85;91m'      [0m├──────────────────┤
       [38;2;14;155;168mc[38;2;17;197;226md[38;2;17;195;226mdddddddddddddddddd[38;2;16;182;206mo        [0m│ [35;1m  Terminal[0m      │  [35;5m$(command echo $TERM | command sed 's/xterm-//')
      [38;2;12;141;151m:[38;2;17;198;226md[38;2;17;196;226mdddddd[38;2;17;195;226mddddddddddd[38;2;17;198;226md          [0m│ [36;1m  Terminal Font[0m │  [36;5m$(command echo $(command cat $HOME/.config/alacritty/alacritty.toml | command grep "family" | command sed 's/family = //' | sed 's/\"//g' | command perl -pe 's/\s+ //g') $(command cat $HOME/.config/alacritty/alacritty.toml | command grep "size" | command sed 's/size = //' | command perl -pe 's/\s+//g'))
             [38;2;8;96;102m'[38;2;17;200;227md[38;2;17;195;226mdddddddd[38;2;17;197;226md            [0m│ [31;1m  Shell[0m         │  [31;5m$(command ps --no-header --pid=$PPID --format=comm | command grep 'fish\|bash\|zsh')
             [38;2;17;194;213mo[38;2;17;195;226mddddddd[38;2;17;197;226md[38;2;4;49;55m.             [0m├──────────────────┤
            [38;2;11;129;138m;[38;2;17;197;226md[38;2;17;195;226mddddd[38;2;17;196;226md[38;2;6;74;82m.               [0m│ [32;1m  Theme[0m         │  [32;5m$GTK_THEME
            [38;2;17;203;226md[38;2;17;195;226mddddd[38;2;9;99;111m'                 [0m│ [33;1m  Font[0m          │  [33;5m$(command cat $HOME/.config/gtk-3.0/settings.ini | command grep gtk-font-name= | command sed 's/.*=//')
           [38;2;15;178;193ml[38;2;17;195;226mdddd[38;2;12;137;154m:                   [0m│ [34;1m  Icon Theme[0m    │  [34;5m$ICON_THEME
          [38;2;7;83;88m.[38;2;17;200;227md[38;2;17;195;226mdd[38;2;14;162;183ml                     [0m│ [35;1m󰇀  Cursor Theme[0m  │  [35;5m$XCURSOR_THEME
          [38;2;17;199;219md[38;2;17;195;226md[38;2;16;187;212mo                       [0m├──────────────────┤
         [38;2;13;153;165mc[38;2;17;199;226md                         [0m│ [36;1m󰏘  Colors[0m        │  [30;5m[0m [37;5m[0m  [31;5m[0m [32;5m[0m [33;5m[0m [34;5m[0m [35;5m[0m [36;5m
        [38;2;4;45;48m.                           [0m╰──────────────────╯
                                     "
