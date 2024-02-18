#!/usr/bin/env bash
#
# Setting stuff up...
#

# Get symulinks directory
HOME="/Users/leikoilja"
DIR="$HOME/Development/Dev_settings/dotfiles/symulinks"

# Setup symbolic links
ln -hfs "$DIR/.agignore" ~/.agignore
ln -hfs "$DIR/.alacritty.yml" ~/.alacritty.yml
ln -hfs "$DIR/.aliases" ~/.aliases
ln -hfs "$DIR/.autoenv" ~/.autoenv
ln -hfs "$DIR/.bashrc" ~/.bashrc
ln -hfs "$DIR/.editorconfig" ~/.editorconfig
ln -hfs "$DIR/.eslintrc.js" ~/.eslintrc.js
ln -hfs "$DIR/.git-templates" ~/.git-templates
ln -hfs "$DIR/.gitconfig" ~/.gitconfig
ln -hfs "$DIR/.gitignore" ~/.gitignore
ln -hfs "$DIR/.lazygit_config.yml" "$HOME/Library/Application Support/lazygit/config.yml"
ln -hfs "$DIR/.rgignore" ~/.rgignore
ln -hfs "$DIR/.ssh" ~/.ssh
ln -hfs "$DIR/.tmux.conf" ~/.tmux.conf
ln -hfs "$DIR/.tmux.conf.local" ~/.tmux.conf.local
ln -hfs "$DIR/.tmuxinator.zsh" ~/.tmuxinator.zsh
ln -hfs "$DIR/.zshrc" ~/.zshrc
ln -hfs "$DIR/atuin" ~/.config/atuin
ln -hfs "$DIR/bpytop.conf" ~/.config/bpytop/bpytop.conf
ln -hfs "$DIR/init.lua" ~/.config/nvim/init.lua
ln -hfs "$DIR/lua" ~/.config/nvim/lua
