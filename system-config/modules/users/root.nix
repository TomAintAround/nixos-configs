{config, ...}: {
  users.users.root = {
    name = "root";
    hashedPasswordFile = config.sops.secrets."hashedPasswords/root".path;
  };
}
