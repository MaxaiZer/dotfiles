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
set -U fish_color_autosuggestion white
set -U fish_color_operator white
set -U fish_color_error red

set fish_greeting

if type -q keychain
    set -gx SHELL /usr/bin/fish
    eval (keychain --eval --quiet --agents ssh $HOME/.ssh/github)
end

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
