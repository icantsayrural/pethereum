#!/bin/bash

if (( $# != 1 )); then
  echo "Usage: ./server.sh <data directory>"
  exit 1
fi

ip="127.0.0.1"
data_dir=$1

cd $data_dir
port=`cat port.txt`
bootnode=`cat bootnode.txt`
echo $bootnode
cd ..

geth --nodiscover --networkid 123 --port=$port --datadir=$data_dir --bootnodes=$bootnode console
