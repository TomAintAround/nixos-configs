{ secrets, ... }: {
    users.users.root = {
        name = "root";
        hashedPassword = secrets.passwords.root;
    };
}
