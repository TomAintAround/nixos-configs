{ config, lib, ... }: {
    services.blueman.enable = lib.mkIf config.hardware.bluetooth.enable true;
}
