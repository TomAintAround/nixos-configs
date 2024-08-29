{
    services.hardware.openrgb.enable = true;

    # This service is already started at startup.
    # With this service being also enable, there
    # will be conflict and the lights will flicker
    systemd.services.openrgb.enable = false;
}
