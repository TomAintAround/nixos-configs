{pkgs, ...}: {
  programs.fish.plugins = let
    mkFishPlugin = name: {
      inherit name;
      inherit (pkgs.fishPlugins.${name}) src;
    };
  in [
    (mkFishPlugin "done")
    (mkFishPlugin "autopair")
    (mkFishPlugin "tide")
  ];
}
