# disable IXON (Ctrl-S lock)
stty -ixon

if type rtx &> /dev/null; then
    echo Loading rtx at $0:A:$LINENO
    eval "$(rtx activate `basename $SHELL`)"
fi

function load_profile_dir(){
    # Include .profile.d
    for i in `ls ~/.profile.d/ | sort -n`;do
        source ~/.profile.d/$i
    done
}

load_profile_dir

[ -e ~/.bash_aliases ] && source ~/.bash_aliases
