defmodule BridgeApp.Utils.Ethereum do
  @moduledoc false

  alias Ethereumex.HttpClient

  # Деплой смарт-контракта
  # TODO: указание адреса кто деплоит - `author`
  # TODO: указание `gas`, `gasPrice`,
  # TODO: указание `value`
  def deploy_smart_contract(contract_name) do
    {:ok, author} = Ethereumex.HttpClient.eth_coinbase()
    {:ok, contract_bin} = File.read("contracts/" <> contract_name <> ".bin")

    tx = %{
      "from" => author,
      "gas" => "0x47E7C4", # gas, # "0x76c0"
      "gasPrice" => "0x47E7C4", # "0x9184e72a000"
      #      "value" => value, # "0x9184e72a",
      "data" => "0x" <> contract_bin
    }

    # TODO: подождать когда замайнится и получить рецепт с помощью get_tx_receipt
    {:ok, tx_hash} = Ethereumex.HttpClient.eth_send_transaction(tx)

  end

  # Вызов метода смарт-контракта
  # TODO: указание адреса который вызывает метод - `author`
  # TODO: описание параметров
  # TODO: указание `gas`, `gasPrice`,
  # TODO: указание `value`
  def call_write_method(contract_address, contract_method_sign, method_data) do
    {:ok, author} = Ethereumex.HttpClient.eth_coinbase()

    # Получение data: 4 байта сигнатуры метода + параметры в формате bytes32
    data = ABI.encode(contract_method_sign, [method_data])
           |> Base.encode16()
           |> String.downcase()
           |> (&("0x" <> &1)).()

    tx = %{
      "from" => author,
      "to" => contract_address,
      #      "gas" => "0x76c0",
      #      "gasPrice" => "0x9184e72a000",
      #      "value" => "0x9184e72a",
      "data" => data
    }

    # TODO: подождать когда транзакция замайнится и получить рецепт с помощью get_tx_receipt
    {:ok, tx_hash} = Ethereumex.HttpClient.eth_send_transaction(tx)
  end

  # Вызов метода смарт-контракта, который не изменяет состояние
  # TODO: описание параметров
  # TODO: указание адреса который вызывает метод - `author`
  def call_read_method(contract_address, contract_method_sign, method_data \\ []) do
    {:ok, author} = Ethereumex.HttpClient.eth_coinbase()

    # Получение data: 4 байта сигнатуры метода + параметры в формате bytes32
    data = ABI.encode(contract_method_sign, [method_data])
           |> Base.encode16()
           |> String.downcase()
           |> (&("0x" <> &1)).()

    tx = %{
      "from" => author,
      "to" => contract_address,
      "data" => data
    }

    # TODO: подождать ответа, распарсить ответ
    {:ok, result} = Ethereumex.HttpClient.eth_call(tx)
  end

  # Получение логов событий
  # TODO: установка топика - что такое топик? - хэш сигнатуры события
  # TODO: распарсить логи
  def get_logs(contract_address, topics) do
    # topics = web3.utils.sha3('Transfer(address,address,uint256') = 0xd99659a21de82e379975ce8df556f939a4ccb95e92144f38bb0dd35730ffcdd5
    filter = %{address: contract_address, topics: [topics]}

    Ethereumex.HttpClient.eth_get_logs(filter)
  end

  # TODO: fromBlock -
  # TODO: toBlock -
  # TODO: topics -
  def get_new_filter(contract_address, topics) do

    filter = %{
      # fromBlock: "0x1",
      # toBlock: "0x2",
      address: contract_address,
      topics: [
        topics,
        nil,
        []
      ]
    }

    HttpClient.eth_new_filter(filter)
  end

  # Получение рецепта по хэшу транзакции
  def get_tx_receipt(tx_hash) do
    Ethereumex.HttpClient.eth_get_transaction_receipt(tx_hash)
  end

  # Получить 4byte сигнатры метода, аргемент должен быть в лвойных кавычках
  def get_four_bytes(method_sign) do
    :keccakf1600.hash(:sha3_256, method_sign)
    |> Base.encode16()
    |> String.downcase()
    |> (&("0x" <> &1)).()
    |> (&(String.slice(&1, 0..9))).()
  end

  def get_code(contract_address) do
    Ethereumex.HttpClient.eth_get_code(contract_address)
  end

end
