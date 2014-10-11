#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -l --color=auto'
alias battery='acpi -b'
alias x='startx'
alias ping='ping -c 4'
alias mkdir='mkdir -p'
alias nano='nano -S -$'
alias dropbox='python2.7 -s ~/bin/dropbox.py'
alias sshuw='ssh -Y $UWUSER@linux.student.cs.uwaterloo.ca'
alias sshcsc='ssh -Y $UWUSER@csclub.uwaterloo.ca'

PS1='[\u@\h \W]\$ '

# colored man pages
man() {
   env \
   LESS_TERMCAP_mb=$(printf "\e[1;31m") \
   LESS_TERMCAP_md=$(printf "\e[1;31m") \
   LESS_TERMCAP_me=$(printf "\e[0m") \
   LESS_TERMCAP_se=$(printf "\e[0m") \
   LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
   LESS_TERMCAP_ue=$(printf "\e[0m") \
   LESS_TERMCAP_us=$(printf "\e[1;32m") \
   man "$@"
}
