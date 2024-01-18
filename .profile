# disable IXON (Ctrl-S lock)
stty -ixon

function load_profile_dir(){
    for i in `ls ~/.profile.d/ | sort -n`;do
        [[ ! -z "$_DEBUG" ]] && echo Include ~/.profile.d/$i
        source ~/.profile.d/$i
    done
}

load_profile_dir
