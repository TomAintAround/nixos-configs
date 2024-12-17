{
	programs.lf.keybindings = {
		p = "paste; clear";
		ad = "push :mkdir<space>";
		af = "push :touch<space>";
		T = "trash";
		P = "paste_link";
		"<a-x>" = "chmodx";
		"<a-e>" = "extract";
		"<a-z>" = "push :zip<space>";
		"<a-d>" = "%ripdrag $fx";
		J = "move-parent down";
		K = "move-parent up";
		O = "openwith";
		"<c-f>" = "fzf_search";

		i = "rename";
		"<a-i>" = "rename; cmd-home";
		"<a-a>" = "rename; cmd-end";
		"<a-c>" = "rename; cmd-delete-home";
		"<a-C>" = "rename; cmd-end; cmd-delete-home";

		bh = "cd ~";
		bc = "cd ~/.config";
		bv = "cd ~/.var/app";
		bl = "cd ~/.local";
		bd = "cd ~/Downloads";
		br = "cd /";
		be = "cd /etc";
		bn = "cd /etc/nixos";
		bL = "follow_link";

		gb = ":git_branch";
		gp = "\${{clear; git pull --rebase || true; echo \"press ENTER\"; read ENTER}}";
		gs = "\${{clear; git status; echo \"press ENTER\"; read ENTER}}";
		gl = "\${{clear; git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit}}";
	};
}
