# disable IXON (Ctrl-S lock)
stty -ixon

if ! type brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! type rtx &> /dev/null; then
    brew install rtx
fi

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
