#
# ~/.bash_profile
#

[[ -f ~/.zshrc ]] && . ~/.zshrc
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx 
fi
XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_HOME
export BROWSER=/usr/bin/qutebrowser
export EDITOR=/usr/bin/nvim
