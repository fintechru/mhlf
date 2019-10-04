1. Узнаем сигнатуру события
`event ChangeValue(address currentContract, uint256 value);`
2. Получаем хэш сигнатуры события
`keccak('Transfer(address,address,uint256)')`
3. Полученный результат будет `topics: [<value>]`
4. Вызвать метод RPC (https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getlogs) с фильтрами
`curl -X POST --data '{"jsonrpc":"2.0","method":"eth_getLogs","params":[{"topics":["0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b"]}],"id":74}'`

## Как отслеживать события?

1. Создаем фильтр eth_newFilter + eth_getFilterLogs

## Получить все события контракта 
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_getLogs","params":[{"address":["YOUR_CONTRACT_ADDRESS"]}],"id":74}'

curl -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_getLogs","params":[{"toBlock":"latest"}],"id":74}' http://localhost:8545 