# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# have a big history size
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable `**` for recursive glob matching
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
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

# aliases
alias cpy="xclip -selection clipboard"
alias pst="xclip -selection clipboard -o"
alias dl="xrandr --output eDP --fb 1920x1080 --mode 1920x1080 --scale 1x1 --set TearFree on"
alias dlu="xrandr --fb 2560x1080 --output eDP --mode 1920x1080 --scale-from 2560x1080 --output HDMI-A-0 --mode 2560x1080 --scale 1x1 --same-as eDP --set TearFree on --rate 74.99"
alias c=clear
alias ga="git add -A"
alias gc="git commit -m"
alias gp="git push"
alias gs="git status"
alias gl="git pull"
alias gb="git branch"
alias gco="git checkout"
alias gd="git diff"
alias gdc="git diff --cached"
alias gm="git merge"
alias gbd="git branch -d"
alias p="python3"
alias l="ls -lh"
alias la="ls -lah"
alias hl=hledger
alias nrbs="sudo nixos-rebuild switch"
alias ns='nohup "${TERMINAL:-alacritty}" >/dev/null 2>&1 &'

# custom commands
maxbr () {
  echo 255 | sudo tee /sys/class/backlight/amdgpu_bl1/brightness > /dev/null
}

gnc-txns () {
  grep description \
  | sed 's/<trn:description>//' \
  | sed 's/<\/trn:description>//' \
  | tac
}

pdf () {
    firefox -new-window "$1"
}

combine_files() {
    for file in "$@"; do
        echo "File: $file"
        cat "$file"
        echo -e "\n"
    done
}

csv() {
  if [[ -f "$1" ]]; then
    column -s, -t < "$1" | less -#2 -N -S
  else
    echo "File not found: $1"
  fi
}

PS1="\[\]\[\e]0;\u: \w\a\]\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ \[\]"

set -o vi
