#!/bin/bash

if (( $# != 2 )); then
  echo "Usage: ./deploy_contract.sh <data directory> <interval>"
  exit 1
fi

data_dir=$1
interval=$2
ip="127.0.0.1"

# deploy contract
# ether shortage is OK, just move on
while [ 1 ]
do
  echo "deploying contract ..."
  geth --exec 'loadScript("contract.js")' attach $data_dir/geth.ipc
  echo "done"

  sleep $interval
done
