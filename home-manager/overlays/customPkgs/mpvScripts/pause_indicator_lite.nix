{
  lib,
  buildLua,
  fetchFromGitHub,
  nix-update-script,
}:
buildLua rec {
  pname = "pause_indicator_lite";
  version = "0.2.9";

  src = fetchFromGitHub {
    owner = "Samillion";
    repo = "ModernZ";
    rev = "v${version}";
    hash = "sha256-ocsThwgCeWUSCs1ZD2pwNIvKQZtGQXrvceaMRvgmFPA=";
  };
  sourceRoot = "source/extras/${builtins.replaceStrings ["_"] ["-"] pname}";

  passthru.updateScript = nix-update-script {};

  meta = {
    description = "A simple script that displays an indicator on pause (and mute), with options to adjust icon type, color, height, width, opacity and whether to toggle pause with a keybind or not.";
    homepage = "https://github.com/Samillion/ModernZ/tree/main/extras/pause-indicator-lite";
    license = lib.licenses.lgpl21Plus;
  };
}
