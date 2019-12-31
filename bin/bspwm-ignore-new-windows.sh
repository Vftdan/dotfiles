#! /bin/sh
bspc subscribe node | grep --line-buffered '^node_manage' | while read line; do \
	new=$(echo $line | cut -d ' ' -s -f 4)
	old=$(echo $line | cut -d ' ' -s -f 5)
	bspc node $new -s $old
	bspc node $old -f
done
