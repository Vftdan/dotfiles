#! /bin/sh

download_dir="${TMPDIR:-/tmp}/Down"
dmenu="dmenu"
if which rofi >/dev/null; then \
	dmenu="rofi -dmenu"
fi

printusage() {
	echo "Usage: $0 [--] <urls...>"
	echo "       $0 -e|-d|-t|-l|-g|-S|-P|-"
	echo "       $0 -s <command>"
	echo '\t-e, --enable\tEnable manual: show prompt every time'
	echo '\t-d, --disable\tDisable manual: use saved value'
	echo '\t-t, --toggle\tToggle manual'
	echo '\t-l, --list\tList builtin handlers'
	echo '\t-g, --set\tGet saved handler'
	echo '\t-s, --get\tSet saved handler'
	echo '\t-S, --select\tSelect and set saved handler'
	echo '\t-P, --paste\tRead urls from clipboard'
	echo '\t-, --stdin\tRead urls from stdin'
	echo '\t-h, --help\tShow this message'
}

shellescape() {
	while [ "$#" -gt 0 ]; do \
		printf "'"
		printf '%s' "$1" | sed -e "s/'/'\\\\''/g"
		printf "'"
		shift
		if [ "$#" -gt 0 ]
		then printf ' '
		fi
	done
}

generate_handlers() {
	shellescape exec xargs -r -d '\n' firefox
	echo

	shellescape exec xargs -r -d '\n' firefox -private
	echo

	shellescape exec xargs -r -d '\n' firefox -no-remote -P proxy -private
	echo

	shellescape exec xargs -r -d '\n' chromium
	echo

	shellescape exec xargs -r -d '\n' chromium --incognito
	echo

	shellescape exec xargs -r -d '\n' feh
	echo

	shellescape mkdir -p "$download_dir"
	printf '; '
	shellescape cd "$download_dir"
	printf '; '
	shellescape exec xargs -r -d '\n' wget
	echo

	shellescape mkdir -p "$download_dir"
	printf '; '
	shellescape cd "$download_dir"
	printf '; '
	shellescape exec xargs -r -d '\n' curl -J --remote-name-all
	echo

	shellescape exec xargs -r -d '\n' mpv --force-window=yes
	echo

	shellescape sed -e 's%^%ytdl://%'
	printf ' | '
	shellescape exec xargs -r -d '\n' mpv --force-window=yes --pause
	echo

	shellescape sed -e 's%^%ytdl://%'
	printf ' | '
	shellescape exec xargs -r -d '\n' mpv --force-window=yes --keep-open --ytdl-raw-options=yes-playlist='' --pause
	echo

	shellescape sed -e 's%^%ytdl://%'
	printf ' | '
	shellescape exec xargs -r -d '\n' mpv --force-window=yes --keep-open --ytdl-raw-options=yes-playlist='',format='140/bestaudio[ext=m4a]/bestaudio' --pause
	echo

	shellescape exec xargs -r -d '\n' vlc --no-one-instance
	echo

	shellescape exec xclip -i -selection clipboard
	echo

	shellescape exec xclip -i -selection primary
	echo
}

select_handler() {
	generate_handlers | $dmenu -p "Open url: $*"
}

get_property() {
	# get_property <unqualified_name>
	xprop -root _urlopenproxysh_"$1" | fgrep = | sed -e 's/^.*=\s\("\(.*\)"\|\([0-9]*\)\)$/\2\3/; s/\\\(.\)/\1/g'
}

set_property() {
	# set_property <unqualified_name> <datatype> <value>
	xprop -root -format "_urlopenproxysh_$1" "$2" -set "_urlopenproxysh_$1" "$3"
}

is_enabled() {
	state="$(get_property enabled)"
	if [ "0$state" -eq 0 ]; then \
		echo 0
	else
		echo 1
	fi
}

set_enabled() {
	set_property enabled 8c "$1"
}

tog_enabled() {
	if [ "$(is_enabled)" -eq 0 ]; then \
		set_enabled 1
	else
		set_enabled 0
	fi
}

get_saved_handler() {
	handler="$(get_property handler)"
	if [ -z "$handler" ]; then \
		handler="$(generate_handlers | head -n 1)"
	fi
	if [ -z "$handler" ]; then \
		handler="www-browser"
	fi
	printf '%s\n' "$handler"
}

set_saved_handler() {
	set_property handler 8u "$1"
}

select_saved_handler() {
	handler="$(select_handler "select default handler")"
	if [ -n "$handler" ]; then \
		set_saved_handler "$handler"
	fi
}

main() {
	if [ "$(is_enabled)" -eq 0 ]; then \
		handler="$(get_saved_handler)"
	else
		handler="$(select_handler "$@")"
	fi
	if [ -n "$handler" ]; then \
		for i in "$@"; do \
			printf '%s\n' "$i"
		done | exec bash -c "$handler"
	fi
}

case "$1" in
	"-h"|"--help")
		printusage
		exit 0;;
	"-e"|"--enable")
		set_enabled 1
		exit 0;;
	"-d"|"--disable")
		set_enabled 0
		exit 0;;
	"-t"|"--toggle")
		tog_enabled 0
		exit 0;;
	"-l"|"--list")
		generate_handlers
		exit 0;;
	"-g"|"--get")
		get_saved_handler
		exit 0;;
	"-s"|"--set")
		set_saved_handler "$2"
		exit 0;;
	"-S"|"--select")
		select_saved_handler
		exit 0;;
	"-P"|"--paste")
		xclip -o -selection clipboard | xargs -r -d '\n' "$0" --
		exit $?;;
	"-"|"--stdin")
		exec xargs -r -d '\n' "$0" --
		exit $?;;
	"--")
		shift
		main "$@";;
	''|-*)
		printusage >&2
		exit 1;;
	*)
		main "$@";;
esac
