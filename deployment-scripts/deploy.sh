#! /bin/bash
dotfiles=$(realpath $(dirname $0)/..)
config=$XDG_CONFIG_HOME
[ -z "$config" ] && config=$HOME/.config
[ -d "$config" ] || mkdir -p "$config"
cp -a "$dotfiles/bin/." "$HOME/bin"
cp -a "$dotfiles/editor/nvim/." "$config/nvim"
cp "$dotfiles/editor/nvim/init.vim" "$HOME/.vimrc"
cp "$dotfiles/core/.profile" "$HOME/"
cp "$dotfiles/core/bash/.bashrc" "$HOME/"
cp "$dotfiles/core/tmux/.tmux.conf" "$HOME/"

cd $dotfiles/extra
make
[ -n "$DISPLAY" ] && (cd dconf && make)
