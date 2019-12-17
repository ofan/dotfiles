#!/bin/zsh

load_profile
load_zsh_rc

TMUX_MOD=`[ -z "$TMUX" ] && echo 1`
TMUX_TERM_LIST=(Apple_Terminal iTerm.app rxvt-unicode-256color xterm-256color)

_check_term_app() {
    TP=''
    if [ -n "$TERM_PROGRAM" ];then
        TP=$TERM_PROGRAM
    elif [ -n "$TERM" ]; then
        TP=$TERM
    else
        echo 'Either $TERM or $TERM_PROGRAM is set, cannot determine terimnal name.'
        return 1
    fi

    res=${TMUX_TERM_LIST[@]/${TP}/yes}
    if [ -n "`echo $res | grep 'yes'`" ]; then
        return 0
    else
        return 1
    fi
}

_clean() {
    # Clean vars
    unset TMUX_MOD TMUX_TERM_LIST
    unset -f load_profile
    unset -f load_zsh_rc
    unset -f _start_tmux
    unset -f _clean
}

DEFAULT_SESSION=new
CODE="
# _timout callback, it's called when timeout script times out
_timeout() {
    echo $DEFAULT_SESSION
    exit
}

# _main callback, it's called right after timeout script is initialized
_main() {
    SELECT_CMD
}
"

_start_tmux(){
    # If timeout script doesn't exist then skip starting tmux
    if [ ! -x ~/bin/timeout ]; then
        echo Warning: ~/bin/timeout doesn\'t exist
        return
    fi

    # Start tmux if no tmux is running under current shell
    if [ "`_check_term_app && echo 1`" = "1" -a "z$TMUX_MOD" = "z1" ];then
        session_list=`tmux list-sessions | sed "s/.*/'&'/g" | tr '\n' ' '`
        if [ -n "$session_list" ];then
            echo "Select an session, default is $DEFAULT_SESSION , enter q to cancel starting tmux"
            SELECT_CMD="
            select session in ${session_list[*]}; do
                target=\`echo \$session | awk '{print \$1}'\`
                if [ -n \"\$session\" ];then
                    echo \$target
                else
                    echo \$REPLY
                fi
                break
            done
            "

            CODE=${CODE/SELECT_CMD/$SELECT_CMD}
            ~/bin/timeout 5 "$CODE" > /tmp/.zsh_start_$$
            target=`cat /tmp/.zsh_start_$$`
            rm -f /tmp/.zsh_start_$$
        fi

        if [ "$target" = 'q' -o "$target" = "Q" ];then
            return 0
        fi
        ## Open tmux
        cmd='tmux -2'
        if [ -n "$target" -a "$target" != "new" ];then
            cmd="$cmd attach -t $target"
        fi

        if [ -z "`which tmux`" ];then
            echo Tmux is not found. Try to install it first...
            echo Trying installing using 'sudo apt-get install tmux...'
            sudo apt-get install tmux
        fi

        _clean
        eval "$cmd" || echo "Tmux exited abnormally. Exit code $?"
        exit 0
    fi
    _clean
}

_start_tmux
