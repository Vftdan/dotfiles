#! /bin/sh
shellescapelines() {
	while read -r line; do \
		printf "'"
		printf '%s' "$line" | sed -e "s/'/'\\\\''/g"
		printf "' "
	done
	echo
}

get_clementine_library() {
	sqlite3 ~/.config/Clementine/clementine.db '.mode tabs' 'select coalesce(artist, albumartist), title, album, coalesce(albumartist, artist), filename from songs;'
}

get_clementine_saved_streams() {
	cat ~/.config/Clementine/Clementine.conf | sed -nE '/^\[SavedRadio\]/,$p' | tail -n +2 | sed -E '/^\[/q' | grep -e '^streams\\[0-9]' | sort -n -t '\' -k 2 -s | sed -E 's/^streams\\[0-9]+\\//' | while read -r name && read -r url; do \
		printf '%s\n%s\n' "$name" "$url" | sort | sed -E 's/^[^=]+=//' | sed -E 's/^\@Variant\(([^\\]|\\([xu]?[0-9A-Fa-f]{1,4}|.)){8}(.*)\)/\3/' | {
			read -r name
			read -r url
			printf '\t%s\t\t\t%s\n' "$name" "$url"
		}
	done
}

{ get_clementine_library; get_clementine_saved_streams; } | rofi -i -dmenu | awk '{print $NF}' | shellescapelines | xargs -r mpv --audio-device='pulse/shareable_and_combined' --force-window=yes
