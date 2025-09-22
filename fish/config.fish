if status is-interactive
    # Commands to run in interactive sessions can go here
end

fzf --fish | source
zoxide init fish | source
starship init fish | source

fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/go/bin

set -U fish_color_command green
set -U fish_color_param white
set -U fish_color_operator white
set -U fish_color_error red

set fish_greeting

function yy
    set tmp (mktemp -t yazi-cwd.XXXXXX)

    yazi $argv --cwd-file=$tmp

    if test -s $tmp
        set cwd (cat $tmp)
        if test "$cwd" != "$PWD"
            cd $cwd
        end
    end

    rm -f $tmp
end

set -l agent_env "$HOME/.ssh/agent_env"

if not pgrep -u $USER ssh-agent >/dev/null
    ssh-agent -c >$agent_env 2>/dev/null
end

if test -f $agent_env
    source $agent_env >/dev/null
end

set SSH_KEY "$HOME/.ssh/github"
if test -f $SSH_KEY
    set key_fingerprint (ssh-keygen -lf $SSH_KEY 2>/dev/null | awk '{print $2}')
    if not ssh-add -l 2>/dev/null | grep -q "$key_fingerprint"
        ssh-add $SSH_KEY >/dev/null 2>&1
    end
end
