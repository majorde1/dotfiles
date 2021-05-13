#!/bin/bash

mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_DATA_HOME"

#############
# alacritty #
#############
rm -rf "$XDG_CONFIG_HOME/alacritty"
ln -s "$DOTFILES/alacritty" "$XDG_CONFIG_HOME/alacritty"

##############
# fontconfig #
##############
mkdir -p "$XDG_CONFIG_HOME/fontconfig"
mkdir -p "$XDG_CONFIG_HOME/fontconfig/conf.d"
ln -sf "$DOTFILES/fontconfig/fonts.conf" "$XDG_CONFIG_HOME/fontconfig/fonts.conf"

#########
# fonts #
#########
rm -rf "$XDG_CONFIG_HOME/fonts"
rm -rf "$HOME/.fonts"
ln -s "$DOTFILES/fonts" "$XDG_DATA_HOME/fonts"
ln -s "$DOTFILES/fonts" "$HOME/.fonts"

#######
# git #
#######
rm -rf "$XDG_CONFIG_HOME/git"
ln -s "$DOTFILES/git" "$XDG_CONFIG_HOME/git"

############
# i3blocks #
############
rm -rf "$XDG_CONFIG_HOME/i3blocks"
ln -s "$DOTFILES/i3blocks" "$XDG_CONFIG_HOME/i3blocks"

########
# mako #
########
rm -rf "$XDG_CONFIG_HOME/mako"
ln -s "$DOTFILES/mako" "$XDG_CONFIG_HOME/mako"

########
# nvim #
########
mkdir -p "$XDG_CONFIG_HOME/nvim"
mkdir -p "$XDG_CONFIG_HOME/nvim/undo"
rm -rf "$XDG_CONFIG_HOME/nvim/colors"
rm -rf "$XDG_CONFIG_HOME/nvim/config"
rm -rf "$XDG_CONFIG_HOME/nvim/ftplugin"
ln -sf "$DOTFILES/nvim/init.vim" "$XDG_CONFIG_HOME/nvim/init.vim"
ln -s "$DOTFILES/nvim/colors" "$XDG_CONFIG_HOME/nvim/colors"
ln -s "$DOTFILES/nvim/config" "$XDG_CONFIG_HOME/nvim/config"
ln -s "$DOTFILES/nvim/ftplugin" "$XDG_CONFIG_HOME/nvim/ftplugin"

# Plugin manager
[[ ! -f "$XDG_CONFIG_HOME/nvim/autoload/plug.vim" ]] \
  && curl -fLo "$XDG_CONFIG_HOME/nvim/autoload/plug.vim" --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim --noplugin +PlugUpdate +qa

########
# sway #
########
rm -rf "$XDG_CONFIG_HOME/sway"
ln -s "$DOTFILES/sway" "$XDG_CONFIG_HOME/sway"

########
# tmux #
########
mkdir -p "$XDG_CONFIG_HOME/tmux"
ln -sf "$DOTFILES/tmux/tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf"

[[ ! -d "$XDG_CONFIG_HOME/tmux/plugins/tpm" ]] \
  && git clone https://github.com/tmux-plugins/tpm \
  "$XDG_CONFIG_HOME/tmux/plugins/tpm"

#######
# X11 #
#######
rm -rf "$XDG_CONFIG_HOME/X11"
ln -s "$DOTFILES/X11" "$XDG_CONFIG_HOME/X11"

#######
# zsh #
#######
mkdir -p "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/zsh/.zshenv" "$XDG_CONFIG_HOME/zsh/.zshenv"
ln -sf "$DOTFILES/zsh/.zshrc" "$XDG_CONFIG_HOME/zsh/.zshrc"
ln -sf "$DOTFILES/zsh/aliases" "$XDG_CONFIG_HOME/zsh/aliases"

rm -rf "$XDG_CONFIG_HOME/zsh/external"
ln -sf "$DOTFILES/zsh/external" "$XDG_CONFIG_HOME/zsh/external"
