#! /bin/sh

printerr() {
	printf '%s\n' "$*" >&2
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

make_chapter_command() { (
	while true; do \
		read -r open_tag || return $?
		if [ "$open_tag" != '[CHAPTER]' ]; then \
			printerr "Expected '[CHAPTER]', got: '$open_tag'"
			continue
		fi
		break
	done
	title=''
	id=''
	start_time=''
	end_time=''
	while true; do \
		read -r field || {
			printerr "Unexpected EOF while parsing chapter list"
			return $?
		}
		if [ "$field" = '[/CHAPTER]' ]; then \
			break
		fi
		key="$(printf '%s\n' "$field" | cut -d '=' -f 1)"
		value="$(printf '%s\n' "$field" | cut -d '=' -f 2-)"
		case "$key" in
			id)
				id="$value"
				if [ -z "$title" ]; then \
					title="$value"
				fi
				continue;;
			'TAG:title')
				title="$value"
				continue;;
			start_time)
				start_time="$value"
				continue;;
			end_time)
				end_time="$value"
				continue;;
		esac
	done
	if [ -z "$title" ]; then \
		printerr "Missing title between $start_time--$end_time, skipping"
		return
	fi
	if [ -z "$id" ]; then \
		printerr "Missing id for chapter '$title', skipping"
		return
	fi
	if [ -z "$start_time" ]; then \
		printerr "Missing start_time for chapter '$title', skipping"
		return
	fi
	if [ -z "$end_time" ]; then \
		printerr "Missing end_time for chapter '$title', skipping"
		return
	fi
	input="$1"
	shift
	base="${input%.*}"
	ext="${input#"$base."}"
	tracknum="$((id + 1))"
	shellescape ffmpeg -hide_banner -loglevel warning -stats -i "$input" -ss "$start_time" -to "$end_time" -metadata title="$title" -metadata title="$title" -metadata album="$base" -metadata track="$tracknum" "$@" "$tracknum. ${input%.*} - ${title}.$ext"
	echo
) }

if [ $# -lt 1 ]; then \
	printerr "Usage: $0 <filename> [<additional ffmpeg output settings...>]"
	exit 1
fi

# Preserve stdin:
exec 9>&0 || exit "$?"

ffprobe -hide_banner -loglevel error -show_chapters "$1" | while make_chapter_command "$@"; do :
done | while read -r cmd; do \
	printerr "Running: $cmd"
	eval "$cmd" 0>&9
done
