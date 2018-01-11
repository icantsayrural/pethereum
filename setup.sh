#!/bin/bash

if (( $# != 1 )); then
  echo "Usage: ./setup.sh <number of nodes>"
  exit 1
fi

ip="127.0.0.1"

# clean up
rm -rf data*

# create genesis block
for (( i=1; i<=$1; i++))
do
  mkdir data$i
  cd data$i

  geth --datadir=. init ../genesis.json
  bootnode --genkey=boot.key
  bootnode --nodekey=boot.key -writeaddress
  geth --datadir=. js ../dummy.js # start server momentarily to generate nodekey

  nodekey=`cat geth/nodekey`
  enode=`bootnode -nodekeyhex $nodekey -writeaddress`

  port=$((30303 + i))
  echo $port >> port.txt

  bootnode="enode://"$enode"@["$ip"]:$port?discport=0"
  echo $bootnode >> bootnode.txt

  cd ..
done

# connect all peers in network
for cur_dir in data*
do
  echo "[" >> $cur_dir/geth/static-nodes.json

  for dir in data*
  do
    if [ $cur_dir != $dir ]
    then
      bootnode=`cat $dir/bootnode.txt`

      echo -n '"' >> $cur_dir/geth/static-nodes.json
      echo -n $bootnode >> $cur_dir/geth/static-nodes.json
      echo '",' >> $cur_dir/geth/static-nodes.json
    fi
  done

  truncate -s-2 $cur_dir/geth/static-nodes.json # remove the newline and comma for formatting

  echo >> $cur_dir/geth/static-nodes.json
  echo "]" >> $cur_dir/geth/static-nodes.json
done
