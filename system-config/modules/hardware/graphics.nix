{ pkgs, lib, ... }: {
    hardware.graphics = {
        enable = lib.mkDefault true;
        enable32Bit = lib.mkDefault true;
        extraPackages = with pkgs; [ libvdpau-va-gl vaapiVdpau egl-wayland ];
    };
}
