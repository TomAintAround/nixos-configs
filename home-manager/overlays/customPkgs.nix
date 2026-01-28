final: prev: {
  mpvScripts =
    prev.mpvScripts
    // {
      pause_indicator_lite = prev.callPackage ./customPkgs/mpvScripts/pause_indicator_lite.nix {inherit (prev.mpvScripts) buildLua;};
    };
}
