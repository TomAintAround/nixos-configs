{
  pkgs,
  inputs,
  defaultSopsFile,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];

  environment.systemPackages = with pkgs; [age sops];

  sops = {
    inherit defaultSopsFile;
    defaultSopsFormat = "yaml";
    age.keyFile = "/var/lib/sops-nix/keys.txt";

    secrets = {
      "hashedPasswords/root" = {neededForUsers = true;};
      "hashedPasswords/tomm" = {neededForUsers = true;};
    };
  };

  systemd.tmpfiles.settings."10-sops-nix" = {
    "/var/lib/sops-nix"."d" = {
      user = "root";
      group = "root";
      mode = "700";
    };

    "/var/lib/sops-nix/keys.txt"."f" = {
      user = "root";
      group = "root";
      mode = "600";
    };
  };
}
