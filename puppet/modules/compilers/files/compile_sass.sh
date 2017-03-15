#!/bin/bash

COMPASS="/usr/bin/compass"

case "$1" in
    ""|start)
    echo "Starting compass watch..."
    nohup $COMPASS watch > /dev/null 2>/dev/null &
    echo "Done."
    ;;

    stop)
    echo "Stopping compass watch..."
    sudo kill -9 $(ps aux | grep '[c]ompass' | awk '{print $2}')
    echo "Done."
    ;;
esac

exit 0