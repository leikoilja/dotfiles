#!/usr/bin/env bash
#
# Setting stuff up...
#

# Get symulinks directory
DIR="/Users/leikoilja/Development/Dev_settings/dotfiles/symulinks"

# Setup symbolic links
# Should check if they already exist and in that case unlink or delete
ln -hfs "$DIR/.aliases" ~/.aliases
ln -hfs "$DIR/.autoenv" ~/.autoenv
ln -hfs "$DIR/.bashrc" ~/.bashrc
ln -hfs "$DIR/.coc-settings.json" ~/.config/nvim/coc-settings.json
ln -hfs "$DIR/.editorconfig" ~/.editorconfig
ln -hfs "$DIR/.eslintrc.json" ~/.eslintrc.json
ln -hfs "$DIR/.gitconfig" ~/.gitconfig
ln -hfs "$DIR/.gitignore" ~/.gitignore
ln -hfs "$DIR/.ssh" ~/.ssh
ln -hfs "$DIR/.tmux.conf" ~/.tmux.conf
ln -hfs "$DIR/.tmux.conf.local" ~/.tmux.conf.local
ln -hfs "$DIR/.tmuxinator.zsh" ~/.tmuxinator.zsh
ln -hfs "$DIR/.vifmrc" ~/.vifmrc
ln -hfs "$DIR/.vimrc" ~/.vimrc
ln -hfs "$DIR/.vimrc" ~/.vimrc
ln -hfs "$DIR/.zshrc_mac" ~/.zshrc
