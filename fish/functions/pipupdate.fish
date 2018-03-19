# Python stuff

function pipupdate -d "Update Python's packages"
    set PIP_VER pip3
    if test $argv[1] -eq 2
        set PIP_VER pip2
    end
    echo "Updating packages for $PIP_VER"
    eval $PIP_VER freeze --local \
        | grep -v '^\-e' \
        | cut -d = -f 1 \
        | grep -v 'vboxapi' \
        | xargs $PIP_VER install -U
end        
