# ~/.bashrc: executed by bash(1) for non-login shells.
## .bashrc
# Maintainer: 
#     Christina Jacob 
# Version: 
#       5.0 - 29/05/12 15:43:36
#
# Sections:
#    -> Helper functions
#    -> Startup
#    -> General
#    -> Networking
#    -> SDK
#    -> Telnet
#    -> MISC
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
#Helper functions
#function to display the current git branch and its dirty status
function parse_git_dirty {
	[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
## As I always forget the parameters
#function for extracting a compressed file
extract () {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)	tar xvjf 	$1	;;
			*.tar.gz)	tar xvzf	$1	;;
			*.bz2)		bunzip2 	$1	;;
			*.rar)		unrar x 	$1	;;
			*.gz)		gunzip		$1 	;;
			*.tar)		tar xvf 	$1	;;
			*.tbz2)		tar xvjf 	$1	;;
			*.tgz)		tar xvzf 	$1	;;
			*.zip)		unzip		$1	;;
			*.Z) 		uncompress 	$1	;;
			*.7z) 		7z x 		$1	;;
			*)echo		"don't	know how to extract '$1'...";;
		esac
	else
		echo "'$1' is not a valid file!"
	fi
}
#function to create a tar.gz file from a folder
compress() {
	tar -zcvf $1.tar.gz $1 
	if [ $? ] ; then 
		echo "COMPRESSION SUCCESSFUL"
	else
		echo "ERROR IN COMPRESSION!!!"
	fi

}


# User specific aliases and functions

#Startup
    export PS1="\u@\[\033[32m\]\W\[\033[33m\]\$(parse_git_branch)\[\033[00m\]\! $ "
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

#General
alias home='cd /home/cjacob'
alias rhome='cd /root'

#Networking
alias ok="ping google.com"

#SDK
alias 88sdk='cd /home/cjacob/work-dir/88xx/sdk_new/sdk-new/;source env-setup' 
alias 83sdk='cd /home/cjacob/work-dir/83xx/sdk/' 
alias kernel='cd linux/kernel/linux-aarch64' 
alias mc='make menuconfig'
alias mca='ARCH=arm64 make menuconfig'
alias ub='make uboot-build'

#Telnet
alias telroot='ssh root@10.91.206.195'
alias tel81='telnet 10.91.206.195'
alias tel83='telnet 10.91.206.195 7001'
alias tel78-1='telnet 10.91.206.195 7023'
alias tel78-2='telnet 10.91.206.195 '
alias telgbt-1='telnet 10.91.206.195 7020'
alias telgbt-2='telnet 10.91.206.195 7005'
alias tel88='telnet 10.91.206.195'

#MISC
#you are careless girl!!!!
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi
