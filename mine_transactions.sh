#!/bin/bash

if (( $# != 2 )); then
  echo "Usage: ./mine_transactions.sh <data directory> <interval>"
  exit 1
fi

data_dir=$1
interval=$2

while [ 1 ]
do
  geth --exec 'loadScript("mine.js")' attach $data_dir/geth.ipc

  sleep $interval
done
