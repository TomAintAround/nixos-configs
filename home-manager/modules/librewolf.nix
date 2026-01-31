{
  pkgs,
  inputs,
  ...
}: {
  programs.librewolf = {
    enable = true;
    settings = {
      "media.autoplay.default" = 5;
      "webgl.disabled" = false;
      "middlemouse.paste" = false;
      "general.autoScroll" = true;
      "toolkit.legacyuserprofilecustomizations.stylesheets" = true;
      "gfx.webrender.all" = true;
      "media.ffmpeg.vaapi.enabled" = true;
      "widget.use-xdg-desktop-portal.settings" = 0;
      "privacy.resistFingerprinting.letterboxing" = true;

      "network.trr.mode" = 2;
      "network.trr.uri" = "https://dns10.quad9.net/dns-query";
      "network.trr.default_provider_uri" = "https://doh.dns4all.eu/dns-query";
      "network.trr.strict_native_fallback" = false;
      "network.trr.retry_on_recoverable_errors" = true;
      "network.trr.disable-heuristics" = true;
      "network.trr.allow-rfc1918" = true;
    };

    languagePacks = ["pt-PT" "es-ES"];

    profiles.default = {
      id = 0;
      extensions = {
        force = true;
        packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          bitwarden
          canvasblocker
          darkreader
          firefox-color
          skip-redirect
          sponsorblock
          stylus
          xbrowsersync
        ];
      };
    };
  };
}
