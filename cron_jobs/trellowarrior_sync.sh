#!/bin/sh

# Cron job that will periodically sync the trello board with taskwarrior
# python 'trellowarrior' package

# Path to the `task` executable. Otherwise, it will through the error in logs that `task`(taskwarrior) is not found
PATH=/usr/local/bin:/usr/local/bin:$PATH
export PATH

# Path to python virtual environment where trellowarrior was installed and configured
~/Development/Envs/nvim/bin/trellowarrior --config ~/.trellowarrior.conf
