#!/bin/sh

PATH=/usr/local/bin:$PATH
export PATH

EXEC_PATH="/Users/leikoilja/Development/freedom-api"
cd $EXEC_PATH
duration=$(($1*60))
python3 main.py -t KV1mHv4iG5hes6mDCQfXPQpzzyHyua -d "$duration" --device-uids 1630434 1630421 --filter-uids 2204898 2204789
