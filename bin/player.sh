#! /bin/sh

showhelp() {
	echo "Usage: $0 -g|-s|-c method_name|property_name [args...]"
	echo '\t-g\tGet property'
	echo '\t-s\tSet property'
	echo '\t-c\tCall method'
}

test "$#" '<' 2 && showhelp && return 255

player=$(qdbus org.mpris.MediaPlayer2.\* | head -n 1)
test "$player" = "" && return 1
act=$1
shift
method=""
case $act in
	"-g")	act=org.freedesktop.DBus.Properties.Get;;
	"-s")	act=org.freedesktop.DBus.Properties.Set;;
	"-c")	act=""
		method=".$1";
		shift;;
	"-h"|"--help")
		showhelp
		return 0;;
	*)	echo 'Unknown act:' $act
		return 2;;
esac
qdbus $player /org/mpris/MediaPlayer2 $act "org.mpris.MediaPlayer2.Player$method" $@
