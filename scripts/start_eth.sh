#!/bin/bash

# START NETWORK
cd ../networks/eth
./start.sh

# DEPLOY CONTRACTS
cd ../../dev/sc/eth

# TODO:
source deploy_to_eth.sh | sed -n -e 's/^.*payload://p' | sed 's/\"//g' | sed 's/ //g' >eth_contract_address

# SAVE ARTIFACTS TO APP
ETH_CONTRACT_ADDRESS=$(cat fabric_contract_address | tr -d '\r\n')
sed -i "s/ETH_CONTRACT_ADDRESS=.*/ETH_CONTRACT_ADDRESS=${ETH_CONTRACT_ADDRESS}/g" ../../back/.env
