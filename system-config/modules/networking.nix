{ lib, ... }: {
	networking = {
		useDHCP = lib.mkDefault true;
		enableIPv6 = false;
		firewall = {
			allowedTCPPorts = [ 80 443 465 587 995 25565 27036 27037 27040 ];
			allowedTCPPortRanges = [
				{ from = 1714; to = 1764; }
			];
			allowedUDPPorts = [ 465 587 993 25565 27031 27036 ];
			allowedUDPPortRanges = [
				{ from = 1714; to = 1764; }
			];
		};
		networkmanager.enable = true;

		nameservers = [
			"9.9.9.9" # Quad9
			"149.112.112.112"
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
