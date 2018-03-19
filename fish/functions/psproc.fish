function psproc -d "Grep for a runnung process, returning it's PID and full string"
    ps auxww \
    | grep --color=always $argv \
    | grep -v grep \
    | sed -e 's/  */ /g' \
    | cut -d' ' -f2,11-
end

