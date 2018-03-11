export ZSH=~/.zsh

# Load all config files
for config_file ($ZSH/lib/*.zsh) source $config_file

# Activate zsh completions
fpath=(/usr/local/share/zsh-completions $fpath)

# Load and run compinit
autoload -U compinit
compinit -i
