#! /bin/sh

onlyvisible() {
	while read w rest; do \
		bspc query -N -n $w'.!hidden' | if read w; then \
			echo "$w" "$rest"
		fi
	done
}

panelheight=80
if [ $# -gt 0 ]; then \
	panelheight=$1
fi
bspc subscribe all | \
		egrep --line-buffered '^desktop_focus|^node_state.*(fullscreen|floating)|^node_flag.*hidden|^node_remove|^pointer_action|^node_geometry' | \
		while read line; do \
	# "compton-trans -n ..." doesn't terminate 
	w=$(lsw | grep tint2 | cut -f 1 -d' ')
	# Sometimes the wrong desktop is used
	# Hopefully, a small delay will fix it
	echo "$line" | egrep -q 'desktop_focus' && sleep .1
	d=$(wmctrl -d | sed -e 's/ \+/\t/g' | egrep '^[0-9]+\s\*' | cut -f 1)
	# consider using awk
	miny=$(wmctrl -lG | onlyvisible | sed -e 's/ \+/\t/g' | cut -f 2,4 | \
			egrep "^$d\\s" | cut -f 2 | sort -n | head -n 1)
	if [ "$miny" -lt "$panelheight" ]; then \
		compton-trans -w "$w" -o 35
	else
		compton-trans -w "$w" -o 100
	fi
done
