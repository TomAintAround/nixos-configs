{
    boot.loader = {
        systemd-boot = {
            enable = true;
            consoleMode = "max";
            editor = false;
        };
        efi.canTouchEfiVariables = true;
    };
}
