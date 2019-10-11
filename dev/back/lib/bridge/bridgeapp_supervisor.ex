defmodule BridgeApp.BridgeSupervisor do
  use GenServer

  def set_up_listeners do
    opts = [restart: :transient]

    Task.Supervisor.start_child(__MODULE__, BridgeApp.Bridge.EthereumListener, :eth_listener, [], opts)
    Task.Supervisor.start_child(__MODULE__, BridgeApp.Bridge.FabricListener, :fabric_listener, [], opts)
  end

end
