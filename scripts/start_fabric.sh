#!/bin/bash +x

CURRENT_DIR=$PWD

# START NETWORK
cd ../networks/fabric
./evmnet.sh down
./evmnet.sh up # -o etcdraft

cd $CURRENT_DIR

# DEPLOY CONTRACTS
cd ../dev/sc/eth

CONTRACT_BIN=$(cat build/Bridge.bin) # Deploy Bridge.sol
sed -i "s/CONTRACT_BIN=.*/CONTRACT_BIN=${CONTRACT_BIN}/g" deploy_to_fabric.sh
source deploy_to_fabric.sh | sed -n -e 's/^.*payload://p' | sed 's/\"//g' | sed 's/ //g' >fabric_contract_address

# TEST CONTRACTS
FABRIC_CONTRACT_ADDRESS=$(cat fabric_contract_address | tr -d '\r\n')
# Вызов метода getInfo(): 0x5a9b0b89
docker exec -it cli bash -c "peer chaincode invoke -n evmcc -C common -c '{\"Args\":[\"${FABRIC_CONTRACT_ADDRESS}\",\"5a9b0b89\"]}' -o orderer.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"
# Вызов метода setValue() и устновка значения 10
docker exec -it cli bash -c "peer chaincode invoke -n evmcc -C common -c '{\"Args\":[\"${FABRIC_CONTRACT_ADDRESS}\",\"55241077000000000000000000000000000000000000000000000000000000000000000a\"]}' -o orderer.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"

# SAVE ARTIFACTS TO APP
FABRIC_CONTRACT_ADDRESS=$(cat fabric_contract_address | tr -d '\r\n')
sed -i "s/FABRIC_CONTRACT_ADDRESS=.*/FABRIC_CONTRACT_ADDRESS=${FABRIC_CONTRACT_ADDRESS}/g" ../../back/.env


