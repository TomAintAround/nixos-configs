{
  config,
  lib,
  ...
}: {
  boot = {
    blacklistedKernelModules = lib.optionals (!config.hardware.enableRedistributableFirmware) ["ath3k"];
    kernelModules = lib.mkIf config.services.tlp.enable ["acpi_call"];
    extraModulePackages = lib.mkIf config.services.tlp.enable (with config.boot.kernelPackages; [acpi_call]);
  };

  services = {
    # Gnome 40 introduced a new way of managing power, without tlp.
    # However, these 2 services clash when enabled simultaneously.
    # https://github.com/NixOS/nixos-hardware/issues/260
    tlp.enable = lib.mkDefault ((lib.versionOlder (lib.versions.majorMinor lib.version) "21.05") || !config.services.power-profiles-daemon.enable);
    upower.enable = true;
  };
}
