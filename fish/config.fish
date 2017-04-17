# Shamelessly stolen from Steve Losh
# https://bitbucket.org/sjl/dotfiles

# Aliases ---
alias :q exit
alias :qa exit

set BROWSER open

set -g -x fish_greeting ''
set -g -x EDITOR nvim
set -g -x COMMAND_MODE unix2003
set -g -x PATH "/sbin"

function prepend_to_path -d "Prepend the given dir to PATH"
    if test -d $argv[1]
        if not contains $argv[1] $PATH
            set -g -x PATH "$argv[1]" $PATH
        end
    end
end

prepend_to_path "/usr/sbin"
prepend_to_path "/bin"
prepend_to_path "/usr/bin"
prepend_to_path "/usr/local/bin"
prepend_to_path "/usr/local/sbin"
prepend_to_path "$HOME/lib/dotfiles/bin"
prepend_to_path "$HOME/bin"
prepend_to_path "$HOME/Library/Android/sdk/platform-tools"
prepend_to_path "/usr/local/opt/go/libexec/bin"

# Python ---
set -g -x PIP_DOWNLOAD_CACHE "$HOME/.pip/cache"

# Go ---
set -g -x GOPATH "$HOME/lib/Go"


# Prompt ---
set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set gray (set_color -o black)


# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles '☡'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'


function prompt_pwd --description 'Print the current working directory, shortend to fit the prompt'
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
    
    printf '%s ' (__fish_git_prompt)
    echo

    if test $last_status -eq 0
        set_color white -o
        printf '><((°> '
    else
        set_color red -o
        printf '[%d] ><((ˣ> ' $last_status
    end
    
    set_color normal
end

true

