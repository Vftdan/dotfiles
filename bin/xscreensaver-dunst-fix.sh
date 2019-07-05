#! /bin/sh
xscreensaver-command -watch | while read i; do \
	e=$(echo "$i" | cut -d ' ' -f 1)
	case "$e" in
		'BLANK'|'LOCK')
			pkill -STOP -x dunst
			;;
		'UNBLANK')
			pkill -CONT -x dunst
			;;
	esac
done
