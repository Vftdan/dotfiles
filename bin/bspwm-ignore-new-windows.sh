#! /bin/sh
last_presel='0x0'
last_presel_ns='0'

bspc subscribe node | egrep --line-buffered '^node_(manage|add|presel|remove)' | while read line; do \
	if ( echo $line | grep -q '^node_presel' ); then \
		last_presel=$(echo $line | cut -d ' ' -s -f 4)
		last_presel_ns=$(date +%s%N)
	elif ( echo $line | grep -q '^node_remove' ); then \
		node=$(echo $line | cut -d ' ' -s -f 4)
		# FIXME $node is already unlinked, this NODE_SEL doesn't exist
		bspc node $node\#@parent -R 270
	else
		new=$(echo $line | cut -d ' ' -s -f 4)
		old=$(echo $line | cut -d ' ' -s -f 5)
		if ( echo $line | grep -q '^node_add' ); then \
			tmp="$new"
			new="$old"
			old="$tmp"
			# see git@github.com:baskerville/bspwm.git commit 1966104
		fi
		if [ \! \( \( $(( $(date +%s%N) - $last_presel_ns )) -lt 20000000 \) \
			-a \( "$old" = "$last_presel" \) \) ]; then \
			if ( echo $line | grep -q '^node_add' ); then \
				bspc node $old\#@parent/brother -R 90
				bspc node $new -n $old\#@parent/brother
			else
				bspc node $new -s $old
			fi
			[ -z "$(xdetectgrab -knd 1 1)" ] && bspc node $old -f
		fi
	fi
done
