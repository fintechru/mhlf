defmodule BridgeApp.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      BridgeApp.Repo,
      BridgeAppWeb.Endpoint,
      {Task.Supervisor, name: BridgeApp.BridgeSupervisor}
    ]

    opts = [strategy: :one_for_one, name: BridgeApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BridgeAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
