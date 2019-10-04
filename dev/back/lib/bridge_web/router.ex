defmodule BridgeAppWeb.Router do
  use BridgeAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BridgeAppWeb do
    pipe_through :api
  end
end
