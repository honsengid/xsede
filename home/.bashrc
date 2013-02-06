# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Faster job submission
alias qjob='for d in `find . -mindepth 1 -maxdepth 1 -type d`; do cd $d; qsub job.pbs; cd ..; done'

# Commad to switch to EPD
alias useepd='source ${HOME}/etc/epd_path'

# User specific aliases and functions
export MACHINE=CHANGE_THIS_IN_THE_.bashrc_FILE
export PS1="\[\033[01;32m\]\u@\[\033[01;31m\]$MACHINE\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
export LS_OPTIONS="$LS_OPTIONS --color"
