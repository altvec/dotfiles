# Unpack file of $type
function unpk() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)  tar xvjf $1                     ;;
            *.tar.gz)   tar xvzf $1                     ;;
            *.bz2)      bunzip2 $1                      ;;
            *.rar)      rar x $1                        ;;
            *.gz)       gunzip $1                       ;;
            *.tar)      tar xvf $1                      ;;
            *.tbz2)     tar xvjf $1                     ;;
            *.tgz)      tar xvzf $1                     ;;
            *.zip)      unzip $1                        ;;
            *.Z)        uncompress $1                   ;;
            *.7z)       7z x $1                         ;;
            *)          echo "'$1' cannot be extracted" ;;
        esac
    else
        "'$1' is not a valid file"
    fi
}

# View man pages as PDF
function pman() {
    man -t "${1}" | open -f -a /Applications/Preview.app
}

# Show file/dir size
function size() {
    du -sc "$@" 2>&1 | grep -v '^du:'
}

# Show how much RAM application uses
# $ ram firefox
function ram() {
    local sum
    local items
    local app="$1"
    if [ -z "$app" ]; then
        echo "First argument - pattern to grep from processes"
    else
        sum=0
        # Ugly hack for Safari, sicne it uses separate processes for rendering
        # webpages in opened tabs
        if [[ "$app" == "safari" ]] || [[ "$app" == "Safari" ]]; then
            for i in `ps aux | grep -i "$app\|com.apple.WebKit.WebContent" | grep -v "grep" | awk '{ print $6 }'`; do
                sum=$(($i + $sum))
            done
        fi
        for i in `ps aux | grep -i "$app" | grep -v "grep" | awk '{ print $6 }'`; do
            sum=$(($i + $sum))
        done
        sum=$(echo "scale=2; $sum / 1024.0" | bc)
        if [[ $sum != "0" ]]; then
            echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM."
        else
            echo "There are no processes with pattern '${fg[blue]}${app}${reset_color}' are running."
        fi
    fi
}

# Monitor IO in real-time
function openfiles() {
    sudo dtrace -n 'syscall::open*:entry { printf("%s %s",execname,copyinstr(arg0)); }'
}
