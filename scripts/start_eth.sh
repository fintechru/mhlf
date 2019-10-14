#!/bin/bash

# START NETWORK
cd ../networks/eth
 nohup ./start.sh &

# DEPLOY CONTRACTS
cd ../../dev/sc/eth

./deploy_to_eth.sh  > deploy_log

# SAVE ARTIFACTS TO APP

cat deploy_log | grep "ETH_BRIDGE_SMART_CONTRACT" | sed -n -e 's/^.*ETH_BRIDGE_SMART_CONTRACT://p' | sed 's/\"//g' | sed 's/ //g' | tr -d '\r\n' > eth_bridge_address
cat deploy_log | grep "ETH_HTLC_SMART_CONTRACT" | sed -n -e 's/^.*ETH_HTLC_SMART_CONTRACT://p' | sed 's/\"//g' | sed 's/ //g' | tr -d '\r\n' > eth_htlc_address

ETH_BRIDGE_SMART_CONTRACT=$(cat eth_bridge_address | tr -d '\r\n')
ETH_HTLC_SMART_CONTRACT=$(cat eth_htlc_address | tr -d '\r\n')

sed -i "s/ETH_BRIDGE_SMART_CONTRACT=.*/ETH_BRIDGE_SMART_CONTRACT=${ETH_BRIDGE_SMART_CONTRACT}/g" ../../back/.env
sed -i "s/ETH_HTLC_SMART_CONTRACT=.*/ETH_HTLC_SMART_CONTRACT=${ETH_HTLC_SMART_CONTRACT}/g" ../../back/.env

# SEND TRANSACTION WITH EVENTS

curl -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0", "method":"eth_sendTransaction", "params":[{"from": "0x1498b1f46537d660dc40a908d64354763e18aa66", "to": "'${ETH_BRIDGE_SMART_CONTRACT}'", "gas": "0x76c0", "gasPrice": "0x9184e72a000", "data": "0x55241077000000000000000000000000000000000000000000000000000000000000002A"}],"id":1}' http://localhost:8545 >> tx_result

# TODO: get tx_hash from tx_result
TX_HASH=
TOPICS=

curl -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0", "method":"eth_getTransactionReceipt", "params":["'${TX_HASH}'"],"id":1}' http://localhost:8545
curl -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0", "method":"eth_getTransactionByHash", "params":["'${TX_HASH}'"],"id":1}' http://localhost:8545
curl -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_getLogs","params":[{"topics":["'${TOPICS}'"]}],"id":74}' http://localhost:8545
curl -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_call","params":[{"to":"'${ETH_BRIDGE_SMART_CONTRACT}'", "data": "'${SOMETHING}'"}],"id":1}' http://localhost:8545