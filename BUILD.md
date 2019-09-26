# Руководство по сборке

Разработка велась под ОС Ubuntu 18.

## Необходимые компоненты

- node 10.16: [`Инструкция`](https://github.com/nodesource/distributions/blob/master/README.md)
- npm 6.9.0: ``
- truffle: https://www.trufflesuite.com/docs/truffle/getting-started/installation 
- solc: [Инструкция](https://solidity.readthedocs.io/en/v0.4.21/installing-solidity.html#binary-packages)

## Собираем Fabric

1. Установка необходимых пакетов:
`https://hyperledger-fabric.readthedocs.io/en/release-1.4/prereqs.html`
2. Запускаем команду `make dist-clean all`
3. Необходимые нам файлы находятся в папке `.build\bin`

## Собираем Fab3

```bash
mkdir -p $(go env GOPATH)/src/github.com/hyperledger/
git clone "https://gerrit.hyperledger.org/r/fabric-chaincode-evm" $(go env GOPATH)/src/github.com/hyperledger/fabric-chaincode-evm
cd $(go env GOPATH)/src/github.com/hyperledger/fabric-chaincode-evm
make fab3
```

В папке `$(go env GOPATH)/src/github.com/hyperledger/fabric-chaincode-evm/bin` будет находится исполняемый `fab3`

## EVMCC

Идет в поставке с Fab3

## Solidity смарт-контракты

1. В папке `smart-contracts/fabric-bridge` запустить `compile.sh`
2. В папке `build` будут необходимые нам артефакты

# Содействие

Если вы встретили проблему, то смело создавайте [New Issue](https://github.com/fintechru/mhlf/issues/new) 

Если вы можете внести свой вклад в кодовую базу, улучшить определенный участок кода, то смело создавайте [Pull Request](https://github.com/fintechru/mhlf/pulls)
