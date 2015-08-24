export PATH=/usr/local/bin:/usr/bin

case "$(uname)" in

	Darwin) #'OS'がMacならばa
		#'MacVim'が存在するならば
		if [[ -d /Applications/MacVim.app ]]; then

			alias vim=/Applications/MacVim.app/Contents/MacOS/Vim

		fi
		;;
	*) ;; #'OS'がMac以外ならば何もしない
esac

#'ls'でカラー表示させる
alias ls="ls -G"
alias ll="ls -l"
