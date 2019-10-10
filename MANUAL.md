# Руководство по запуску

### Запуск сети Fabric c размещением EVMCC

1. В папке `network` запустить скрипт `evmnet.sh`
2. После освобождения терминала нужно убедиться, что Fabric сеть запущена: `docker exec -it cli env`

### Деплой смарт-контракта в EVMCC

    NOTE: скрипт `start.sh` сделает всё за вас, здесь описание того, что происходит в скрипте

1. Скомпилировать проект `./compile.sh`
2. Отредактировать файл `deploy.sh`: вставить BIN скомпилировано контракта.
3. Установть EVMCC на cli узле: `peer chaincode install -n evmcc -l golang -v 0 -p github.com/hyperledger/fabric-chaincode-evm/evmcc`
4. Инициализировать EVMCC на cli узле: 
```bash
peer chaincode instantiate -n evmcc -v 0 -C common -c '{"Args":[]}' -o orderer.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
```
5. Задеплоить контракт вызвав `deploy.sh`, на выходе получим адрес смарт-контракта. Например: `38453baa6053ffa18152dbcd9d0c89780b0a7a0e`
6. Тестируем смарт-контракт, вызываем открытый метод `getInfo`:
```bash
peer chaincode invoke -n evmcc -C common -c '{"Args":["<smart-contract-address>","<4byte>"]}' -o orderer.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
```
7. Сеть вернет результат: `Chaincode invoke successful. result: status:200`

## Взаимодействие с контрактом HTLC (ручной режим)

1. Запускаем скрипт для работы с Fab3: `fab3/fab3.sh`
2. Он установит переменные среды и откроет на локальном хосте порт 5000 для приёма запросов и проксированию их в EVMCC
3. Устанавливаем nodejs пакет web3 `npm install web3@0.20.2`
4. В узле `node` инициализируем пакет Web3

```
    > Web3 = require('web3')
    > web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:5000'))
    > web3.eth.accounts
    > web3.eth.defaultAccount = web3.eth.accounts[0]
```

5. В node задаем ABI и BIN смарт контракта, деплоим (если нужно) и получаем экземпляр контракта

```
  > htlcABI = [{<ABI>}]

  > htlcBytecode = '<BIN_BODY>'

  > HTLC = web3.eth.contract(htlcABI)

  > deployedContract = HTLC.new([], {data: htlcBytecode})
  > htlc = HTLC.at(web3.eth.getTransactionReceipt(deployedContract.transactionHash).contractAddress)
```

6. Вызываем метод нашего контракта

```
    > htlc.stringToBytes32("42") # получение строки ввиде bytes32 для 
    > htlc.createHashLock(secret) # генерация секрета
    > htlc.newContract(0x1498b1f46537d660dc40a908d64354763e18aa66, 0xcc17809256f3e18f88686f63c70bda95f6eb2ddc38498f5e260197960254155a, 1570619908).send({from: '0x43f34ed8d259448b76ccaebe286e33183ade92e5', value: '10000'}) # размещение нового LockContract
    > htlc.withdraw(contractId, secret) # Вывод средств
```

7. Отлавливаем событие

```bash
curl http://127.0.0.1:5000 -X POST -H "Content-Type:application/json" -d '{
  "jsonrpc":"2.0",
  "method": "eth_getTransactionReceipt",
  "id":1,
  "params":["<tx-hash>"]
}'
```

8. Логгирование
```bash
curl http://127.0.0.1:5000 -X POST -H "Content-Type:application/json" -d '{
  "jsonrpc":"2.0",
  "method": "eth_getLogs",
  "id":1,
  "params":[
    {"fromBlock":"earliest"}]
}'
```

1. Проверяем Fab3

curl http://127.0.0.1:5000 -X POST -H "Content-Type:application/json" -d '{"jsonrpc":"2.0","method": "eth_blockNumber","id":1,"params":[]}'

## Взаимодействие с контрактом МОСТ (ручной режим)

1. Запускаем скрипт для работы с Fab3: `fab3/fab3.sh`
2. Он установит переменные среды и откроет на локальном хосте порт 5000 для приёма запросов и проксированию их в EVMCC
3. Устанавливаем nodejs пакет web3 `npm install web3@0.20.2`
4. В узле `node` инициализируем пакет Web3

```
    > Web3 = require('web3')
    > web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:5000'))
    > web3.eth.accounts
    > web3.eth.defaultAccount = web3.eth.accounts[0]
```

5. В node задаем ABI и BIN смарт контракта, деплоим (если нужно) и получаем экземпляр контракта

```
  > fabricBridgeABI = [{<ABI>}]

  > fabricBridgeBytecode = '<BIN_BODY>'

  > FabricBridge = web3.eth.contract(fabricBridgeABI)

  > deployedContract = FabricBridge.new([], {data: fabricBridgeBytecode})
  > fabricBridge = FabricBridge.at(web3.eth.getTransactionReceipt(deployedContract.transactionHash).contractAddress)
```

6. Вызываем метод нашего контракта

```
    > fabricBridge.getInfo()
    > fabricBridge.setValue(10) # Получаем хэш транзакции tx_hash
    > fabricBridge.getValue().toNumber()
```

7. Отлавливаем событие

```bash
curl http://127.0.0.1:5000 -X POST -H "Content-Type:application/json" -d '{
  "jsonrpc":"2.0",
  "method": "eth_getTransactionReceipt",
  "id":1,
  "params":["<tx-hash>"]
}'
```

8. Логгирование
```bash
curl http://127.0.0.1:5000 -X POST -H "Content-Type:application/json" -d '{
  "jsonrpc":"2.0",
  "method": "eth_getLogs",
  "id":1,
  "params":[
    {"fromBlock":"earliest"}]
}'
```

1. Проверяем Fab3

curl http://127.0.0.1:5000 -X POST -H "Content-Type:application/json" -d '{"jsonrpc":"2.0","method": "eth_blockNumber","id":1,"params":[]}'