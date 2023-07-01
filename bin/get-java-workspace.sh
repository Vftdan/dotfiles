#! /bin/sh

while true; do
	if [ -d .metadata ]; then \
		# Is it possible?
		pwd
		exit 0
	fi
	if [ -d workspace -a -d workspace/.metadata ]; then \
		cd workspace
		pwd
		exit 0
	fi
	if [ "$PWD" = "/" ]; then
		exit 1
	fi
	cd ..
done
