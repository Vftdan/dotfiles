#! /bin/sh

showhelp() {
	echo "Usage: $0 [-L] [-i interface] -g|-s|-c method_name|property_name [args...]"
	echo "       $0 -l|-G"
	echo "       $0 -S service_name"
	echo '\t-L\tRun qdbus with --literal'
	echo '\t-i\tInterface inside org.mpris.MediaPlayer2 (default: Player)'
	echo '\t-g\tGet property'
	echo '\t-s\tSet property'
	echo '\t-c\tCall method'
	echo '\t-l\tList players'
	echo '\t-G\tGet current player'
	echo '\t-S\tSet current player'
}

listplayers() {
	qdbus org.mpris.MediaPlayer2.\*
}

getplayer() {
	player=$(xprop -root _playersh_player | fgrep = | sed -e 's/^.*=\s"\(.*\)"$/\1/')
	player=$(listplayers | fgrep -x -e "$player")
	if [ "$player" = "" ]; then \
		listplayers | head -n 1
	else
		echo "$player"
	fi
}

setplayer() {
	xprop -root -format _playersh_player 8u -set _playersh_player "$1"
}

getplaylists() {
	startidx=$1
	count=$2
	( main -L -i Playlists -c GetPlaylists "$startidx" "$count" User false | sed -e 's/^.*{\[//; s/\]}\]$//; s/\], \[/\n/g' )
}

getactiveplaylist() {
	player.sh -L -i Playlists -g ActivePlaylist | grep ObjectPath | sed -E 's/^(\[[^[]*){2}\[(.*\]).*/\2/; s/\]\]\]$//'
}

playlisttoobject() {
	sed -E 's/^.*\[ObjectPath: ([^]]*)\].*$/\1/'
}

playlisttoname() {
	sed -E 's/^[^,]*, "//; s/", ".*"$//'
}

playlisttoicon() {
	sed -E 's/^[^,]*, ".*", "//; s/"$//'
}

main() {
	interface="Player"
	literal=""
	while true; do \
		case "$1" in
			"-h"|"--help")
				showhelp
				return 0;;
			"-l"|"--list-players")
				listplayers
				return 0;;
			"-G"|"--get-player")
				getplayer
				return 0;;
			"-S"|"--set-player")
				setplayer "$2"
				return 0;;
			"--get-playlists")
				getplaylists 0 9999
				return $?;;
			"--get-active-playlist")
				getactiveplaylist
				return $?;;
			"-i"|"--interface")
				interface="$2"
				shift 2;;
			"-L"|"--literal")
				literal="--literal"
				shift;;
			"--get-playlists")
				getplaylists 0 9999
				return $?;;
			"--get-active-playlist")
				getactiveplaylist
				return $?;;
			"--next-playlist")
				playlist=$(getplaylists 0 9999 | fgrep -A 1 "$(getactiveplaylist | playlisttoobject)" | tail -n 1 | playlisttoobject)
				main -i Playlists -c ActivatePlaylist "$playlist"
				return $?;;
			"--prev-playlist")
				playlist=$(getplaylists 0 9999 | fgrep -B 1 "$(getactiveplaylist | playlisttoobject)" | head -n 1 | playlisttoobject)
				main -i Playlists -c ActivatePlaylist "$playlist"
				return $?;;
			"--playlist-to-object")
				playlisttoobject
				return $?;;
			"--playlist-to-name")
				playlisttoobject
				return $?;;
			"--playlist-to-icon")
				playlisttoicon
				return $?;;
			*)
				break;;
		esac
	done

	test "$#" '<' 2 && showhelp >&2 && return 255

	act=$1
	shift
	method=""
	case "$act" in
		"-g")	act=org.freedesktop.DBus.Properties.Get;;
		"-s")	act=org.freedesktop.DBus.Properties.Set;;
		"-c")	act=""
			method=".$1";
			shift;;
		*)	echo 'Unknown act:' $act >&2
			return 2;;
	esac
	player=$(getplayer)
	test "$interface" \!= "" && interface=".$interface"
	test "$player" = "" && return 1
	setplayer "$player"
	qdbus $literal $player /org/mpris/MediaPlayer2 $act "org.mpris.MediaPlayer2$interface$method" "$@"
}

main "$@"
exit $?
