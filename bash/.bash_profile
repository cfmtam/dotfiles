#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# path
PATH=$PATH:$HOME/bin
export PATH

# start X at login
# [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

# battery auto-hibernate script
watch -n 120 /home/catherine/bin/low_batt &
