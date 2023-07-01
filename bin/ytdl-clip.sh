#! /bin/sh
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
	echo
}

if [ $# -lt 3 ]; then \
	echo "Usage: $0"' <start-position> <end-position|"+"duration> <url> [<youtube-dl-args...>]' >&2
	echo 'Environment: $ffmpeg_args - additional arguments for ffmpeg' >&2
	return 1
fi
ss="$1"
to="$2"
case "$to" in
	+*)
		t="${to#+}"
		# FIXME: end position cannot be 24h or more
		to="$(date -ud "@$(printf '%s\n%s\n' "$ss" "$t" | awk -F: '{k = 0; for (i = NF; i >= 1; --i) secs += $i * 60 ^ k++ } END {print secs}')" +'%T.%N' | sed -E 's/^[0:]*//; s/(\d*[1-9]|0)0*$/\1/')"
		;;
esac
shift 2
youtube-dl -f '22/720p/bestvideo[ext=mp4][height<=720]+bestaudio[ext=m4a]/best[ext=mp4][height<=720]/best[height<=720]/best' --external-downloader ffmpeg --external-downloader-args "$(shellescape -async 1 -movflags faststart -avoid_negative_ts 1 $ffmpeg_args)" --download-sections "*$ss-$to" -o "%(title)s [%(id)s] clip${ss}--${to}.%(ext)s" "$@"
