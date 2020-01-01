#! /bin/sh
last_presel='0x0'
last_presel_ns='0'

bspc subscribe node | egrep --line-buffered '^node_(manage|presel)' | while read line; do \
	if ( echo $line | grep -q '^node_presel' ); then \
		last_presel=$(echo $line | cut -d ' ' -s -f 4)
		last_presel_ns=$(date +%s%N)
	else
		new=$(echo $line | cut -d ' ' -s -f 4)
		old=$(echo $line | cut -d ' ' -s -f 5)
		if [ \! \( \( $(( $(date +%s%N) - $last_presel_ns )) -lt 20000000 \) \
			-a \( "$old" = "$last_presel" \) \) ]; then \
			bspc node $new -s $old
			[ -z "$(xdetectgrab -knd 1 1)" ] && bspc node $old -f
		fi
	fi
done
