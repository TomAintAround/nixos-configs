{ pkgs, lib, config, ... }: {
	programs.firefox.enable = true;

	# Updates are only done manually (probably for the best)
	home = {
		activation.download-arkenfox = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
			for profile in $(${pkgs.gawk}/bin/gawk -v RS="" '/\[Profile/' ~/.mozilla/firefox/profiles.ini | command grep Path= | sed 's/Path=//'); do
				profileDir=${config.home.homeDirectory}/.mozilla/firefox/"$profile"

				if [ ! -e "$profileDir"/updater.sh -a ! -e "$profileDir"/prefsCleaner.sh ]; then
					${pkgs.curl}/bin/curl --output "$profileDir"/updater.sh "https://raw.githubusercontent.com/arkenfox/user.js/master/updater.sh" &>/dev/null
					run chmod +x "$profileDir"/updater.sh
					${pkgs.curl}/bin/curl --output "$profileDir"/prefsCleaner.sh "https://raw.githubusercontent.com/arkenfox/user.js/master/prefsCleaner.sh" &>/dev/null
					run chmod +x "$profileDir"/prefsCleaner.sh
				fi
			done
		'';

		file = {
			".mozilla/firefox/5zm1o3x5.default-release/user-overrides.js".text = ''
				/* 0401 */
				user_pref("browser.safebrowsing.malware.enabled", false);
				user_pref("browser.safebrowsing.phishing.enabled", false);

				/* 0402 */
				user_pref("browser.safebrowsing.downloads.enabled", false);

				/* 0710 */
				user_pref("network.trr.mode", 2);

				/* 0801 */
				user_pref("keyword.enabled", true);

				/* 0830 */
				user_pref("browser.search.separatePrivateDefault", false);
				user_pref("browser.search.separatePrivateDefault.ui.enabled", false);

				/* 1006 */
				user_pref("browser.shell.shortcutFavicons", true);

				/* 5003 */
				user_pref("signon.rememberSignons", false);

				/* 5009 */
				user_pref("network.dns.disableIPv6", true);

				/* 5017 */
				user_pref("extensions.formautofill.addresses.enabled", false);
				user_pref("extensions.formautofill.creditCards.enabled", false);

				/* Disable pocket */
				user_pref("extensions.pocket.enabled", false);

				/* Disable Mozilla account */
				user_pref("identity.fxaccounts.enabled", false);

				/* Block autoplay */
				user_pref("media.autoplay.default", 5);

				/* Enabling userChrome customization */
				user_pref("toolkit.legacyuserprofilecustomizations.stylesheets", true);
			'';
		};
	};
}
