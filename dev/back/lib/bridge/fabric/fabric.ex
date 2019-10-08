defmodule BridgeApp.Bridge.Fabric do
  @moduledoc false

  use GenStage

  def start_link(initial \\ 0) do
    GenStage.start_link(__MODULE__, initial, name: __MODULE__)
  end

  def init(counter), do: {:producer, counter}

  def handle_demand(demand, state) do
    events = Enum.to_list(state..(state + demand - 1))
    {:noreply, events, state + demand}
  end

  # Прослушиваем события FabricNet
  ## Спавним процесс, в котором в бесконечном цикле слушаем конкретный контракт
  ## При поступлении события отправляем его в процесс отвечающий за бизнес-логику

  def sc_listener() do
    with url <- Application.get_env(:fabric_network, :fabric_network_url),
         # скорректировать method, params
         command <- %{jsonrpc: "2.0", method: "web3_clientVersion", params: [], id: 67},
         body <- Poison.encode!(command),
         headers <- [{"Content-Type", "application/json"}]
      do
      HTTPoison.post!(url, body, headers)
    end
  end
  
end
