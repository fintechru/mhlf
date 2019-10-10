# Руководство

Проверка версии: `./geth version`

## Инициализация узла

1. Создать аккаунт: `./geth --datadir node/data account new`
2. Ввести пароль, запомнить пароль
3. Получить адрес
4. Сгенерировать генезис: `./geth --datadir node/data init node/genesis.json`
5. Запустить узел: `./start.sh`
