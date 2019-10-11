#!/bin/bash

./compile.sh
# TODO: check build artifacts
truffle migrate --network development
