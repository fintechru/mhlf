#!/bin/bash

CONTRACT_BIN=
ORDERER=orderer.example.com:7050
PATH_TO_CAFILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

docker exec -it cli bash -c "peer chaincode invoke -n evmcc -C common -c '{\"Args\":[\"0000000000000000000000000000000000000000\", \"'${CONTRACT_BIN}'\"]}' -o $ORDERER --tls --cafile $PATH_TO_CAFILE"
FABRIC_CONTRACT_ADDRESS=02fc2cc67ea88093a17d92c2b1da35a99b27d15b