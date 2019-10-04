defmodule BridgeApp.Repo do
  use Ecto.Repo,
    otp_app: :bridge,
    adapter: Ecto.Adapters.Postgres
end
