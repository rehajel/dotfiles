# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Lines configured by zsh-newuser-install
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/rehajel/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit
# End of lines added by compinstall

alias ls='ls --color=auto'
alias dotfiles='/usr/bin/git --git-dir=/home/rehajel/.dotfiles/ --work-tree=/home/rehajel'

# pretty colors
BLD="\e[01m" RED="\e[01;31m" NRM="\e[00m"

# history stuff
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt COMPLETE_ALIASES
setopt hist_expire_dups_first
setopt hist_expire_dups_first
setopt inc_append_history
setopt share_history
setopt appendhistory

# fix zsh annoying history behavior
h() { if [ -z "$*" ]; then history 1; else history 1 | egrep "$@"; fi; }

# get sudo privileges to complete sudo commands
zstyle ':completion::complete:*' gain privileges 1

# systemlevel
start() { sudo systemctl start "$1"; }
stop() { sudo systemctl stop "$1"; }
restart() { sudo systemctl restart "$1"; }
status() { sudo systemctl status "$1"; }
enabled() { sudo systemctl enable "$1"; listd; }
disabled() { sudo systemctl disable "$1"; listd; }

# set prompt style
prompt walters

alias orphans='[[ -n $(pacman -Qdt) ]] && sudo pacman -Rs $(pacman -Qdtq) || echo "no orphans to remove"'