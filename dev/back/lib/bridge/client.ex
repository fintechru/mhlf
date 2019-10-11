defmodule BridgeApp.Bridge.Client do
  use GenServer

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def run_ethereum_listener(contract_address, contract_name, topics, event_name) do
    Process.flag(:trap_exit, true)
    {pid, ref} = spawn_monitor(
      BridgeApp.Bridge.Ethereum,
      :listen,
      [contract_address, contract_name, topics, event_name]
    )

    receive do
      {:EXIT, ref, :process, from_pid, reason} -> IO.puts("Exit reason: #{reason}")
    end
  end

  def queue do
    GenServer.call(__MODULE__, :queue)
  end

  def dequeue do
    GenServer.call(__MODULE__, :dequeue)
  end

  def enqueue(value) do
    GenServer.cast(__MODULE__, {:enqueue, value})
  end

  def log(pid, msg) do
    GenServer.cast(pid, {:log, msg})
  end

end
