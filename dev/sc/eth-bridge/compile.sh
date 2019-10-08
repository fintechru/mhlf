#!/bin/bash +x

rm -rf build/
truffle build && truffle compile
solc --abi --bin --overwrite -o build contracts/*.sol
