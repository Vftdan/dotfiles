all: bspwm terminfo pulse applications

bspwm: themes/Mint-Y-Dark-Custom
	for i in bspwm xkb sxhkd rofi dunst tint2; do\
		mkdir -p ${HOME}/.config/$$i;\
		cp ./$$i/* ${HOME}/.config/$$i/;\
	done
	cp xsettingsd/.xsettingsd ${HOME}/
	cp xcompose/.XCompose ${HOME}/

${HOME}/.local/share/themes/Mint-Y-Dark-Custom:
	mkdir -p ${HOME}/.local/share/themes/
	cp -r themes/Mint-Y-Dark-Custom/. ${HOME}/.local/share/themes/Mint-Y-Dark-Custom/.
	echo 'Run:' >&2
	echo 'sudo ln -s "${HOME}/.local/share/themes/Mint-Y-Dark-Custom" /usr/share/themes/Mint-Y-Dark-Custom' >&2

terminfo: ${HOME}/.terminfo

${HOME}/.terminfo: xterm-24bit.ti tmux-24bit.ti st-24bit.ti termux-24bit.ti
	cat $^ | tic -x -o "$@" -

pulse:
	mkdir -p ${HOME}/.config/pulse
	cp ./pulse/* ${HOME}/.config/pulse/

applications:
	mkdir -p ${HOME}/.local/share/applications/
	cp ./applications/* ${HOME}/.local/share/applications/

.PHONY: bspwm terminfo pulse applications all
