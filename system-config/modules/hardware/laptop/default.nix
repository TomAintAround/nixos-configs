{
  config,
  lib,
  ...
}: {
  boot.blacklistedKernelModules = lib.optionals (!config.hardware.enableRedistributableFirmware) ["ath3k"];

  # Gnome 40 introduced a new way of managing power, without tlp.
  # However, these 2 services clash when enabled simultaneously.
  # https://github.com/NixOS/nixos-hardware/issues/260
  services.tlp = {
    enable =
      lib.mkDefault ((lib.versionOlder (lib.versions.majorMinor lib.version) "21.05")
        || !config.services.power-profiles-daemon.enable);
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "powersave";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      TLP_DEFAULT_MODE = "BAT";
      TLP_PERSISTENT_DEFAULT = 1;
    };
  };
}
