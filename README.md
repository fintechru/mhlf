# Masterchain-Hyperledger

[WIP]

Исследовательский проект по запуску виртуальной машины Ethereum в среде Hyperledger Fabric, а также размещению и взаимодействию с размещенным в нём смарт-контрактом, который написан на языке Solidity версии 0.5.x. 

Цель: определение границ прототипа Hyperledger Fabric использованием Burrow EVM и Fab3, а также проверка возможности построения "моста" между Мастерчейн и Hyperledger Fabric.

### Основные понятия

__Hyperledger Fabric v1.4__ - фреймворк на котором разрабатывается исследовательский распределенный реестр, который позволяет размещать "Смарт-контракты" (Chaincode - в терминалогии Hyperledger Fabric) [Ссылка](https://www.hyperledger.org/projects/fabric)

__Hyperleder Burrow__ - проект по переносу EVM в permissioned среду. [Ссылка](https://www.hyperledger.org/projects/hyperledger-burrow)

__EVMCC__ - chaincode, который позволяет запускать виртуальную машину Ethereum в реестре основанном на Hyperledger Fabric. [Ссылка](https://github.com/hyperledger/fabric-chaincode-evm/tree/master/evmcc)

__Fab3__ - сервис, который позволяет проксировать запросы в Burrow EVM. Реализует ограниченный набор Ethereum RPC-API.  [Ссылка](https://github.com/hyperledger/fabric-chaincode-evm/blob/master/Fab3_Instructions.md)

__Solidity v0.5.x__ - язык написания смарт-контрактов. [Ссылка](https://solidity.readthedocs.io/en/v0.5.11/)

__web3js__ - бибилотека для проксирования запросов из JavaScript в Ethereum JSON-RPC. [Ссылка](https://web3js.readthedocs.io/en/v1.2.1/)

### Этапы
- [x] Запуск сети из 3-х узлов
- [x] Установка и иницализация EVM chaincode в канале
- [x] Деплой смарт-контракта в EVM
- [x] Взаимодейтсвие со смарт-контрактом через Fabric API (вызов setValue, getValue)
- [ ] Отлов событий происходящих в смарт-контракте
- [ ] Взаимодействие со смарт-контрактом посредством web3js
- [ ] HTLC контракт
- [ ] Frontend для мониторинга узла

# Сборка необходимых компонентов

Для сборки проекта потребуется предустановить ряд инструментов. Инструкцию по подготовке окружения вы сможете найти в файлу [BUILD.md](BUILD.md)

# Запуск

Скрипт для запуска необходимых docker контейнеров для 3-х узлов, а также размещению EVMCC, компиляцию и деплоя смарт-контрактов, запустите скрипт: `start.sh`

Детальное руководство вы можете найти в файле [MANUAL.md](MANUAL.md)

# Содействие

Если вы встретили проблему, то смело создавайте [New Issue](https://github.com/fintechru/mhlf/issues/new) 

Если вы можете внести свой вклад в кодовую базу, улучшить определенный участок кода, то смело создавайте [Pull Request](https://github.com/fintechru/mhlf/pulls)
