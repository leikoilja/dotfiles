#!/usr/bin/env bash
#
# Setting stuff up...
#

# Get symulinks directory
HOME_DIR="/Users/leikoilja"
SYNOLOGY_HOME_DIR="$HOME_DIR/Library/CloudStorage/SynologyDrive-home/"
DEV_DIR="$HOME_DIR/Development"
DOTFILES_DIR="$DEV_DIR/dotfiles"
SYMLINKS_DIR="$DOTFILES_DIR/symlinks"
SECRETS_DIR="$DOTFILES_DIR/.secrets"

# hide all other default directories from Finder
chflags hidden ~/{Movies,Pictures,Public,Sites}

# create on-demand directories
ln -s $SYNOLOGY_HOME_DIR/Backups ~/Backups
ln -s $SYNOLOGY_HOME_DIR/Music ~/Music-OD
ln -s $SYNOLOGY_HOME_DIR/Photos ~/Photos-OD
ln -s /Users/leikoilja/Library/CloudStorage/SynologyDrive-home/Videos ~/Videos-OD

# Setup symbolic links
ln -hfs "$HOME_DIR/Library/CloudStorage/SynologyDrive-home/Development" ~/Development

ln -hfs "$SYMLINKS_DIR/.agignore" ~/.agignore
ln -hfs "$SYMLINKS_DIR/.alacritty.yml" ~/.alacritty.yml
ln -hfs "$SYMLINKS_DIR/.aliases" ~/.aliases
ln -hfs "$SYMLINKS_DIR/.aerospace.toml" ~/.aerospace.toml
ln -hfs "$SYMLINKS_DIR/.bashrc" ~/.bashrc
ln -hfs "$SYMLINKS_DIR/.editorconfig" ~/.editorconfig
ln -hfs "$SYMLINKS_DIR/.git-templates" ~/.git-templates
ln -hfs "$SYMLINKS_DIR/.gitconfig" ~/.gitconfig
ln -hfs "$SYMLINKS_DIR/.gitignore" ~/.gitignore
ln -hfs "$SYMLINKS_DIR/.lazygit_config.yml" "$HOME_DIR/Library/Application Support/lazygit/config.yml"
ln -hfs "$SYMLINKS_DIR/.rgignore" ~/.rgignore
ln -hfs "$SYMLINKS_DIR/.tmux.conf" ~/.tmux.conf
ln -hfs "$SYMLINKS_DIR/.tmux.conf.local" ~/.tmux.conf.local
ln -hfs "$SYMLINKS_DIR/.tmuxinator.zsh" ~/.tmuxinator.zsh
ln -hfs "$SYMLINKS_DIR/tmuxinator" ~/.config/tmuxinator
ln -hfs "$SYMLINKS_DIR/.zshrc" ~/.zshrc
ln -hfs "$SYMLINKS_DIR/atuin" ~/.config/atuin
ln -hfs "$SYMLINKS_DIR/karabiner" ~/.config/karabiner
ln -hfs "$SYMLINKS_DIR/bpytop.conf" ~/.config/bpytop/bpytop.conf
ln -hfs "$SYMLINKS_DIR/nvim" ~/.config/nvim
ln -hfs "$SYMLINKS_DIR/direnv" ~/.config/direnv

ln -hfs "$SECRETS_DIR/" ~/.secrets
ln -hfs "$SECRETS_DIR/.ssh" ~/.ssh
# ln -hfs "$SYMLINKS_DIR/ohmyposh/base.json" ~/.config/ohmyposh.json
ln -hfs "$SYMLINKS_DIR/starship.toml" ~/.config/starship.toml