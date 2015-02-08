# autoload -U add-zsh-hook
autoload -Uz vcs_info

# enable VCS systems you use
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*:prompt:*' check-for-changes true

setopt prompt_subst
autoload -U promptinit
promptinit

# Look at http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Version-Control-Information for more options
zstyle ':vcs_info:*' check-for-changes true
# Display this if there are unstaged changes
zstyle ':vcs_info:*' unstagedstr '*'
# Display this if there are staged changes
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' actionformats '[%b%|%a%c%u%]%f'
zstyle ':vcs_info:*' formats ':%b%c%u%f'

zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
precmd () { vcs_info }

PROMPT='[%n@%m %~${vcs_info_msg_0_}] %{$reset_color%}'
