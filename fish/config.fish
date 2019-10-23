# Set locales
set -gx LANG en_US.UTF-8
set -gx LC_COLLATE POSIX
set -gx LC_CTYPE en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

# Disable greeting
set -gx fish_greeting ''

# Better ls colors
set -gx LSCOLORS gxfxcxdxbxegedabagacad

# Aliases
alias l 'ls -1'
alias ll 'ls -alh'
alias vim 'nvim'
alias vi 'nvim'
alias cls 'clear'
#alias poetry 'python3 $HOME/.poetry/bin/poetry'

set BROWSER open

set -gx EDITOR nvim
set -gx COMMAND_MODE unix2003
set -gx PAGER 'less -X'

# Disable cowsay for ansible
set -gx ANSIBLE_NOCOWS 1

# Python and pipenv shell vars
export PIPENV_SHELL_FANCY=1
export PIPENV_MAX_SUBPROCESS=64
export PIPENV_DEFAULT_PYTHON_VERSION=3.7
export PYTHONDONTWRITEBYTECODE=1

# zlib
set -gx LDFLAGS "-L/usr/local/opt/zlib/lib"
set -gx CPPFLAGS "-I/usr/local/opt/zlib/include"
set -gx PKG_CONFIG_PATH "/usr/local/opt/zlib/lib/pkgconfig"

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

prep_to_path "/usr/local/sbin"
prep_to_path "$HOME/bin"
prep_to_path "$HOME/lib/dotfiles/bin"
prep_to_path "/usr/local/go/bin"
prep_to_path "$GOPATH/bin"
prep_to_path "$HOME/.cargo/bin"
prep_to_path "$HOME/Library/Python/2.7/bin"
prep_to_path "$HOME/Library/Python/3.7/bin"
prep_to_path "$HOME/.local/bin"
prep_to_path "$HOME/.poetry/bin"
prep_to_path "$HOME/.composer/vendor/bin"
prep_to_path "/usr/local/opt/gettext/bin"

# Prompt {{{
set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set cyan (set_color cyan)
set gray (set_color -o black)

function virtualenv_prompt
    if [ -n "$VIRTUAL_ENV" ]
        printf '(%s) ' (basename "$VIRTUAL_ENV")
    end
end

function _git_branch_name
    echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _git_is_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function git_prompt
    if [ (_git_branch_name) ]
        set -l git_branch (_git_branch_name)
        if [ (_git_is_dirty) ]
            set git_info '(' $magenta $git_branch "±" $normal ')'
        else
            set git_info '(' $green $git_branch $normal ')'
        end
        echo -n -s ' · ' $git_info $normal
    end
end

function prompt_pwd -d 'Print the current working dir, shortened to fit the prompt'
    echo $PWD | sed -e "s|^$HOME|~|"
end

function fish_prompt
    set last_status $status

    echo

    set_color magenta
    printf '%s' (whoami)
    set_color normal
    printf ' at '

    set_color yellow
    printf '%s' (hostname | cut -d . -f 1)
    set_color normal
    printf ' in '

    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal

    git_prompt

    echo

    virtualenv_prompt

    if test $last_status -eq 0
        set_color green -o
        printf '> '
    else
        set_color red -o
        printf '[%d] x ' $last_status
    end

    set_color normal
end
# }}}

# Pyenv
status --is-interactive; and source (pyenv init - | psub)

true

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/skali/google-cloud-sdk/path.fish.inc' ]; . '/Users/skali/google-cloud-sdk/path.fish.inc'; end
