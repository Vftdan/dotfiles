#! /bin/sh

bspc subscribe node | egrep --line-buffered '^node_manage' | while read line; do \
	new=$(echo $line | cut -d ' ' -s -f 4)
	if [ "$(bspc query -T -n $new | jq -r '.client.state')" = "tiled" ]; then \
		bspc node $new -t pseudo_tiled
		(sleep .1; bspc node $new -t tiled) &
	fi
done
