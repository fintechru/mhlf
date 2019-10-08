defmodule BridgeApp.Bridge.Ethereum do
  require Logger
  alias Ethereumex.HttpClient

  def listen(contract_address, topics) do

    {:ok, result} = BridgeApp.Utils.Ethereum.get_logs(contract_address, topics)

    IO.puts result

#    {:ok, <<_ :: binary>>} = result

    # {:ok, filter_simple} = ExW3.Contract.filter(:MethMain, "RequestForSignature", %{fromBlock: 0, toBlock: "latest"})
    # contract_instance.init_event(contract_instance, ExW3.load_abi("contracts/MethMain.abi"))

    # {:ok, filter} = contract_instance.filter(contract_name, event_name)
    # {:ok, changes} = contract_instance.get_filter_changes(filter)

#    with url <- Application.get_env(:fabric_network, :fabric_network_url),
#         # скорректировать method, params
#         command <- %{jsonrpc: "2.0", method: "web3_clientVersion", params: [], id: 67},
#         body <- Poison.encode!(command),
#         headers <- [{"Content-Type", "application/json"}]
#      do
#      HTTPoison.post!(url, body, headers)
#    end

    # принимать сообщения, нужно ли этому модулю принимать сообщения?
#    receive do
#      {:ok, result} -> handle_event_changes("changes")
#    end

    # Recurse
    listen(contract_address, topics)
  end



  defp handle_event_changes([]) do
    IO.puts 1
  end

  defp handle_event_changes(changes) do
    IO.puts(changes)
  end

end
