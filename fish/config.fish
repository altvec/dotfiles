# Source functions and aliases
. ~/.config/fish/themes/clearance.fish
. ~/.config/fish/aliases.fish
. ~/.config/fish/completions/*

# Set locales
set -gx LANG en_US.UTF-8
set -gx LC_COLLATE POSIX
set -gx LC_CTYPE en_US.UTF-8

# Disable greeting
set -gx fish_greeting ''

# Better ls colors
set -gx LSCOLORS gxfxcxdxbxegedabagacad

# Set system editor to vim
set -gx EDITOR vim

# Disable cowsay for ansible
set -gx ANSIBLE_NOCOWS 1

# Python and pipenv shell vars
export PIPENV_SHELL_FANCY=1
export PIPENV_MAX_SUBPROCESS=64
export PIPENV_DEFAULT_PYTHON_VERSION=3.6
export PYTHONDONTWRITEBYTECODE=1

# FZF
set -gx FZF_DEFAULT_COMMAND 'ffind'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# Key bindings
function fish_user_key_bindings
    bind \cw backward-kill-word
    bind \cf fzf-fish
end

# Paths
function prep_to_path -d "Prepend the given dir to PATH if it exists and is not already in it"
    if test -d $argv[1]
        if not contains $argv[1] $PATH
            set -gx PATH "$argv[1]" $PATH
        end
    end
end

set -x GOPATH "$HOME/.go"

prep_to_path "$HOME/bin"
prep_to_path "$HOME/lib/dotfiles/bin"
prep_to_path "/usr/local/go/bin"
prep_to_path "$GOPATH/bin"
prep_to_path "$HOME/.cargo/bin"
prep_to_path "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
