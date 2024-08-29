{ lib, ... }: {
    networking = {
        useDHCP = lib.mkDefault true;
        enableIPv6 = false;
        firewall = {
            allowedTCPPorts = [ 80 443 25565 27036 27037 27040 ];
	    allowedTCPPortRanges = [
		{ from = 1714; to = 1764; }
	    ];
            allowedUDPPorts = [ 25565 27031 27036 ];
	    allowedUDPPortRanges = [
		{ from = 1714; to = 1764; }
	    ];
        };
        networkmanager.enable = true;

        nameservers = [
            "194.242.2.4" #base.dns.mullvad.net
        ];
    };

    services.resolved = {
        enable = true;
        dnssec = "true";
        domains = [ "~." ];
        extraConfig = ''
            DNSOverTLS=opportunistic
            MulticastDNS=resolve
        '';
        llmnr = "true";
    };
}
