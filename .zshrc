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
alias rip='/usr/bin/whipper cd rip'
alias comp='/usr/bin/picom -bc --config ~/.config/picom.conf'
alias mnt='sudo mount 192.168.0.251:/mnt/user/bigdata /mnt/fs01'
alias feh='feh --title "album" -x -Z -. -g 1000x800 -r'
alias pia='/opt/piavpn/bin/pia-client'
alias vim='/usr/bin/nvim'
alias lah='ls -lah --color=always | less -R'
alias x='exit'
alias xlog='vim .local/share/xorg/Xorg.0.log'
alias c='clear'
alias phonesync='adb-sync --delete /mnt/fs01/Music/ /sdcard/Music'
alias unraid='ssh root@unraid'
alias xc='vim ~/.xmonad/xmonad.hs'

spacman(){
	unbuffer pacman -Ss "$@" | less -R
}
syay(){
	unbuffer yay -Ss "$@" | less -R
}

bindkey -v

PATH="/home/rehajel/.scripts:/home/rehajel/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/rehajel/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/rehajel/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/rehajel/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/rehajel/perl5"; export PERL_MM_OPT;
