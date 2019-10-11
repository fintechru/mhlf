#!/bin/bash

# TODO: сделать меню и навигацию по развертыванию

CURRENT_DIR=$PWD

cd scripts
./start_fabric.sh
./start_eth.sh
./start_demon.sh