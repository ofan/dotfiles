
ZSH_RC_DIR=~/.zsh.d

function load_profile(){
    # Load profiles
    if [ -f $HOME/.profile ]; then
        [[ ! -z "$_DEBUG" ]] && echo "Loading $HOME/.profile"
        source $HOME/.profile
    fi
}

function load_zsh_rc(){
    # Init dir
    for i in `\ls $ZSH_RC_DIR | sort -n`;do
        [[ ! -z "$_DEBUG" ]] && echo "Loading $ZSH_RC_DIR/$i"
        source $ZSH_RC_DIR/$i
    done
}
