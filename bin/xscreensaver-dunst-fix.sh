#! /bin/sh
xscreensaver-command -watch | while read i; do \
	e=$(echo "$i" | cut -d ' ' -f 1)
	case "$e" in
		'BLANK'|'LOCK')
			dunstctl set-paused true
			;;
		'UNBLANK')
			dunstctl set-paused false
			;;
	esac
done
