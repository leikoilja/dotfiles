#!/usr/bin/env bash
#
# Setting stuff up...
#

# Get symulinks directory
HOME="/Users/leikoilja"
DOTFILES="$HOME/Development/dotfiles"
SYMLINKS="$DOTFILES/symlinks"
SECRETS="$DOTFILES/.secrets"

# Setup symbolic links
ln -hfs "$SYMLINKS/.agignore" ~/.agignore
ln -hfs "$SYMLINKS/.alacritty.yml" ~/.alacritty.yml
ln -hfs "$SYMLINKS/.aliases" ~/.aliases
ln -hfs "$SYMLINKS/.autoenv" ~/.autoenv
ln -hfs "$SYMLINKS/.aerospace.toml" ~/.aerospace.toml
ln -hfs "$SYMLINKS/.bashrc" ~/.bashrc
ln -hfs "$SYMLINKS/.editorconfig" ~/.editorconfig
ln -hfs "$SYMLINKS/.git-templates" ~/.git-templates
ln -hfs "$SYMLINKS/.gitconfig" ~/.gitconfig
ln -hfs "$SYMLINKS/.gitignore" ~/.gitignore
ln -hfs "$SYMLINKS/.lazygit_config.yml" "$HOME/Library/Application Support/lazygit/config.yml"
ln -hfs "$SYMLINKS/.rgignore" ~/.rgignore
ln -hfs "$SYMLINKS/.tmux.conf" ~/.tmux.conf
ln -hfs "$SYMLINKS/.tmux.conf.local" ~/.tmux.conf.local
ln -hfs "$SYMLINKS/.tmuxinator.zsh" ~/.tmuxinator.zsh
ln -hfs "$SYMLINKS/tmuxinator" ~/.config/tmuxinator
ln -hfs "$SYMLINKS/.zshrc" ~/.zshrc
ln -hfs "$SYMLINKS/atuin" ~/.config/atuin
ln -hfs "$SYMLINKS/karabiner" ~/.config/karabiner
ln -hfs "$SYMLINKS/bpytop.conf" ~/.config/bpytop/bpytop.conf
ln -hfs "$SYMLINKS/nvim" ~/.config/nvim

ln -hfs "$SECRETS/" ~/.secrets
ln -hfs "$SECRETS/.ssh" ~/.ssh
ln -hfs "$SYMLINKS/ohmyposh/base.json" ~/.config/ohmyposh.json