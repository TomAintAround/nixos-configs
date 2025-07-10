{ pkgs, lib, config, ... }: {
	imports = [
		./settings.nix
		./keymaps.nix
	];
} // lib.mkIf (config.fileManager == "yazi") {
	home.packages = with pkgs; [
		ffmpeg # for video thumbnails
		atool unzip zip # for archive extraction and preview
		jq # for JSON preview
		poppler # for PDF preview
		fd # for file searching
		ripgrep # for file content searching
		fzf # for quick file subtree navigation, >= 0.53.0
		zoxide # for historical directories navigation, requires fzf
		resvg # for SVG preview
		imagemagick # for Font, HEIC, and JPEG XL preview
		ripdrag # for drag and drop

		# Plugin dependencies
		rich-cli
		exiftool
	];

	programs.yazi = {
		enable = true;
		plugins = let 
			compress = pkgs.fetchFromGitHub {
				owner = "KKV9";
				repo = "compress.yazi";
				rev = "9fc8fe0bd82e564f50eb98b95941118e7f681dc8";
				hash = "sha256-VKo4HmNp5LzOlOr+SwUXGx3WsLRUVTxE7RI7kIRKoVs=";
			};
			exifaudio = pkgs.fetchFromGitHub {
				owner = "Sonico98";
				repo = "exifaudio.yazi";
				rev = "4506f9d5032e714c0689be09d566dd877b9d464e";
				hash = "sha256-RWCqWBpbmU3sh/A+LBJPXL/AY292blKb/zZXGvIA5/o=";
			};
		in {
			inherit (pkgs.yaziPlugins) chmod full-border git relative-motions rich-preview;
			inherit compress exifaudio;
		};
		initLua = ./init.lua;
	};
}
