{
	services.udisks2 = {
		enable = true;
		settings."mount_options.conf".defaults.umask = "0022";
	};
}
