{
  programs.yazi.keymap.mgr.prepend_keymap = [
    # Disable tab keymaps
    {
      on = "<C-c>";
      run = "noop";
    }
    {
      on = "t";
      run = "noop";
    }
    {
      on = "[";
      run = "noop";
    }
    {
      on = "]";
      run = "noop";
    }
    {
      on = "{";
      run = "noop";
    }
    {
      on = "}";
      run = "noop";
    }

    # Bookmarks
    {
      on = ["g" "r"];
      run = "cd /";
      desc = "Go to /";
    }
    {
      on = ["g" "e"];
      run = "cd /etc";
      desc = "Go to /etc";
    }
    {
      on = ["g" "n"];
      run = "cd /etc/nixos";
      desc = "Go to /etc/nixos";
    }
    {
      on = ["g" "h"];
      run = "cd ~";
      desc = "Go to ~";
    }
    {
      on = ["g" "c"];
      run = "cd ~/.config";
      desc = "Go to ~/.config";
    }
    {
      on = ["g" "l"];
      run = "cd ~/.local";
      desc = "Go to ~/.local";
    }
    {
      on = ["g" "v"];
      run = "cd ~/.var/app";
      desc = "Go to ~/.var/app";
    }
    {
      on = ["g" "t"];
      run = "cd ~/Documents";
      desc = "Go to ~/Documents";
    }
    {
      on = ["g" "d"];
      run = "cd ~/Downloads";
      desc = "Go to ~/Downloads";
    }
    {
      on = ["g" "p"];
      run = "cd ~/Pictures";
      desc = "Go to ~/Pictures";
    }

    # Relative motions plugin
    {
      on = ["1"];
      run = "plugin relative-motions 1";
      desc = "Move in relative steps";
    }
    {
      on = ["2"];
      run = "plugin relative-motions 2";
      desc = "Move in relative steps";
    }
    {
      on = ["3"];
      run = "plugin relative-motions 3";
      desc = "Move in relative steps";
    }
    {
      on = ["4"];
      run = "plugin relative-motions 4";
      desc = "Move in relative steps";
    }
    {
      on = ["5"];
      run = "plugin relative-motions 5";
      desc = "Move in relative steps";
    }
    {
      on = ["6"];
      run = "plugin relative-motions 6";
      desc = "Move in relative steps";
    }
    {
      on = ["7"];
      run = "plugin relative-motions 7";
      desc = "Move in relative steps";
    }
    {
      on = ["8"];
      run = "plugin relative-motions 8";
      desc = "Move in relative steps";
    }
    {
      on = ["9"];
      run = "plugin relative-motions 9";
      desc = "Move in relative steps";
    }

    # Chmod plugin
    {
      on = "<C-m>";
      run = "plugin chmod";
      desc = "Chmod on selected files";
    }

    # Compression plugin
    {
      on = "<C-c>";
      run = "plugin compress";
      desc = "Archive selected files";
    }

    # Misc
    {
      on = "<C-d>";
      run = "shell -- ripdrag -x -i \"$1\"";
      desc = "Open drag and drop window";
    }
    {
      on = "<C-e>";
      run = "shell -- aunpack \"$@\"";
      desc = "Extract files from selected file";
    }
  ];
}
