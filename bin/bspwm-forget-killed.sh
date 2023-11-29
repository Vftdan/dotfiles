#! /bin/sh

xprop -root >/dev/null || exit "$?"
bspc query -N -n '.window' | while read -r w; do \
	xprop -id "$w" >/dev/null 2>/dev/null || bspc node "$w" -k
done
