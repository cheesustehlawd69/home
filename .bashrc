#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# bash aliases
alias back='cd $OLDPWD'
alias e='$EDITOR'
alias sev='sudo -E $EDITOR'
alias desktop='cd ~/Desktop'
alias dmesg='dmesg -T'
alias ls='ls -FGal --group-directories-first --color=auto -h'
alias grep='grep -in --color=auto'
alias diff='diff -iwBadEys --suppress-common-lines --suppress-blank-empty'
alias hist='history | sort -d | grep'
alias cls='clear'
alias brc='$EDITOR $HOME/.bashrc'
alias reload='source $HOME/.bashrc'
alias q='exit'
alias logout='killall -u $USER'
#alias del='timeout 3 rm -Iv --one-file-system'
alias tree='find -type d | sort -d'
alias usage='sudo du -hxd 1 / | sort -h'
alias itl='sudo iptables -n -L -v --line-numbers | less'
alias hex='cat /dev/urandom | hexdump -C | grep --color=auto "ca fe"'
alias mv='mv -ivu'
alias mkdir='mkdir -p -v'

# Aliased shell scripts
##--- located in ~/.bin/
alias tor1='tor_up.sh'
alias tor0='tor_dn.sh'
alias flush='memflu.sh'
alias dare='dare.sh'
alias imap0='imap_dn.sh'
alias imap1='imap_up.sh'
alias yd='yd.sh'
alias bbm='bbm.sh'
alias dfx='dcronfix.sh'
alias scan='scan.sh'
alias sipo='sipo.sh'
alias aur='yaourt_up.sh'
#     Syntax: $ slsk -f [DIR/] [TERM]
alias slsk='seek.sh'
alias sxiv='sxiv.sh'
alias ren='ren.sh'
alias del='del.sh'

# pacman aliases
alias pc='pacman'
alias Syy='sudo pacman -Syy'
alias Syu='sudo pacman -Syu'
alias Ss='pacman -Ss'
alias S='sudo pacman -S'
alias Scc='sudo pacman -Scc'
alias Rnsc='sudo pacman -Rnsc'
alias Si='pacman -Si'
alias query='pacman -Q | grep'
alias list='pacman -Ql'
alias qaur='pacman -Qm'
alias group='pacman -Qg'
alias nfo='pacman -Qi'
alias orphans='orphan.sh'
alias pacwc='pkgwc.sh'
alias clog='pacman -Qc'
# Find cached pkgs>10MB & print filenames
alias pkg10='find /var/cache/pacman/pkg/ -size +9M -iname "*.*z" -printf "%f\n" | sort -d'
# Output list of installed packages & redirect to a file
alias pkglist='pacman -Q | column -t > ./$(hostname)_pkglist.nfo'

# abs/pkgbuild aliases
alias abs='sudo abs'
alias mrisc='makepkg -risc --noconfirm --skipchecksums --skipinteg --skippgpcheck'

# Shell options
##--- shopt -p lists settable options and current values
##--- shopt -o lists available options with settings
shopt -s cdable_vars
shopt -s cdspell
shopt -s dirspell
shopt -s checkwinsize
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s histverify
shopt -s autocd

# disable ^S/^Q flow control
stty -ixon

# command search path
# paths seperated by colons
export PATH=$PATH:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/sbin:/usr/games:/opt/java/jre/bin:/opt/kde/bin:/usr/bin/perlbin/site:/usr/bin/perlbin/vendor:/usr/bin/perlbin/core:/opt/qt/bin:/usr/local/bin:$HOME/.bin

# colors
 export GREP_COLOR="1;33";
 export LESS_TERMCAP_md=$'\e[01;33m';
 export LESS_TERMCAP_mb=$'\e[00;33m';
 export LESS_TERMCAP_me=$'\e[00;00m';
 export LESS_TERMCAP_se=$'\e[00;00m';
 export LESS_TERMCAP_so=$'\e[01;31m';
 export LESS_TERMCAP_ue=$'\e[00;00m';
 export LESS_TERMCAP_us=$'\e[01;32m';

##--- startup
 printf "\n\e[1;34m";
 uname;
 uname -r;
 uname -m;
 date;
# printf " \e[0;96m Welcome!\e[00;00m\b";
printf " \e[0;96m \e[00;00m\b";

# Prompt String 1
PS1='\[\033[1;34m\][\u: \[\033[1;96m\]\w\[\033[1;34m\]]\$\[\033[37;0m\] '

# A little welcome message:
echo
fortune -e linuxcookie | cowthink -f ~/.cows/tux.cow
# fortune | cowsay -f tux
echo

## enable bash completion ##
    if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi

# miscellaneous tab completion
complete -cf sudo
complete -cf whereis
#complete -cf man
complete -c man which
complete -o dirnames -d cd

# LS_COLORS script
eval $(dircolors -b $HOME/.bin/.LS_COLORS)

## positional parameters ##

# extract function
extract () {
    if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2) tar xjf $1    ;;
           *.tar.gz)  tar xzf $1    ;;
           *.bz2)     bunzip2 $1    ;;
           *.rar)     unrar x $1    ;;
           *.gz)      gunzip $1    ;;
           *.tar)     tar xf $1    ;;
           *.tbz2)    tar xjf $1    ;;
           *.tgz)     tar xzf $1    ;;
           *.zip)     unzip $1    ;;
           *.ZIP)     unzip $1    ;;
           *.Z)       uncompress $1;;
	   *.7z)      7z x $1      ;;
           *)         echo "'$1' cannot be extracted via extract()" ;;
       esac
    else
        echo "'$1' is not a valid file"
    fi
}

# start daemons
start()
{
  for arg in $*; do
    sudo /etc/rc.d/$arg start
  done
}

# stop daemons
stop()
{
  for arg in $*; do
    sudo /etc/rc.d/$arg stop
  done
}

# restart daemons
restart()
{
  for arg in $*; do
    sudo /etc/rc.d/$arg restart
  done
}

# makes directory then moves into it
function mkcd {
    mkdir -p -v $1
    cd $1
}

# copy and move to directory
cpcd (){
  if [ -d "$2" ];then
    cp $1 $2 && cd $2
  else
    cp $1 $2
  fi
}

# ls directly after cd function
lcd() { cd ${1} ; ls ; }

# recursively change ownership to $USER:$USER
# usage:  mkmine, or
#         mkmine <filename | dirname>
function mkmine() { sudo chown -R ${USER}:${USER} ${1:-.}; }

# set file/directory owner & permissions to normal values (644/755)
# usage: sanitize <file>
sanitize()
{
  chmod -R u=rwX,go=rX "$@"
  chown -R ${USER}:users "$@"
}

# Shell variables
export SHELL=bash
export BROWSER='firefox -new-tab'
export EDITOR=vim
export VISUAL=vim
export PAGER=less
export XAUTHORITY=$HOME/.Xauthority
export XDG_CONFIG_HOME="$HOME/.config"

# Editing mode variables
export HISTSIZE=5000
export HISTFILESIZE=1000
export HISTCONTROL=ignoreboth
export HISTCONTROL=ignoredups:erasedups:ignorespace
export HISTIGNORE='ls:pwd:exit:clear'
export OOO_FORCE_DESKTOP=gnome
export CLICOLOR=1

# Environment variables:
export MOZ_DISABLE_PANGO=1
export GCONF_LOCAL_LOCKS=1
export GDK_CORE_DEVICE_EVENTS=1
export GTK_OVERLAY_SCROLLING=0
export SYSTEMD_LESS=FRXMK journalctl
export VAAPI_MPEG4_ENABLED=true
export NOUVEAU_PMPEG=1
