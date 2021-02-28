#! /usr/bin/env sh
# Based on <url:https://github.com/LukeSmithxyz/voidrice/blob/master/.local/bin/statusbar/sb-battery>
while read i; do case $i in
	"Full") echo "⚡" ;;
	"Discharging") echo "🔋" ;;
	"Charging") echo "🔌" ;;
	"Not charging") echo "🛑" ;;
	"Unknown") echo "♻️" ;;
esac; done
