{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    mpc
    spotdl
  ];

  services = {
    mpd = {
      enable = true;
      musicDirectory = config.xdg.userDirs.music;
      playlistDirectory = "${config.xdg.dataHome}/mpd/playlists";
      extraConfig = ''
        db_file			   "~/.local/share/mpd/database"
        log_file		   "~/.local/share/mpd/log"
        sticker_file	   "~/.local/share/mpd/sticker.sql"
        bind_to_address    "~/.local/share/mpd/socket"

        audio_output {
        	type			"pipewire"
        	name			"PipeWire Sound Server"
        }

        audio_output {
        	type					"fifo"
        	name					"mpd_visualizer"
        	path					"/tmp/mpd.fifo"
        	format					"44100:16:2"
        }
      '';
      network.startWhenNeeded = true;
    };

    mpd-mpris.enable = true;
    playerctld.enable = true;

    mpdscribble = {
      enable = true;
      endpoints."last.fm" = {
        username = "TomAintAround";
        passwordFile = "${config.xdg.dataHome}/mpdscribblePass";
      };
    };
  };

  programs.ncmpcpp = {
    enable = true;
    mpdMusicDir = config.xdg.userDirs.music;
    package = pkgs.ncmpcpp.override {
      visualizerSupport = true;
      clockSupport = true;
    };
    settings = {
      ncmpcpp_directory = "${config.xdg.configHome}/ncmpcpp";
      lyrics_directory = "${config.xdg.configHome}/ncmpcpp/lyrics/";

      mpd_host = "localhost";
      mpd_port = "6600";

      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "mpd_visualizer";
      visualizer_in_stereo = "yes";
      visualizer_type = "spectrum";
      # visualizer_look = " ";
      visualizer_fps = "75";
      visualizer_autoscale = "no";
      visualizer_color = "232, 256, 196, 160, 124, 88, 82, 46, 40";
      visualizer_spectrum_smooth_look = "yes";

      startup_screen = "visualizer";
      startup_slave_screen = "playlist";
      startup_slave_screen_focus = true;

      song_list_format = "$b$7%a$9$a$1 Q $9$/a$/b$u$5{%t}|{%f}$9$/u $R $8%b$9$b$a$1 TRU $9$/a$/b$3%l$9";
      song_status_format = "$b$a$1LU$9$/a $7{%a$9$/b $b$a$1Q$9$/a$/b $8%b}|{%D$/b}$9 $b$a$1Q$9$/a$/b $u$5{%t}|{%f}$9$/u $b$a$1TK$9$/a$/b";
      song_library_format = "$u$5{%t}|{%f}$9$/u $R $8%N$9$b$a$1 TRU $9$/a$/b$3%l$9";
      song_window_title_format = "{%a - }{%t}|{%f}";
      song_columns_list_format = "(35)[cyan]{ar} (35)[blue]{t|f:Title} (30)[white]{br} (4f)[green]{lr}";

      alternative_header_first_line_format = "$b$1$aMU$9$/a $u$5{%t}|{%f}$9$/u $1$aTJ$/a$9$/b";
      alternative_header_second_line_format = "$b$a$1LU$9$/a $7{%a$9$/b $b$a$1Q$9$/a$/b $8%b}|{%D$/b}$9 $b$a$1Q$9$/a$/b $4%y$9 $b$a$1TK$9$/a$/b";

      current_item_prefix = "$b$r";
      current_item_suffix = "$/r$/b";
      current_item_inactive_column_prefix = "$2";
      current_item_inactive_column_suffix = "$9";

      now_playing_prefix = "$b$2󰐊 $9$/b";
      now_playing_suffix = "";

      browser_playlist_prefix = "$b$7Playlist$9 $a$1Q$9$/a$/b $u$5";
      browser_sort_mode = "name";
      browser_sort_format = "{%a - }{%t}|{%f} {%l}";
      browser_display_mode = "columns";

      selected_item_prefix = "$2";
      selected_item_suffix = "$9";
      modified_item_prefix = "$3* $9";

      execute_on_song_change = "sleep .1 && ${pkgs.libnotify}/bin/notify-send -a 'NCMPCPP' -r 27072 'Now Playing:' \"$(${pkgs.mpc}/bin/mpc --format '%title%\\n%artist% - %album%' current)\" -i /tmp/mpdAlbumArt.jpg -h int:value:$(mpc status | ${pkgs.gawk}/bin/gawk 'NR==2 { print $4 }' | sed 's/[(%)]//g')";

      playlist_editor_display_mode = "columns";
      autocenter_mode = "yes";
      centered_cursor = "yes";
      user_interface = "alternative";
      cyclic_scrolling = "yes";
      screen_switcher_mode = "previous";
      locked_screen_width_part = "32";
      clock_display_seconds = "yes";
      tag_editor_extended_numeration = "yes";
      search_engine_default_search_mode = "2";
      external_editor = "$EDITOR";
      message_delay_time = "1";

      volume_color = "cyan:b";
      state_line_color = "black";
      state_flags_color = "cyan:b";
      main_window_color = "blue";
      color1 = "blue:b";
      color2 = "cyan";
      progressbar_look = "━━━";
      progressbar_color = "black:b";
      progressbar_elapsed_color = "cyan:b";
      statusbar_color = "red";
      statusbar_time_color = "cyan:b";
      player_state_color = "cyan:b";
      window_border_color = "cyan";
      active_window_border = "magenta";

      lyrics_fetchers = "azlyrics, genius, musixmatch, sing365, metrolyrics, justsomelyrics, jahlyrics, plyrics, tekstowo, zeneszoveg, internet";
      follow_now_playing_lyrics = "yes";
      fetch_lyrics_for_current_song_in_background = "yes";
      store_lyrics_in_song_dir = "no";
    };
  };
}
