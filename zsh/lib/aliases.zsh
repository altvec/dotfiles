alias ll='ls -lA'
alias lh='ls -lAh'
alias ..='cd ..'
alias ...='cd ../..'
alias cdd='cd -'
alias cl='clear'

alias findn='find . -name '
alias psaux='ps aux | grep -v grep | grep -i'
alias free='$HOME/lib/dotfiles/memreport.py'

# Python
alias serve='python -m SimpleHTTPServer'
# Upgrade all pip packages
alias pipup="pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | grep -v 'vboxapi' | xargs pip install -U"
alias pip3up="pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1 | grep -v 'vboxapi' | xargs pip3 install -U"

# Git
alias gits='clear; git status'
alias gitl='git log'
alias gitlg='git log --oneline --graph'
alias gitpo='git push origin'
alias gituall='git submodule foreach git pull origin master'
alias gitc='git clone'

# tmux
alias tma='tmux attach -t dashboard || tmux new -s dashboard'
