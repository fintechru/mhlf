defmodule BridgeApp.Bridge do
  @moduledoc false

  alias Ethereumex.HttpClient

  # Works! Деплой смарт контракта
  def deploy_eth_contract(contract_name) do

    {:ok, author} = Ethereumex.HttpClient.eth_coinbase()
    IO.puts("author: " <> author)
    {:ok, contract_bin} = File.read("contracts/" <> contract_name <> ".bin")
    IO.puts("contract_bin: " <> contract_bin)

    tx = %{
      "from" => author,
      #      "to" => "0x00", #
      "gas" => "0x47E7C4", # gas, # "0x76c0"
      "gasPrice" => "0x47E7C4", # "0x9184e72a000"
      #      "value" => value, # "0x9184e72a",
      "data" => "0x" <> contract_bin
    }

    # TODO: подождать когда замайнится и получить рецепт с помощью get_tx_receipt
    {:ok, tx_hash} = Ethereumex.HttpClient.eth_send_transaction(tx)

  end

  # Works! Вызов метода
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
      #      "gas" => "0x76c0", # TODO
      #      "gasPrice" => "0x9184e72a000", # TODO
      #      "value" => "0x9184e72a", # TODO
      "data" => data
    }
    Ethereumex.HttpClient.eth_send_transaction(tx)
  end

  # Works! Вызов метода, который не изменяет стейт
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
    Ethereumex.HttpClient.eth_call(tx)
  end

  # BridgeApp.Bridge.listen_for_event(:MetaCoin, "Transfer")
  def listen_for_event(contract_name, event_name) do
    # {:ok, filter_simple} = ExW3.Contract.filter(:MethMain, "RequestForSignature", %{fromBlock: 0, toBlock: "latest"})
    # contract_instance.init_event(contract_instance, ExW3.load_abi("contracts/MethMain.abi"))

    {:ok, filter} = ExW3.Contract.filter(contract_name, event_name)

    {:ok, changes} = ExW3.Contract.get_filter_changes(filter)

    ExW3.Contract.send(
      :MetaCoin,
      :sendCoin,
      [0xf516ee4c8a3bec1e0413de5e3396ddefe506a7d3, 1064400],
      %{from: Enum.at(ExW3.accounts(), 0), gas: 5000000}
    )

    # Some function to deal with the data. Good place to use pattern matching.
    handle_event_changes(changes)

    # Recurse
    listen_for_event(contract_name, event_name)
  end

  def get_logs(topics) do
    # web3.utils.sha3('Transfer(address,address,uint256') = 0xd99659a21de82e379975ce8df556f939a4ccb95e92144f38bb0dd35730ffcdd5

    filter = %{
      topics: ["0xd99659a21de82e379975ce8df556f939a4ccb95e92144f38bb0dd35730ffcdd5"]
    }

    {:ok, result} = Ethereumex.HttpClient.eth_get_logs(filter)

    IO.puts(result)
  end

  def get_tx_receipt(tx_hash) do
    Ethereumex.HttpClient.eth_get_transaction_receipt(tx_hash)
  end

  def get_four_bytes(data) do
    :keccakf1600.hash(:sha3_256, data)
    |> Base.encode16()
    |> String.downcase()
    |> (&("0x" <> &1)).()
    |> (&(String.slice(&1, 0..9))).()
  end

  defp handle_event_changes([]) do  end

  defp handle_event_changes(changes) do
    IO.puts(changes)
  end
end
