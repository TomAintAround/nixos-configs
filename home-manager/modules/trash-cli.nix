{ pkgs, ... }: {
    home.packages = [ pkgs.trash-cli ];

    systemd.user = {
        services.trash-cli = {
            Unit.Description = "Deletes 14+ day old trash";

            serviceConfig = {
                Type = "oneshot";
                ExecStart = "${pkgs.trash-cli}/bin/trash-empty 14";
            };
        };

        timers.trash-cli = {
            Unit.Description = "Automatically deletes 14+ day old trash";

            timerConfig = {
                OnCalendar = "daily";
                Persistent = true;
                Unit = "trash-cli.service";
            };

            Install.WantedBy = [ "timers.target" ];
        };
    };
}
