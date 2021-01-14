#!/usr/bin/env bash
#
# Setting stuff up...
#

## Calling dir
calling_dir=$PWD

# Get dotfiles directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Clone Vundle for vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Setup symbolic links
# Should check if they already exist and in that case unlink or delete
ln -f -s "$DIR/bashrc" ~/.bashrc
ln -f -s "$DIR/bin" ~/.bin
ln -f -s "$DIR/aliases" ~/.aliases
ln -f -s "$DIR/git" ~/.git
ln -f -s "$DIR/gitconfig" ~/.gitconfig
ln -f -s "$DIR/gitignore" ~/.gitignore
sudo rm -rf ~/.pip && ln -f -s "$DIR/pip" ~/.pip
ln -f -s "$DIR/tmux.conf" ~/.tmux.conf
ln -f -s "$DIR/tmux.conf.local" ~/.tmux.conf.local
ln -f -s "$DIR/tmux" ~/.tmux
ln -f -s "$DIR/vim" ~/.vim
ln -f -s "$DIR/vimrc" ~/.vimrc
ln -f -s "$DIR/zshrc" ~/.zshrc

# Setup all Vim plugins - can also be used for bundle updates

# Go back to dir we came from
cd $calling_dir
