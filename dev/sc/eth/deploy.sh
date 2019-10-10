#!/bin/bash


# TODO: make select from eth and burrow
truffle migrate --network development

CONTRACT_BIN=
ORDERER=orderer.example.com:7050
PATH_TO_CAFILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

docker exec -it cli bash -c "peer chaincode invoke -n evmcc -C common -c '{\"Args\":[\"0000000000000000000000000000000000000000\", \"'${CONTRACT_BIN}'\"]}' -o $ORDERER --tls --cafile $PATH_TO_CAFILE"