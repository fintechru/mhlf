#!/bin/bash +x

# docker system prune --all

rm fab3/fab3
# rf -rf fabric
# rf -rf fabric-chaincode-evm
rm -rf dev/sc/evmcc-bridge/.idea
rm -rf dev/sc/evmcc-bridge/build
rm dev/sc/evmcc-bridge/contract_address
rm network/channel-artifacts/channel.tx
rm network/channel-artifacts/genesis.block
rm network/channel-artifacts/Org1MSPanchors.tx
rm network/channel-artifacts/Org2MSPanchors.tx
rm -rf network/crypto-config/ordererOrganizations
rm -rf network/crypto-config/peerOrganizations
