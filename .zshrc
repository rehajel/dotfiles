# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History stuff?
HISTSIZE=10000
SAVEHIST=10000
setopt COMPLETE_ALIASES
setopt hist_expire_dups_first
setopt inc_append_history
setopt share_history
setopt appendhistory

# -- Alias --
alias dotfiles='/usr/bin/git --git-dir=/home/rehajel/.dotfiles/ --work-tree=/home/rehajel'
alias orphans='[[ -n $(pacman -Qdt) ]] && sudo pacman -Rs $(pacman -Qdtq) || echo "no orphans to remove"'
alias wakeup='/usr/bin/wol 30:9c:23:5e:ed:94'
alias virtualhere='sudo /home/rehajel/vhusbdx86_64'
