bspwm:
	for i in bspwm xkb sxhkd rofi dunst tint2; do\
		mkdir -p ${HOME}/.config/$$i;\
		cp ./$$i/* ${HOME}/.config/$$i/;\
	done
	cp xsettingsd/.xsettingsd ${HOME}/

.PHONY: bspwm
