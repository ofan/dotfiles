
ZSH_RC_DIR=~/.zsh.d

function load_profile(){
    # Load profiles
    if [ -f $HOME/.profile ]; then
        source $HOME/.profile
    fi
}

function load_zsh_rc(){
    # Init dir
    for i in `ls $ZSH_RC_DIR | sort -n`;do
        source $ZSH_RC_DIR/$i
    done
}

# MacPorts Installer addition on 2011-08-27_at_09:31:06: adding an appropriate PATH variable for use with MacPorts.
#export PATH=~/bin:/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.
