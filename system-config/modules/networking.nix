{
  networking = {
    enableIPv6 = true;
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
