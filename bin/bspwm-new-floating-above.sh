#! /bin/sh

getwindowtype() {
	xprop -id $1 | grep '^_NET_WM_WINDOW_TYPE(ATOM) = ' | sed -e 's/^.*=\s_NET_WM_WINDOW_TYPE_\([A-Za-z0-9_]*\)$/\1/'
}

shouldbefloating() {
	TRUE=0
	FALSE=1
	case "$(getwindowtype $1)" in
		DIALOG)
			return $TRUE;;
		*)
			return $FALSE;;
	esac
}

bspc subscribe node | egrep --line-buffered '^node_(manage|add)' | while read line; do \
	new=$(echo $line | cut -d ' ' -s -f 4)
	old=$(echo $line | cut -d ' ' -s -f 5)
	if ( echo $line | grep -q '^node_add' ); then \
		tmp="$new"
		new="$old"
		old="$tmp"
	fi
	if shouldbefloating $new; then \
		bspc node $new -t floating
	fi
	if [ "$(bspc query -T -n $new | jq -r '.client.state')" = "floating" ] && \
			[ "$(bspc query -T -n $old | jq -r '.client.state')" = "floating" ] && \
			[ "$(bspc query -T -n $new | jq -r '.client.layer')" = "normal" ]
			then \
		bspc node $new -l above
		#echo $new
		(sleep .3; bspc node $new -l normal) &
	fi
done
