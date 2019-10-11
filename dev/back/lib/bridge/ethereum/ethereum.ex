defmodule BridgeApp.Bridge.EthereumListener do
  require Logger
  alias Ethereumex.HttpClient
  use GenStage

  @interval 1_000

  def start_link do
    {:ok, pid} = Task.start_link(
      fn ->
        loop(%{time: :random.uniform, voltage: 42})
      end
    )
    Task.start_link(fn -> tick([interval: @interval, pid: pid]) end)
    {:ok, pid}
  end

  # consumer’s loop
  defp loop(map) do
    receive do
      {:state, caller} -> # state requested
        send caller, {:voltage, Map.get(map, :voltage)}
        loop(map)
      {:ping} -> # tick
        loop(
          map
          |> Map.put(:voltage, map.voltage + 1)
          |> Map.put(:time, map.time + :random.uniform / 12)
        )
    end
  end

  # listener
  defp tick(init) do
    IO.inspect init, label: "Tick"
    send init[:pid], {:ping}
    Process.sleep(init[:interval])
    tick(init)
  end

  def init(state) do
    Process.send_after(self(), :work, @interval)
    {:ok, %{last_run_at: nil}}
  end

  def handle_info(:work, state) do

    listen()

    Process.send_after(self(), :work, @interval)

    {:noreply, %{last_run_at: :calendar.local_time()}}

  end

  def listen() do

    # TODO: улучшить - сохранять номер блока, на котором остановилась прошлая проверка
    bridge_contract_address = System.get_env(
      "ETH_BRIDGE_SMART_CONTRACT"
    ) # Application.get_env(:eth_contract, :eth_bridge_contract_address)
    topics = System.get_env("ETH_TOPICS") # Application.get_env(:eth_contract, :eth_contract_topics)

    IO.puts("address: " <> bridge_contract_address)
    IO.puts("topics: " <> topics)

    {:ok, result} = BridgeApp.Utils.Ethereum.get_logs(bridge_contract_address, topics)

    IO.puts("event logs: " <> result)

    listen()

    #    with url <- Application.get_env(:fabric_network, :fabric_network_url),
    #         # скорректировать method, params
    #         command <- %{jsonrpc: "2.0", method: "web3_clientVersion", params: [], id: 67},
    #         body <- Poison.encode!(command),
    #         headers <- [{"Content-Type", "application/json"}]
    #      do
    #      HTTPoison.post!(url, body, headers)
    #    end

  end

  defp handle_event_changes([]) do
    IO.puts 1
  end

  defp handle_event_changes(changes) do
    IO.puts(changes)
  end

end
