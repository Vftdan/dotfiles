#! /bin/sh
unset GNOME_TERMINAL_SCREEN
unset GNOME_TERMINAL_SERVICE
# Desktop 0 ctl(1)
bspc desktop ^1 -l monocle
bspc rule -a kshutdown:kshutdown -o desktop=^1
# bspc rule -a kshutdown:kshutdown -o node=@^1:^1:/1
kshutdown &
bspc rule -a Psensor:psensor -o desktop=^1
# bspc rule -a Psensor:psensor -o node=@^1:^1:/2/1
psensor &
# apt
bspc rule -a Gnome-terminal:gnome-terminal-server -o desktop=^1
# bspc rule -a Gnome-terminal:gnome-terminal-server -o node=@^1:^1:/2/2
gnome-terminal &
# Desktop 1 web(2)
bspc desktop ^2 -l monocle
bspc desktop -f ^2
firefox &
# Desktop 2 msg(3)
bspc desktop ^3 -l monocle
# htop
bspc rule -a Gnome-terminal:gnome-terminal-server -o desktop=^3
# bspc rule -a Gnome-terminal:gnome-terminal-server -o node=@^1:^3:/1/1
gnome-terminal &
bspc rule -a TelegramDesktop:Telegram -o desktop=^3
# bspc rule -a TelegramDesktop:Telegram -o node=@^1:^3:/2
~/Downloads/Telegram/Telegram -workdir ~/.local/share/TelegramDesktop/ -- &
# ipython
# FIXME wait other terminal rules to fire before adding this one & opening ipython terminal
bspc rule -a Gnome-terminal:gnome-terminal-server -o desktop=^3
# bspc rule -a Gnome-terminal:gnome-terminal-server -o node=@^1:^3:/1/2
x-terminal-emulator -e tmux new -As ipython -c "$HOME" bash -c 'python3.8 -m IPython -i -c "import numpy as np; import pandas as pd; from math import *"' &
# Desktop 3 mus(4)
bspc desktop ^4 -l monocle
bspc rule -a Clementine:clementine -o desktop=^4
# bspc rule -a Clementine:clementine -o node=@^1:^4:/1
clementine &
bspc rule -a Cinnamon-settings.py:cinnamon-settings.py -o desktop=^4
# bspc rule -a cinnamon-settings sound:cinnamon-settings sound -o node=@^1:^4:/2
cinnamon-settings sound &
# Desktop 4 cal(5)
# Desktop 5 gp1(6)
# Desktop 6 gp2(7)
# Desktop 7 gp3(8)
# Desktop 8 gp4(9)
# Desktop 9 emu(0)
bspc desktop ^10 -l monocle
