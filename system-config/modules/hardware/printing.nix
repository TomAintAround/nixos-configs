{
    ensurePrinters ? throw "Set your printer(s) settings",
    drivers ? throw "Set your printer/scanner drivers here, e.g. with pkgs; [ epson-escpr epsonscan2 ]",
    ...
}: {
    services.printing = {
        enable = true;
        inherit drivers;
        openFirewall = true;
    };

    hardware = {
        sane = {
            enable = true;
            extraBackends = drivers;
        };
        printers = { inherit ensurePrinters; };
    };
}
