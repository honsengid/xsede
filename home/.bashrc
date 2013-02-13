# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Commad to switch to EPD
alias useepd='source ${HOME}/etc/epd_path'

# User specific aliases and functions
. $HOME/lib/sh/tlt-functions
detect_system
export XSEDE_SYSTEM
export PS1="\[\033[01;32m\]\u@\[\033[01;31m\]${XSEDE_SYSTEM}\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
export LS_OPTIONS="$LS_OPTIONS --color"
