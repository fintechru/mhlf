#!/bin/bash +x

# docker system prune --all

rm fab3/fab3
# rf -rf fabric-src
# rf -rf fabric-chaincode-evm
rm -rf dev/sc/evmcc-bridge/.idea
rm -rf dev/sc/evmcc-bridge/build
rm dev/sc/evmcc-bridge/contract_address
rm network/fabric/channel-artifacts/channel.tx
rm network/fabric/channel-artifacts/genesis.block
rm network/fabric/channel-artifacts/Org1MSPanchors.tx
rm network/fabric/channel-artifacts/Org2MSPanchors.tx
rm -rf network/fabric/crypto-config/ordererOrganizations
rm -rf network/fabric/crypto-config/peerOrganizations
