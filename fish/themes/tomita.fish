function fish_prompt
	echo

	set_color $fish_color_cwd
  printf '%s' (prompt_pwd)

  set_color normal
  printf '%s ' (__fish_git_prompt)


#  printf '['
#  switch $fish_bind_mode
#    case default
#      set_color --bold red
#      printf 'n'
#    case insert
#      set_color --bold green
#      printf 'i'
#    case visual
#      set_color --bold magenta
#      printf 'v'
#  end
#  set_color normal
#  printf '] '

  set_color -o yellow
  printf '⋊> '
  set_color normal
end

function fish_right_prompt
    set -l color_normal (set_color normal)
    set -l color_error (set_color $fish_color_error)
    set -l color "$color_normal"

    set -l venv_name (basename "$VIRTUAL_ENV")
    echo -sn "$color_error$venv_name$color_normal "
end
