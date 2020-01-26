# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

# Load shell dotfiles from .bash/
# - `paths` used to extend `$PATH`
# - `aliases` use to store commands aliases
# - `prompt` prompt settings
# - `functions` useful functions
# - `exports` some exports
for file in ~/.bash/{paths,aliases,prompt,functions,exports}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# ------------------------------------------------------------------------------
# Options
# ------------------------------------------------------------------------------
set +o histexpand
# Append to the Bash history file, rather than overwriting it
shopt -s histappend
# Check window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# Autocorrect typos in path names when using `cd`
shopt -s cdspell
# Case-insensitive globbing
shopt -s nocaseglob
# Enable some Bash 4 features when possible:
# - `autocd`, e.g. `**/bop` will expand to `./foo/bar/baz/bop`
# - recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2>/dev/null
done;

# ------------------------------------------------------------------------------
# Completion
# ------------------------------------------------------------------------------
if which brew &> /dev/null && [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
    # Ensure existing Homebrew v1 completions continue to work
    export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d"
    source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

# Enable tab completion for `g` by making it as an alias for `git`
if type _git &> /dev/null; then
    complete -o default -o nospace -F _git g
fi

# ------------------------------------------------------------------------------
# Pyenv
# ------------------------------------------------------------------------------
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

# ------------------------------------------------------------------------------
# FZF
# ------------------------------------------------------------------------------
[ -f ~/.fzf.bash ]  && source ~/.fzf.bash
