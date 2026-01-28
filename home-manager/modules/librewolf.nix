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

      "sidebar.visibility" = "always-show";
      "sidebar.revamp" = true;
      "sidebar.verticalTabs" = true;
      "browser.tabs.inTitlebar" = 0;
      "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
      "sidebar.installed.extensions" = "{446900e4-71c2-419f-a6a7-df9c091e268b}";
      "sidebar.main.tools" = "{446900e4-71c2-419f-a6a7-df9c091e268b},history,bookmarks";
      "browser.toolbars.bookmarks.visibility" = "never";
      "browser.uiCustomization.navBarWhenVerticalTabs" = "[\" back-button \",\" forward-button \",\" stop-reload-button \",\" home-button \",\" sidebar-button \",\" customizableui-special-spring1 \",\" vertical-spacer \",\" find-button \",\" urlbar-container \",\" downloads-button \",\" customizableui-special-spring2 \",\" fxa-toolbar-menu-button \",\" addon_darkreader_org-browser-action \",\" ublock0_raymondhill_net-browser-action \",\" unified-extensions-button \",\" preferences-button \"]";

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
