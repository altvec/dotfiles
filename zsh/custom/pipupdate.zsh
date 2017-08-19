function pipupdate() {
    PIP_VER="pip3"
    if [[ $argv[1] -eq 2 ]]; then
	PIP_VER="pip2"
    fi
    echo "Updating packages for ${PIP_VER}"
    $PIP_VER freeze --local \
	| grep -v '\-e' \
	| cut -d = -f 1 \
	| grep -v 'vboxapi' \
	| xargs $PIP_VER install -U
}    
