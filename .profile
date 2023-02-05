# disable IXON (Ctrl-S lock)
stty -ixon

echo Loading asdf at $0:A:$LINENO
if type brew &> /dev/null; then
    source $(brew --prefix asdf)/libexec/asdf.sh
fi

function load_profile_dir(){
    # Include .profile.d
    for i in `ls ~/.profile.d/ | sort -n`;do
        source ~/.profile.d/$i
    done
}

load_profile_dir

[ -e ~/.bash_aliases ] && source ~/.bash_aliases
