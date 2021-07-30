#! /bin/sh

showusage() {
	cat <<END
Usage: $0 <action>
Actions:
	help     Show this message
	daemon   Run event loop (there should be exactly one daemon process
	         at any given time)
	enable   Enable event handling
	disable  Disable event handling
	toggle   Toggle event handling
	status   Get event handling state (1 for enabled, 0 for disabled)
END
}

getboolprop() {
	local p="$(xprop -root | grep '^'"$1"'(CARDINAL) = ' | sed -e 's/^.*=\s\([0-9]*\)$/\1/')"
	[ -z "$p" ] && local p=0
	echo $p
}

setboolprop() {
	xprop -root -format "$1" 8c -set "$1" "$2"
}

togboolprop() {
	[ 0 -eq "$(getboolprop "$1")" ] && setboolprop "$1" 1 || setboolprop "$1" 0
}

case "$1" in
	help|--help|-h)
		showusage
		exit 0;;
	daemon|--daemon|-D)
		;;
	enable|--enable|-e)
		setboolprop _BSPWM_FOCUSED_CHILD_BIGGER_STATE 1
		exit $?;;
	disable|--disable|-d)
		setboolprop _BSPWM_FOCUSED_CHILD_BIGGER_STATE 0
		exit $?;;
	toggle|--toggle|-t)
		togboolprop _BSPWM_FOCUSED_CHILD_BIGGER_STATE
		exit $?;;
	status|--status|-s)
		getboolprop _BSPWM_FOCUSED_CHILD_BIGGER_STATE
		exit $?;;
	*)
		echo "Unknown action: '$1'" >&2
		showusage >&2
		exit 1;;
esac

getrelative() {
	bspc query -N -n "$1#@$2" | tr -d '\n'
}

getparent() {
	getrelative "$1" parent
}

swapsizes() {
	## Variant 1:
	# bspc node "$1#@parent" -R 180
	# bspc node "$1" -s "$1#@brother"
	# bspc node "$1#@brother" -R 180
	# bspc node "$1" -R 180
	## Variant 2:
	local n="$1#@parent"
	local r=$(bspc query -T -n "$n" | jq '.splitRatio')
	bspc node "$n" -r "$(echo "1 - $r" | bc -l)"
}

bspc subscribe node | egrep --line-buffered '^node_focus' | while read line; do \
	if [ "$(getboolprop _BSPWM_FOCUSED_CHILD_BIGGER_STATE)" -eq 0 ]; then \
		continue
	fi
	node=$(echo $line | cut -d ' ' -s -f 4)
	case "$(bspc query -T -n "$node" | jq -r '.client.state')" in
		floating|fullscreen)
			continue;;
	esac
	while [ -n "$node" ]; do \
		par="$(getparent $node)"
		[ -z "$par" ] && break
		rat=$(bspc query -T -n $par | jq '.splitRatio')
		op='<'
		[ "$node" = "$(getrelative $par 2)" ] && op='>'
		if [ "$(echo "$rat $op 0.5" | bc -l)" -eq 1 ]; then \
			swapsizes "$node"
		fi
		node="$par"
	done
done
