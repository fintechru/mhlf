#!/bin/bash

CURRENT_DIR=$PWD

cd network/fabric
./evmnet.sh down
# ./evmnet.sh up -o etcdraft
./evmnet.sh up

cd "$CURRENT_DIR"

docker exec -it cli env

cd dev/sc/evmcc-bridge

CONTRACT_BIN=`cat build/FabricBridge.bin`

# удалить артефакты из deploy.sh 
sed -i "s/CONTRACT_BIN=.*/CONTRACT_BIN=${CONTRACT_BIN}/g" deploy.sh

source deploy.sh | sed -n -e 's/^.*payload://p' | sed 's/\"//g' | sed 's/ //g' > contract_address

sleep 1

SMART_CONTRACT_ADDRESS=`cat contract_address | tr -d '\r\n'`

# Тестирование смарт-контракта FabricBridge, вызов метода getInfo(): 0x5a9b0b89
docker exec -it cli bash -c "peer chaincode invoke -n evmcc -C common -c '{\"Args\":[\"${SMART_CONTRACT_ADDRESS}\",\"5a9b0b89\"]}' -o orderer.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"

# Тестирование смарт-контракта FabricBridge, вызов метода setValue() и устновка значения 10
docker exec -it cli bash -c "peer chaincode invoke -n evmcc -C common -c '{\"Args\":[\"${SMART_CONTRACT_ADDRESS}\",\"55241077000000000000000000000000000000000000000000000000000000000000000a\"]}' -o orderer.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"
