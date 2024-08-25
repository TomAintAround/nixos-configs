let
    secrets = import ../../secrets.nix;
in {
    users.users.root = {
        name = "root";
        hashedPassword = secrets.passwords.root;
    };
}
