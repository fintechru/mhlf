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
