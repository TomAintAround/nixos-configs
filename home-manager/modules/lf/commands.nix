{ pkgs, ... }: {
	programs.lf.commands = {
		trash = "%trash-put $fx";
		touch = "%IFS=\" \"; touch -- \"$*\"";

		on-cd = ''
&{{
	${pkgs.zoxide}/bin/zoxide add "$PWD"

	# display repository status in your prompt
	if [ -d .git ] || [ -f .git ]; then
		branch=$(${pkgs.git}/bin/git branch --show-current 2>/dev/null) || true
		remote=$(${pkgs.git}/bin/git config --get branch.$branch.remote 2>/dev/null) || true
		url=$(${pkgs.git}/bin/git remote get-url $remote 2>/dev/null) || true
		fmt="\033[32;1m%u@%h\033[0m:\033[34;1m%w\033[0m\033[33;1m [GIT BRANCH:> $branch >> $url]\033[0m"
	else
		fmt="\033[32;1m%u@%h\033[0m:\033[34;1m%d\033[0m\033[1m%f\033[0m"
	fi
	${pkgs.lf}/bin/lf -remote "send $id set promptfmt \"$fmt\""

	printf "\033]0; ''${PWD/#$HOME/\~}\007" > /dev/tty
}}
		'';

		on-select = ''
&{{
	${pkgs.lf}/bin/lf -remote "send $id set statfmt \"$(${pkgs.eza}/bin/eza -ld --color=always "$f")\""
}}
		'';

		on-redraw = ''
%{{
	if [ $lf_width -le 80 ]; then
		${pkgs.lf}/bin/lf -remote "send $id set ratios 1:2"
	elif [ $lf_width -le 160 ]; then
		${pkgs.lf}/bin/lf -remote "send $id set ratios 1:2:3"
	else
		${pkgs.lf}/bin/lf -remote "send $id set ratios 1:2:3:5"
	fi
}}
		'';

		mkdir = ''
%{{
	IFS=" "
	mkdir -p -- "$*"
	${pkgs.lf}/bin/lf -remote "send $id select \"$*\""
}}
		'';

		chmodx = ''
&{{
	chmod +x $fx
	${pkgs.lf}/bin/lf -remote "send $id reload"
}}
		'';

		extract = ''
''${{
	${pkgs.atool}/bin/aunpack $fx
}}
		'';

		zip = ''
''${{
	set -f
	mkdir $1
	cp -r $fx $1
	${pkgs.zip}/bin/zip -9 -r $1.zip $1
	rm -rf $1
	${pkgs.lf}/bin/lf -remote "send $id unselect"
}}
		'';

		paste_link = ''
%{{
	IFS=$'\n'
	set -- $(cat ~/.local/share/lf/files)
	mode="$1"
	shift
	if [ $# -lt 1 ]; then
		lf -remote "send $id echo no files to link"
		exit 1
	fi
	case "$mode" in
		# symbolically copy mode is indicating a soft link
		copy) ln -sr -t . -- "$@";;
		# while a move mode is indicating a hard link
		move) ln -t . -- "$@";;
	esac \
	|| exit $?
	rm ~/.local/share/lf/files
	${pkgs.lf}/bin/lf -remote "send clear"
}}
		'';

		follow_link = ''
%{{
	${pkgs.lf}/bin/lf -remote "send $id select \"$(readlink $f)\""
}}
		'';

		git_branch = ''
''${{
	${pkgs.git}/bin/git branch | fzf | xargs git checkout
	pwd_shell=$(pwd | sed 's/\\/\\\\/g;s/"/\\"/g')
	${pkgs.lf}/bin/lf -remote "send $id updir"
	${pkgs.lf}/bin/lf -remote "send $id cd \"$pwd_shell\""
}}
		'';

		fzf_search = ''
''${{
	cmd="${pkgs.ripgrep}/bin/rg --column --line-number --no-heading --color=always --smart-case"
	${pkgs.fzf}/bin/fzf --ansi --disabled --layout reverse --header "Search in files" --delimiter : \
	--bind "start:reload([ -n {q} ] && $cmd -- {q} || true)" \
	--bind "change:reload([ -n {q} ] && $cmd -- {q} || true)" \
	--bind 'enter:become(${pkgs.lf}/bin/lf -remote "send $id select \"$(printf "%s" {1} | sed '\'''s/\\/\\\\/g;s/"/\\"/g'\''')\"")' \
	--preview '${pkgs.bat}/bin/bat --paging=never --color=always --wrap=never --style=header,grid,numbers --line-range :50 "$file" -- {1}' --preview-window 'right:60%'
}}
		'';

		move-parent = ''
&{{
	dironly="setlocal '$(dirname "$PWD")' dironly"
	${pkgs.lf}/bin/lf -remote "send $id :updir; $dironly true; $1; $dironly false; open"
}}
		'';
	};
}
