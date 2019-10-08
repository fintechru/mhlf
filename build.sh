#!/bin/bash +x

git submodule init
git submodule update

CURRENT_DIR=$PWD
FABRIC_BIN=fabric-src/.build/bin
FABRIC_EVMCC=$(go env GOPATH)/src/github.com/hyperledger/fabric-chaincode-evm/bin

cd fabric-src
if [ ! -d "$FABRIC_BIN" ]; then
make dist-clean native
fi

cd "$CURRENT_DIR"

if [ ! -d "$FABRIC_EVMCC" ]; then
mkdir -p $(go env GOPATH)/src/github.com/hyperledger/
git clone "https://gerrit.hyperledger.org/r/fabric-chaincode-evm" $(go env GOPATH)/src/github.com/hyperledger/fabric-chaincode-evm
cd $(go env GOPATH)/src/github.com/hyperledger/fabric-chaincode-evm
make fab3
fi

cd "$CURRENT_DIR"

cd dev/sc/evmcc-bridge
rm -rf build/
./compile.sh

cd "$CURRENT_DIR"
