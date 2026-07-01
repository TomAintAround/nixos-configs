final: prev: {
  mpvScripts =
    prev.mpvScripts
    // {
      pause_indicator_lite = prev.callPackage ./customPkgs/mpvScripts/pause_indicator_lite.nix {inherit (prev.mpvScripts) buildLua;};
    };
  # FIX: remove when these are pushed to upstream
  rpcs3 = prev.rpcs3.override {glew = prev.glew.override {enableEGL = false;};};
  vesktop = prev.vesktop.override {pnpm_10_29_2 = prev.pnpm_10;};
}
