# Defined in /Users/skali/.config/fish/config.fish @ line 110
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
    #virtualenv_prompt

    if test $last_status -eq 0
        set_color white -o
        printf '><((°> '
    else
        set_color red -o
        printf '[%d] ><((ˣ> ' $last_status
    end
    
    set_color normal
end
