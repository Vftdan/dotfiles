# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color|*-24bit) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#User-defined
shopt -s expand_aliases
shopt -s progcomp_alias
shopt -s nullglob
HISTSIZE=100000
HISTFILESIZE=200000
set -o vi
stty werase undef
bind -m vi-insert -r '"\C-a"'
bind -m vi-insert -r '"\C-b"'
bind -m vi-insert -r '"\C-e"'
bind -m vi-insert -r '"\C-w"'
bind -m vi-insert -r '"\C-u"'
bind -m vi-insert '"\C-a":beginning-of-line'
bind -m vi-insert '"\C-b":beginning-of-line'
bind -m vi-insert '"\C-e":end-of-line'
bind -m vi-insert '"\C-w":backward-kill-word'
bind -m vi-insert '"\C-u":backward-kill-line'
alias upgrade="apt install --only-upgrade"
alias edrc='nvim ~/.bashrc'
alias rerc=". ~/.bashrc"
alias lla="ls -lha --time-style=long-iso"
alias llt="ls -lht --time-style=long-iso"
(which exa > /dev/null) && alias lg="exa -lTa --git"
alias jj='java -jar'
alias gs='git status'
alias glg="git log --graph --decorate --oneline"
alias ta='tmux attach'
alias tn='tmux new -s'
alias tna='tmux new -As'
alias __copy="xclip -selection c"
alias __paste="xclip -selection c -o"
alias mv="mv -i"
alias cp="cp -i"
# Use yt-dlp instead if possible
alias ytdl='youtube-dl -f 22'
alias ytdlpl='youtube-dl -f 22 -o "%(playlist_index)s. %(title)s.%(ext)s"'
alias ytdla='youtube-dl -f 140'
alias ytdlapl='youtube-dl -f 140 -o "%(playlist_index)s. %(title)s.%(ext)s"'
alias ytdlmkv='youtube-dl -f 22+bestaudio --merge-output-format mkv --all-subs --write-sub --write-auto-sub --embed-subs --convert-subtitles ass'
alias ff-show-info='ffprobe -v error -show_entries format -of default=noprint_wrappers=1:nokey=0'
alias ffmpeg='ffmpeg -hide_banner'
alias ffprobe='ffprobe -hide_banner'
alias md-read="nvim +'set notgc' +'term python3 -m rich.markdown -c % ; sleep infinity'"
alias sag='eval $(ssh-agent)'
alias sa="ssh-add"
# Pre Ubuntu 19 behavior:
alias sudo="sudo --preserve-env=HOME,SHLVL"
alias pdf2jpg="pdftoppm -jpeg -r 300"
_tna() {
	[[ "$COMP_CWORD" -eq 1 ]] && COMPREPLY=($( compgen -W "$(tmux start\; list-sessions | cut -d: -f1)" -- "${COMP_WORDS[1]}" ))
}
complete -F _tna tna
_Man() {
	__load_completion man
	_man "$@"
}
complete -F _Man Man
_upgrade() {
	__load_completion apt
	COMP_LINE="apt install --only-upgrade${COMP_LINE#upgrade}"
	COMP_POINT=$((COMP_POINT + 19))
	COMP_WORDS=(apt install --only-upgrade ${COMP_WORDS[-1]})
	COMP_CWORD=3
	_apt "$@"
}
complete -F _upgrade upgrade
complete -c lnc
lnc() {
	[[ `which $1` == '' ]] && echo "No such executable" && return
	"$@" 2> /dev/null & disown $!
}
lth() {
	ls -t "$@" | head
}
mkcd() {
	mkdir "$@" && cd "$1"
}
=sh() {
	echo $(( $@ ))
}
=() {
	echo "print( $@ )" | python3 -
}
title() {
	echo -n -e '\e]2;'
	echo -n "$@"
	echo -n -e '\007'
}
ssh-add-key() {
	ls ~/.ssh
	read -p "key: " key
	pushd ~/.ssh >> /dev/null
	key=$(realpath $key 2>> /dev/null)
	[ 0 != "$?" ] && echo && popd >> /dev/null && return
	popd >> /dev/null
	ssh-add $key
}
__copyfile() {
	for i in "$@"; do \
		echo file://$(realpath "$i") | sed -e 's/\%/%25/g; s/ /%20/g; s/\?/%3F/g; s/\&/%26/g'
	done | xclip -selection clipboard -i -t text/uri-list
}
__to_data_url() {
	echo "data:$1;base64,$(base64 -w 0 $2)"
}
__to_data_url_file() {
	__to_data_url "$(file --mime-type "$1" | cut -d ' ' -f 2)" "$1"
}
Man() {
	nvim "man://man" "++Man $*"
}
ietfrfc() {
	# nvim "https://tools.ietf.org/rfc/rfc$1.txt"
	nvim "https://www.rfc-editor.org/rfc/rfc$1.txt"
}
xprop-no-icon() {
	xprop "$@" | sed -e '/\tIcon/,/^$/d'
}
if [ "$TERM" = xterm-256color ]; then \
	if ( toe -a | grep ^xterm-24bit -q; ); then \
		export TERM=xterm-24bit
	fi
fi
_msys=' '
if [[ ${#MSYSTEM} != 0 ]] ; then
	_msys=' \[\e[35m\]$MSYSTEM\[\e[0m\] '
fi
if [[ ${EUID} == 0 ]] ; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h \[\e[0;1;42;97m\][$SHLVL]\[\e[0m\]'$_msys'\[\033[01;34m\]\w\n\[\033[01;31m\]\$\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h \[\e[0;1;42;97m\][$SHLVL]\[\e[0m\]'$_msys'\[\033[00m\]\[\033[01;34m\]\w\n\[\033[01;32m\]\$\[\033[00m\] '
fi
unset _msys
