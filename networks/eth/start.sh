#!/usr/bin/env bash

./geth --rpc \
  --rpcport "8545" \
  --rpccorsdomain "*" \
  --verbosity 3 \
  --datadir ./node/data \
  --networkid 2019 \
  --mine \
  --minerthreads 1 \
  --etherbase=0x1498b1f46537d660dc40a908d64354763e18aa66 \
  --nodiscover \
  --rpcapi "admin,db,eth,debug,miner,shh,txpool,net,web3,personal" \
  --allow-insecure-unlock \
  --unlock 0x1498b1f46537d660dc40a908d64354763e18aa66 \
  --password ./node/pass-1
