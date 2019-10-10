#!/bin/bash +x

# docker system prune --all

rm fab3/fab3
# rf -rf fabric-src
# rf -rf fabric-chaincode-evm
rm -rf dev/sc/eth/.idea
rm -rf dev/sc/eth/build
rm dev/sc/eth/contract_address
rm networks/fabric/channel-artifacts/channel.tx
rm networks/fabric/channel-artifacts/genesis.block
rm networks/fabric/channel-artifacts/Org1MSPanchors.tx
rm networks/fabric/channel-artifacts/Org2MSPanchors.tx
rm -rf networks/fabric/crypto-config/ordererOrganizations
rm -rf networks/fabric/crypto-config/peerOrganizations
