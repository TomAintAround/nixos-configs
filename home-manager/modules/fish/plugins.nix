{ pkgs, ... }: {
    programs.fish.plugins = [
        {
            name = "done";
            src = pkgs.fishPlugins.done.src;
        }
        {
            name = "autopair";
            src = pkgs.fishPlugins.autopair.src;
        }
        {
            name = "pufferfish";
            src = pkgs.fishPlugins.puffer.src;
        }
        {
            name = "tide";
            src = pkgs.fishPlugins.tide.src;
        }
    ];
}
