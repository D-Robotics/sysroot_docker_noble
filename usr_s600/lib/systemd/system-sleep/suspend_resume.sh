#!/bin/bash

PATH=/sbin:/usr/sbin:/bin:/usr/bin

case "$1" in
    pre)
        bash suspend-action.sh
        ;;
    post)
        bash resume-action.sh
        ;;
    *)
        echo "Usage: $0 {pre|post}"
        exit 1
        ;;
esac

exit 0
