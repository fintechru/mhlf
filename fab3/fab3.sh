#!/bin/bash

CURRENT_DIR=$PWD

export FAB3_CONFIG="${CURRENT_DIR}/evmcc-network.yaml" # Path to a compatible Fabric SDK Go config file
echo $FAB3_CONFIG
export FAB3_USER="User1" # User identity being used for the proxy (Matches the users names in the crypto-config directory specified in the config)
echo $FAB3_USER
export FAB3_ORG="Org2"  # Organization of the specified user
echo $FAB3_ORG
export FAB3_CHANNEL="common" # Channel to be used for the transactions
echo $FAB3_CHANNEL
export FAB3_CCID="evmcc" # ID of the EVM Chaincode deployed in your fabric network. If not provided default is evmcc.
echo $FAB3_CCID
export FAB3_PORT="5000" # Port the proxy will listen on. If not provided default is 5000.
echo $FAB3_PORT

cp $(go env GOPATH)/src/github.com/hyperledger/fabric-chaincode-evm/bin/fab3 .

./fab3 