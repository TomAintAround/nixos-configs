{lib, ...}: {
  users.users.root = {
    name = "root";
    hashedPassword = lib.mkDefault (throw "Must set a password");
  };
}
