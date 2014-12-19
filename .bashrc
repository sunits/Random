# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# User specific aliases and functions
alias j='cd ..'
alias jj='cd -'
alias lr='ls -h --color'
alias lt='ls -ltrh'
alias cp='cp -v'
alias r="readlink -e"
# Also list the job id
alias jobs="jobs -l"
# Because of frequent mistakes while typing
alias dc='cd '

alias genrand="source ${HOME}/.random.sh"
alias  psr="ps aux | grep"
alias fm="free -m"
alias feg="free -g"

function cdn(){
cmd=""
for (( i=0; i < $1; i++))
do
    cmd="$cmd../"
done
cd "$cmd"
}

#To extract compressed files
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1    ;;
            *.tar.gz)    tar xvzf $1    ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       rar x $1       ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xvf $1     ;;
            *.tbz2)      tar xvjf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}


# To color the man pages
man() {
    env LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}


#Start a python HTTP server
alias pyserver='python -m SimpleHTTPServer';



# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=50000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;37m\]\u@\h\[\033[00m\]:\[\033[01;37m\]\w\[\033[00m\]\$ "
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

# some more ls aliases
alias ll='ls -altchF'
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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

shopt -s histappend
PROMPT_COMMAND='history -a'

# ---- for sphinx --------  BEGIN
export PATH=/usr/local/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/lib
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export PATH="$PATH:${HOME}/everything/speech/scripts"
# ---- for sphinx --------  END


# follwoing part is considered evil and dangerous.
# copy it only if you really know what you are doing

#export PS1='\[\e[1;31m\][\W]  :\[\e[0m\] '
bashidx=$(date +"%M%S")
export PS1='\n\[\e[1;31m\]\u@\H | \@ | $(pwd) \n>>> \[\e[0m\]'
export PATH="$PATH:${HOME}/scripts/"
alias mark="source ${HOME}/scripts/mark.sh"
export LS_COLORS="${LS_COLORS}di=01;34:"

# a convinient grep 
alias cgrep="grep -inr -A2 -B2 --exclude={tags,cscope.out,*.so*,*.o*,*.a}"
# kill space in the beginning. kill multiple spaces
alias ksp='sed -e "s|\s\+| |g" -e "s|^\s\+||g"'
# get directory name from file path
alias gdir='sed -e "s|/[^/]\+$||g"'
# show last n downloads
alias dow="ls -lrth ~/Downloads | tail -n"
# print a big horizontal line
alias hline="echo -e '\n------------------------------------------------------------\n'"
# get columns from space seperated output
alias gcol="sed -e 's|\s\+| |g' -e 's|^\s\+||g' | cut -d ' ' -f "

alias c=clear
alias pdf2psAcro='acroread -toPostScript'

# added by Anaconda 1.7.0 installer
# export PATH="/home/vinaynk/everything/program_files/setups/anaconda/run/bin:$PATH"
# conda python3
# alias p3="/home/vinaynk/everything/program_files/setups/anaconda/run/envs/py33/bin/python3.3"



 #for the mark script by Vinay- incredebly helpful one
alias mark="source ${HOME}/mark.sh"
#for Matlab
PATH=$PATH:/usr/local/MATLAB/R2011a/bin:/home/sunit/softwares/libsvm-3.14:



# Shortcuts for some handy stuff
alias v=vim
alias m=mark
alias matlab="matlab -nodesktop"


export MANPATH=/usr/local/man:/usr/local/share/man:/usr/share/man

alias tg="cd /home/sunit/software/telegram/tg ; telegram"
alias tops='top -u sunit'


#KALDI paths
KALDI_ROOT=/media/sda5/kaldi/kaldi-trunk
export PATH=${KALDI_ROOT}/src/bin:${KALDI_ROOT}/tools/openfst/bin:${KALDI_ROOT}/src/fstbin/:${KALDI_ROOT}/src/gmmbin/:${KALDI_ROOT}/src/featbin/:${KALDI_ROOT}/src/fgmmbin:${KALDI_ROOT}/src/sgmmbin:${KALDI_ROOT}/src/lm:${KALDI_ROOT}/src/latbin:${KALDI_ROOT}/src/tiedbin/:$PATH  
export LC_ALL=C
export LC_LOCALE_ALL=C


