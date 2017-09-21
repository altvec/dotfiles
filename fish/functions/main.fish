# Main functions

function psproc -d "Grep for a runnung process, returning it's PID and full string"
    ps auxww \
    | grep --color=always $argv \
    | grep -v grep \
    | sed -e 's/  */ /g' \
    | cut -d' ' -f2,11-
end

function prep_to_path -d "Prepend the given dir to PATH if it exists and is not already in it"
    if test -d $argv[1]
        if not contains $argv[1] $PATH
            set -gx PATH "$argv[1]" $PATH
        end
    end
end


