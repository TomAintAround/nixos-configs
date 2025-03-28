{
	services.openssh = {
		enable = true;
		openFirewall = false;
	};

	# This allows the SSH port, but limits it
	# to no more than 3 attempts per minute
	networking.firewall.extraCommands = ''
iptables -I nixos-fw -p tcp --dport 22 -m state --state NEW -m recent --set
iptables -I nixos-fw -p tcp --dport 22 -m state --state NEW -m recent --update --seconds 60 --hitcount 4 -j nixos-fw-refuse
	'';
}
