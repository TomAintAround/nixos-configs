{lib, ...}: {
  networking = {
    useDHCP = lib.mkDefault true;
    enableIPv6 = true;
    firewall = let
      kdeConnectPorts = {
        from = 1714;
        to = 1764;
      };
    in {
      allowedTCPPortRanges = [kdeConnectPorts];
      allowedUDPPortRanges = [kdeConnectPorts];
    };
    networkmanager.enable = true;

    nameservers = [
      # Quad9
      "9.9.9.9"
      "149.112.112.112"
      "2620:fe::fe"
      "2620:fe::9"
    ];
  };

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSSEC = true;
      Domains = ["~."];
      DNSOverTLS = "opportunistic";
      MulticastDNS = "resolve";
    };
  };
}
