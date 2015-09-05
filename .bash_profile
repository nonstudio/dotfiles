
case "$(uname)" in
	Darwin) #'OS'がMacならば
		#'MacVim'が存在するならば
		if [[ -d /Applications/MacVim.app ]]; then
			PATH="/Applications/MacVim.app/Contents/MacOS:$PATH"
		fi
		;;
	*) ;; #'OS'がMac以外ならば何もしない
esac

alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -laG'
#alias ls='gls --color=auto'

#case "$(OSTYPE)" in
#	Darwin*)
#		alias ls='ls -G'
#		alias ll='ls -lG'
#		alias la='ls -laG'
#		alias ls='gls --color=auto'
#	;;
#esac

#eval $(gdircolors ~/Dropbox/settings/dircolors-solarized/dircolors.ansi-universal)

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

GREP_OPTIONS="--color=always";export GREP_OPTIONS
