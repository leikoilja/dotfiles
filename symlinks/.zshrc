# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:/opt/homebrew/bin/
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
# export PATH="/Users/leikoilja/Library/Python/2.7/bin:$PATH"
# export PATH=$PATH:~/.local/kitty.app/bin

# Path to your oh-my-zsh installation.
export ZSH="/Users/leikoilja/.oh-my-zsh"

# Locale
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
TOUCHBAR_GIT_ENABLED=true
plugins=(fabric fzf git pip python vagrant zsh-autosuggestions web-search)

source $ZSH/oh-my-zsh.sh

# My Customisations...
# ~~~~~~~~~~~~~~~~~~~~

### Environmental variables
export WORKON_HOME=~/Development/Envs


### Tools

# autoenv (https://github.com/kennethreitz/autoenv).
[[ -s "$HOME/.autoenv/activate.sh" ]] && source "$HOME/.autoenv/activate.sh"

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# alias python='python3'

# Load tmuxinator completion
source ~/.tmuxinator.zsh

# FZF search
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPS="--extended"

# Preferred editor
# https://github.com/kdheepak/lazygit.nvim
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    alias nvim=nvr -cc split --remote-wait +'set bufhidden=wipe'
    export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
    export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
  export EDITOR='/opt/homebrew/bin/nvim'
  export VISUAL='/opt/homebrew/bin/nvim'
fi

function jmm()
{
  if [ -z "$1" ]
  then
    echo "You must specify the app to make migrations for"
    echo "Example: jmm metis"
  else
    cdjbl
    echo -e "Makemigrations for $1"
    docker-compose exec web python manage.py makemigrations "$1"
    echo "Run migration for $1?"
    select yn in "Yes" "No"; do
      case $yn in
        Yes ) docker-compose exec web python manage.py migrate "$1"; break;;
        No ) echo "Quiting";;
      esac
    done
  fi
}

function jdm()
{
  if [ -z "$1" ]
  then
    echo "You must specify the app to make datamigration for"
    echo "Example: jdm metis data_migration_name"
  else
    cdjbl
    echo -e "Creating datamigration for $1 with name $2"
    docker-compose exec web python manage.py datamigration "$1" "$2"
  fi
}

function gmm()
{
  if [ -z "$1" ]
  then
    echo "You must specify the app to makemigrations for"
    echo "Example: gmm gl"
  else
    gingernest
    echo -e "Makemigrations for $1"
    docker-compose exec web poetry run python manage.py makemigrations "$1"
    echo "Run migration for $1?"
    select yn in "Yes" "No"; do
      case $yn in
        Yes ) docker-compose exec web poetry run python manage.py migrate "$1"; break;;
        No ) echo "Quiting";;
      esac
    done
  fi
}

# Powerline
# powerline-daemon -q
# POWERLINE_BASH_CONTINUATION=1
# POWERLINE_BASH_SELECT=1
# source /Library/Python/3.8/site-packages/powerline/bindings/bash/powerline.sh

# Sintax highlighter
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/usr/local/opt/openjdk/include"
JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
fpath+=${ZDOTDIR:-~}/.zsh_functions
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

# Virtual env
if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

# export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/Users/leikoilja/.local/bin:$PATH"

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

export LIBMEMCACHED="/opt/homebrew/Cellar/libmemcached/1.0.18_2"

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

# atuin
eval "$(atuin init zsh)"

# source shell_secrets file
source ~/.secrets/shell_secrets

source ~/.zshenv
