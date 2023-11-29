#! /bin/sh
last_presel='0x0'
last_presel_ns='0'

bspc subscribe node | egrep --line-buffered '^node_(manage|add|presel)' | while read line; do \
	if ( echo $line | grep -q '^node_presel' ); then \
		last_presel=$(echo $line | cut -d ' ' -s -f 4)
		last_presel_ns=$(date +%s%N)
	else
		new=$(echo $line | cut -d ' ' -s -f 4)
		old=$(echo $line | cut -d ' ' -s -f 5)
		if ( echo $line | grep -q '^node_add' ); then \
			tmp="$new"
			new="$old"
			old="$tmp"
			# see git@github.com:baskerville/bspwm.git commit 1966104
		fi
		xprop -id "$new" | egrep '^(_NET_WM_STATE\()' | if grep -q '_NET_WM_STATE_SKIP_TASKBAR'; then \
			continue
		elif [ \! \( \( $(( $(date +%s%N) - $last_presel_ns )) -lt 20000000 \) \
			-a \( "$old" = "$last_presel" \) \) ]; then \
			bspc node $new -s $old
			[ -z "$(xdetectgrab -knd 1 1)" ] && \
					! bspc query -N -n "$new.fullscreen" >/dev/null && {
				bspc node $old -a || \
				bspc node $old -f
			}
		fi
	fi
done
