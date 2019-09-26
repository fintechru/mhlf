#!/bin/bash +x

docker system prune --all

rm fab3/fab3
# rf -rf fabric
# rf -rf fabric-chaincode-evm
rf -rf smart-contracts/fabric-bridge/.idea
rf -rf smart-contracts/fabric-bridge/build
rm smart-contracts/fabric-bridge/contract_address
rm network/channel-artifacts/channel.tx
rm network/channel-artifacts/genesis.block
rm network/channel-artifacts/Org1MSPanchors.tx
rm network/channel-artifacts/Org2MSPanchors.tx
rm network/crypto-config/ordererOrganizations
rm network/crypto-config/peerOrganizations
