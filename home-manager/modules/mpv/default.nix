{pkgs, ...}: {
  home.packages = with pkgs; [zenity];

  programs.mpv = {
    enable = true;
    package = pkgs.mpv.override (oldAttrs: {
      mpv-unwrapped = oldAttrs.mpv-unwrapped.override {
        ffmpeg = pkgs.ffmpeg-full;
      };
      scripts = with pkgs.mpvScripts; [
        modernz
        mpv-notify-send
        pause_indicator_lite
        mpv-playlistmanager
        thumbfast
      ];
    });
    defaultProfiles = ["high-quality"];
    config = {
      gpu-api = "vulkan";

      fullscreen = true;
      keep-open = true;
      save-position-on-quit = true;
      write-filename-in-watch-later-config = true;
      save-watch-history = true;
      vd-queue-enable = true;

      border = false;
      msg-color = true;
      msg-module = true;
      osc = false;
      osd-bar = true;
      osd-font = "Inter Tight Medium";
      osd-font-size = 30;
      osd-bar-align-y = -1;
      osd-border-size = 2;
      osd-bar-h = 1;
      osd-bar-w = 60;

      blend-subtitles = false;
      sub-ass-use-video-data = "all";
      sub-ass-scale-with-window = false;
      sub-auto = "fuzzy";
      sub-gauss = 0.6;
      sub-file-paths-append = ["ass" "srt" "sub" "subs" "subtitles"];
      demuxer-mkv-subtitle-preroll = true;
      embeddedfonts = true;
      sub-fix-timing = false;
      sub-font = "Open Sans SemiBold";
      sub-font-size = 46;
      sub-blur = 0.3;
      sub-border-color = "0.0/0.0/0.0/0.8";
      sub-border-size = 3.2;
      sub-color = "0.9/0.9/0.9/1.0";
      sub-margin-x = 100;
      sub-margin-y = 50;
      sub-shadow-color = "0.0/0.0/0.0/0.25";
      sub-shadow-offset = 0;

      volume-max = 200;
      audio-stream-silence = true;
      audio-file-auto = "fuzzy";
      audio-pitch-correction = true;

      hwdec = "auto-copy-safe";
      vo = "gpu-next";
      dither-depth = "auto";
      deband = true;
      deband-iterations = 4;
      deband-threshold = 35;
      deband-range = 16;
      deband-grain = 4;
      glsl-shader = "~~/shaders/ravu-zoom-ar-r3-rgb.hook";
      scale = "ewa_lanczos";
      scale-blur = 0.981251;
      video-sync = "display-resample";
      interpolation = true;
      tscale = "sphinx";
      tscale-blur = 0.6991556596428412;
      tscale-radius = 1.05;
      tscale-clamp = 0.0;
      tone-mapping = "bt.2446a";
      target-colorspace-hint = false;

      deinterlace = false;
    };

    profiles = {
      "protocol.http" = {
        hls-bitrate = "max";
        cache = true;
        cache-pause = false;
        ytdl-raw-options = "compat-options=prefer-vp9-sort";
      };
      "protocol.https".profile = ["protocol.http"];
      "protocol.ytdl".profile = ["protocol.http"];
      "extention.gif".loop-file = true;
    };

    bindings = {
      "9" = "seek -60";
      "0" = "seek 60";
      AXIS_DOWN = "add volume -2";
      AXIS_UP = "add volume 2";
      DOWN = "add volume -2";
      UP = "add volume 2";
      "SHIFT+DOWN" = "add volume -10";
      "SHIFT+UP" = "add volume 10";
    };

    scriptOpts.modernz = {
      loop_button = true;
      shuffle_button = true;
      speed_button = true;
      loop_in_pause = false;
    };
  };

  xdg.configFile = {
    "mpv/scripts".source = ./scripts;
    "mpv/shaders".source = ./shaders;
  };
}
