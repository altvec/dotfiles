# Smart URLs
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# File rename magic
bindkey "^[m" copy-prev-shell-word

# Jobs
setopt long_list_jobs

# Pager
export PAGER=less
export LC_TYPE=$LANG

# crap
# fortune | cowsay | lolcat
