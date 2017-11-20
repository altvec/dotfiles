function pman -d "Open man page in Preview.app"
    man -t $argv[1] | open -f -a /Applications/Preview.app
end
