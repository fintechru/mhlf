defmodule BridgeApp.GethListener do
  @moduledoc false

  require Logger

  alias Ethereumex.HttpClient

  def listen_for_event(contract_instance, contract_name, event_name) do
    # {:ok, filter_simple} = ExW3.Contract.filter(:MethMain, "RequestForSignature", %{fromBlock: 0, toBlock: "latest"})
    # contract_instance.init_event(contract_instance, ExW3.load_abi("contracts/MethMain.abi"))

    {:ok, filter} = contract_instance.filter(contract_name, event_name)

    {:ok, changes} = contract_instance.get_filter_changes(filter)

    # Some function to deal with the data. Good place to use pattern matching.
    handle_event_changes(changes)

    # Recurse
    listen_for_event(contract_instance, contract_name, event_name)
  end

  defp handle_event_changes([]) do
    IO.puts 1
  end

  defp handle_event_changes(changes) do
    IO.puts(changes)
  end
end
