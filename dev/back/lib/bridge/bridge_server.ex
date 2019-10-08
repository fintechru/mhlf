defmodule BridgeApp.Bridge.BridgeServer do
  use GenServer
  # API
  def start_link do
    GenServer.start_link(__MODULE__, [], name: :bridge_server)
  end

  def run_ethereum_listener(contract_address, contract_name, topics, event_name) do
    Process.flag(:trap_exit, true)
    {pid, ref} = spawn_monitor(BridgeApp.Bridge.Ethereum, :listen, [contract_address, contract_name, topics, event_name])

    receive do
      {:EXIT, ref, :process, from_pid, reason} -> IO.puts("Exit reason: #{reason}")
    end
  end

  # SERVER
  def init(messages) do
    {:ok, messages}
  end

  def handle_cast({:add_message, new_message}, messages) do
    {:noreply, [new_message | messages]}
  end

  def handle_call(:get_messages, _from, messages) do
    {:reply, messages, messages}
  end
end
