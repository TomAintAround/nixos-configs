{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
      size = 13.0;
    };
    shellIntegration.enableFishIntegration = true;
    keybindings = {
      "kitty_mod+t" = "";
      "kitty_mod+q" = "";
      "kitty_mod+right" = "";
      "kitty_mod+left" = "";
      "kitty_mod+l" = "";
      "kitty_mod+." = "";
      "kitty_mod+," = "";
      "kitty_mod+alt+t" = "";
      "kitty_mod+enter" = "";
      "kitty_mod+n" = "";
      "kitty_mod+w" = "";
      "kitty_mod+r" = "";
      "kitty_mod+]" = "";
      "kitty_mod+[" = "";
      "kitty_mod+tab" = "";
      "kitty_mod+shift+tab" = "";
      "kitty_mod+f" = "";
      "kitty_mod+b" = "";
      "kitty_mod+`" = "";
      "kitty_mod+f7" = "";
      "kitty_mod+f8" = "";
      "kitty_mod+backspace" = "";
      "kitty_mod+0" = "change_font_size all 0";
      "kitty_mod+f11" = "";
      "kitty_mod+f10" = "";
      "kitty_mod+delete" = "";
      "kitty_mod+a>m" = "";
      "kitty_mod+a>l" = "";
      "kitty_mod+a>1" = "";
      "kitty_mod+a>d" = "";
    };
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = 13.0;

      cursor_shape = "beam";
      cursor_beam_thickness = 1.0;
      cursor_trail = 0;

      wheel_scroll_multiplier = 1.0;

      repaint_delay = 2;
      input_delay = 0;
      sync_to_monitor = false;
      wayland_enable_ime = false;

      strip_trailing_spaces = "always";

      enable_audio_bell = false;
      confirm_os_window_close = 0;

      enabled_layouts = "Tall";
      window_margin_width = 3;
      window_padding_width = 3;

      tab_bar_margin_height = "5.0 0.0";
      tab_bar_style = "powerline";
      tab_bar_min_tabs = 2;
      tab_powerline_style = "round";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
    };
    extraConfig = ''
      font_features JetBrainsMonoNF-Bold +cv02 +cv04 +cv10 +cv11 +cv12 +cv15 +cv16 +cv17 +cv18 +zero
      font_features JetBrainsMonoNF-BoldItalic+cv02 +cv04 +cv10 +cv11 +cv12 +cv15 +cv16 +cv17 +cv18 +zero
      font_features JetBrainsMonoNF-ExtraBold +cv02 +cv04 +cv10 +cv11 +cv12 +cv15 +cv16 +cv17 +cv18 +zero
      font_features JetBrainsMonoNF-ExtraBoldItalic +cv02 +cv04 +cv10 +cv11 +cv12 +cv15 +cv16 +cv17 +cv18 +zero
      font_features JetBrainsMonoNF-ExtraLight +cv02 +cv04 +cv10 +cv11 +cv12 +cv15 +cv16 +cv17 +cv18 +zero
      font_features JetBrainsMonoNF-ExtraLightItalic +cv02 +cv04 +cv10 +cv11 +cv12 +cv15 +cv16 +cv17 +cv18 +zero
      font_features JetBrainsMonoNF-Italic +cv02 +cv04 +cv10 +cv11 +cv12 +cv15 +cv16 +cv17 +cv18 +zero
      font_features JetBrainsMonoNF-Light +cv02 +cv04 +cv10 +cv11 +cv12 +cv15 +cv16 +cv17 +cv18 +zero
      font_features JetBrainsMonoNF-LightItalic +cv02 +cv04 +cv10 +cv11 +cv12 +cv15 +cv16 +cv17 +cv18 +zero
      font_features JetBrainsMonoNF-Medium +cv02 +cv04 +cv10 +cv11 +cv12 +cv15 +cv16 +cv17 +cv18 +zero
      font_features JetBrainsMonoNF-MediumItalic +cv02 +cv04 +cv10 +cv11 +cv12 +cv15 +cv16 +cv17 +cv18 +zero
      font_features JetBrainsMonoNF-Regular +cv02 +cv04 +cv10 +cv11 +cv12 +cv15 +cv16 +cv17 +cv18 +zero
      font_features JetBrainsMonoNF-SemiBold +cv02 +cv04 +cv10 +cv11 +cv12 +cv15 +cv16 +cv17 +cv18 +zero
      font_features JetBrainsMonoNF-SemiBoldItalic +cv02 +cv04 +cv10 +cv11 +cv12 +cv15 +cv16 +cv17 +cv18 +zero
      font_features JetBrainsMonoNF-Thin +cv02 +cv04 +cv10 +cv11 +cv12 +cv15 +cv16 +cv17 +cv18 +zero
      font_features JetBrainsMonoNF-ThinItalic +cv02 +cv04 +cv10 +cv11 +cv12 +cv15 +cv16 +cv17 +cv18 +zero
    '';
  };
}
