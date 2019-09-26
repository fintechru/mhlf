#!/bin/bash

rm -rf build/
truffle compile
solc --abi --bin --overwrite -o build contracts/*.sol
