#!/bin/sh

PID=$(cat ~/.offlineimap/pid)
ps aux | grep "[ ]$PID" && kill $PID

function sync_normal {
    echo "NORMAL sync"
    /usr/local/bin/offlineimap -o -u quiet
}

function sync_quick {
    echo "QUICK Sync"
    /usr/local/bin/offlineimap -o -q -u quiet
}

python -c 'import sys, random; sys.exit(random.randint(0, 5))' && sync_normal || sync_quick

exit 0
