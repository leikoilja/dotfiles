#!/usr/bin/env bash
#
# Setting stuff up...
#

# Get symulinks directory
DIR="/Users/leikoilja/Development/Dev_settings/dotfiles/symulinks"

# Setup symbolic links
ln -hfs "$DIR/.agignore" ~/.agignore
ln -hfs "$DIR/.alacritty.yml" ~/.alacritty.yml
ln -hfs "$DIR/.aliases" ~/.aliases
ln -hfs "$DIR/.autoenv" ~/.autoenv
ln -hfs "$DIR/.bashrc" ~/.bashrc
ln -hfs "$DIR/.coc-settings.json" ~/.config/nvim/coc-settings.json
ln -hfs "$DIR/.editorconfig" ~/.editorconfig
ln -hfs "$DIR/.eslintrc.js" ~/.eslintrc.js
ln -hfs "$DIR/.gitconfig" ~/.gitconfig
ln -hfs "$DIR/.gitignore" ~/.gitignore
ln -hfs "$DIR/.lazygit_config.yml" ~/.lazygit_config.yml
ln -hfs "$DIR/.skhdrc" ~/.skhdrc
ln -hfs "$DIR/.ssh" ~/.ssh
ln -hfs "$DIR/.tmux.conf" ~/.tmux.conf
ln -hfs "$DIR/.tmux.conf.local" ~/.tmux.conf.local
ln -hfs "$DIR/.tmuxinator.yml" ~/.config/tmuxinator/.tmuxinator.yml
ln -hfs "$DIR/.tmuxinator.zsh" ~/.tmuxinator.zsh
ln -hfs "$DIR/.vifmrc" ~/.config/vifm/vifmrc
ln -hfs "$DIR/.vimrc" ~/.vimrc
ln -hfs "$DIR/.zshrc_mac" ~/.zshrc
ln -hfs "$DIR/init.lua" ~/.config/nvim/init.lua
ln -hfs "$DIR/lua" ~/.config/nvim/lua
ln -hfs "$DIR/yabairc" ~/.config/yabai/yabairc
