# Source functions and aliases
. ~/.config/fish/functions/main.fish
. ~/.config/fish/themes/clearance.fish # prompt theme
. ~/.config/fish/functions/python.fish
. ~/.config/fish/functions/pretty_man.fish
. ~/.config/fish/aliases.fish

. ~/.config/fish/completions/*

# Set locales
set -gx LANG en_US.UTF-8
set -gx LC_COLLATE POSIX
set -gx LC_CTYPE en_US.UTF-8

# Disable greeting
set -gx fish_greeting ''

# Set system editor to vim
set -gx EDITOR vim

# Disable cowsay for ansible
set -gx ANSIBLE_NOCOWS 1

# Pipenv shell vars
set -gx PIPENV_SHELL_FANCY 1

# FZF
set -gx FZF_DEFAULT_COMMAND 'ffind'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# Paths
prep_to_path "/sbin"
prep_to_path "/usr/sbin"
prep_to_path "/bin"
prep_to_path "/usr/local/bin"
prep_to_path "/usr/local/sbin"
prep_to_path "/usr/local/MacGPG2/bin"
prep_to_path "$HOME/bin"
prep_to_path "$HOME/lib/dotfiles/bin"

