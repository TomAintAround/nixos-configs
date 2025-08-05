{pkgs, ...}: {
  home.packages = [pkgs.trash-cli];

  systemd.user = {
    services.trash-cli = {
      Unit.Description = "Deletes 14+ day old trash";

      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.trash-cli}/bin/trash-empty 14";
      };

      Install.WantedBy = ["default.target"];
    };

    timers.trash-cli = {
      Unit.Description = "Automatically deletes 14+ day old trash";

      Timer = {
        OnCalendar = "daily";
        Persistent = true;
        Unit = "trash-cli.service";
      };

      Install.WantedBy = ["timers.target"];
    };
  };
}
