#!/bin/bash

# send transaction by RPC

PARAMS=

curl -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0", "method":"eth_sendTransaction", "params":[{"from": "0x1498b1f46537d660dc40a908d64354763e18aa66", "to": "0xf0EA0219d287cE38401855903613471CF0F31cb7", "gas": "0x76c0", "gasPrice": "0x9184e72a000", "data": "0x55241077000000000000000000000000000000000000000000000000000000000000000a"}],"id":1}' http://localhost:8545


curl -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0", "method":"eth_getTransactionReceipt", "params":["0x4c7a3c2574ef6d4e36b31e50fd6779b4ed5df9c75514497c19fe220d0ff5e7ca"],"id":1}' http://localhost:8545


curl -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0", "method":"eth_getTransactionByHash", "params":["0xaeccb8b9d1f53ab0ff5cb0de6a4fed20dc53492d6d049c7af75559b7ceeaf357"],"id":1}' http://localhost:8545

# call transaction getInfo()
curl -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0", "method":"eth_call", "params":[{"to": "0xf0EA0219d287cE38401855903613471CF0F31cb7", "data": "0x5a9b0b89"}, "earliest"],"id":1}' http://localhost:8545