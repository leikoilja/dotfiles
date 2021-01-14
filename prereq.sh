#!/usr/bin/env bash
#
# dotfiles prerequisites
#

## Calling dir
calling_dir=$PWD

# Get dotfiles directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# pomo - local version of pomo (depends on libnotify...)

echo "Which OS are you on?"
select os in Ubuntu Other
do
    case $os in
        Ubuntu )
            sudo apt-get install -y exuberant-ctags
	    sudo apt-get install fonts-powerline
            break;;
        Other )
            echo "You probably want to unlink the default phantomjs in ~/.bin..."
            break;;
    esac
done

# Go back to dir we came from
cd $calling_dir
