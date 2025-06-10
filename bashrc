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
alias dl="xrandr --output eDP --auto --output HDMI-A-0 --off --dpi 96"
alias dlu="xrandr --output eDP --off --output HDMI-A-0 --dpi 110 --mode 3440x1440 --rate 99.98"
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
alias ne="cd /etc/nixos; nvim"
alias x="exit"
alias s="sudo -v"

files () {
    case "$1" in
        status)
            rclone bisync /home/john/files/ marvin:/srv/nfs/storage1/new-nas/john/ --create-empty-src-dirs --dry-run
            ;;
        sync)
            rclone bisync /home/john/files/ marvin:/srv/nfs/storage1/new-nas/john/ --create-empty-src-dirs -v
            ;;
        resync)
	    echo "To confirm, copy the command and remove --dry-run to perform a resync."
            echo "rclone bisync /home/john/files/ marvin:/srv/nfs/storage1/new-nas/john/ --create-empty-src-dirs --resync -v --dry-run"
            ;;
        *)
            echo "Usage: files {push|status}"
            return 1
            ;;
    esac
}

maxbr () {
  echo 255 | sudo tee /sys/class/backlight/amdgpu_bl1/brightness > /dev/null
}

gnc-txns () {
  grep description \
  | sed 's/<trn:description>//' \
  | sed 's/<\/trn:description>//' \
  | tac
}

ff () {
  firefox --new-tab "$1"
}

ffw () {
  firefox --new-window "$1"
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
