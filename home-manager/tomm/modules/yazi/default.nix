{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    ffmpeg-full # for video thumbnails
    atool
    unzip
    zip # for archive extraction and preview
    jq # for JSON preview
    poppler # for PDF preview
    fd # for file searching
    ripgrep # for file content searching
    fzf # for quick file subtree navigation, >= 0.53.0
    zoxide # for historical directories navigation, requires fzf
    resvg # for SVG preview
    imagemagick # for Font, HEIC, and JPEG XL preview
    ripdrag # for drag and drop

    # Plugin dependencies
    rich-cli
  ];

  programs.yazi = {
    enable = true;
    plugins = with pkgs.yaziPlugins; {
      inherit chmod full-border git relative-motions rich-preview compress;
    };
    initLua = ./init.lua;

    settings = {
      mgr = {
        ratio = [1 2 3];
        sort_by = "natural";
        sort_reverse = false;
        sort_dir_first = true;
        sort_translit = true;
        linemode = "size";
        show_hidden = true;
        show_symlink = true;
        scrolloff = 8;
        title_format = "{cwd}";
      };
      preview = {
        wrap = "no";
        max_width = 1920;
        max_height = 1080;
        tab_size = 4;
      };
      opener.play = [
        {
          run = "$VIDEO_PLAYER \"$@\"";
          orphan = true;
          desc = "Play";
        }
      ];
      input.cursor_blink = true;
      plugin = {
        prepend_previewers = [
          {
            name = "*.csv";
            run = "rich-preview";
          }
          {
            name = "*.md";
            run = "rich-preview";
          }
          {
            name = "*.rst";
            run = "rich-preview";
          }
          {
            name = "*.ipynb";
            run = "rich-preview";
          }
          {
            name = "*.json";
            run = "rich-preview";
          }
          {
            mime = "audio/*";
            run = "exifaudio";
          }
        ];
        prepend_fetchers = [
          {
            id = "git";
            name = "*";
            run = "git";
          }
          {
            id = "git";
            name = "*/";
            run = "git";
          }
        ];
      };
    };

    keymap.mgr.prepend_keymap = [
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
        desc = "Go to the root directory";
      }
      {
        on = ["g" "e"];
        run = "cd /etc";
        desc = "Go to /etc";
      }
      {
        on = ["g" "n"];
        run = "cd /etc/nixos";
        desc = "Go to NixOS's configurations";
      }
      {
        on = ["g" "h"];
        run = "cd ~";
        desc = "Go to the home directory";
      }
      {
        on = ["g" "c"];
        run = "cd ${config.xdg.configHome}";
        desc = "Go to the configurations directory";
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
        run = "cd ${config.xdg.userDirs.documents}";
        desc = "Go to the Documents directory";
      }
      {
        on = ["g" "d"];
        run = "cd ${config.xdg.userDirs.download}";
        desc = "Go to the Downloads directory";
      }
      {
        on = ["g" "p"];
        run = "cd ${config.xdg.userDirs.pictures}";
        desc = "Go to the Pictures directory";
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
  };
}
