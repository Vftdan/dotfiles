#! /bin/sh
#FIXME check hashsums
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt update
sudo apt install $(cat ubuntu-packages.txt)
sudo apt install qdbus || sudo apt install qdbus-qt5
sudo apt install bspwm sxhkd || \
	( wget http://archive.ubuntu.com/ubuntu/pool/universe/s/sxhkd/sxhkd_0.5.8-1_amd64.deb; \
	wget http://archive.ubuntu.com/ubuntu/pool/universe/b/bspwm/bspwm_0.9.3-1_amd64.deb )
sudo dpkg -i sxhkd_0.5.8-1_amd64.deb
sudo dpkg -i bspwm_0.9.3-1_amd64.deb
