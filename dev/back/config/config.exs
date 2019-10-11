# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bridge,
  namespace: BridgeApp,
  ecto_repos: [BridgeApp.Repo]

# Configures the endpoint
config :bridge, BridgeAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CGFF7sRN95UBcVO/g5HNbNaIaQw5lCm99edtXDHaKwuHyicrhCRKUxbPGFcXfPJQ",
  render_errors: [view: BridgeAppWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: BridgeApp.PubSub, adapter: Phoenix.PubSub.PG2]

# Конфигурируем логгер
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Подключаемся к Ethereum узлу по порту ; WebSocket: ws://localhost:8545
config :ethereumex, url: "http://localhost:8545"

#config :ethereumex, ipc_path: "docker exec -it geth-node go-ethereum/build/bin/geth attach /root/.ethereum/geth.ipc"

#config :fabric_network, fabric_network_url: "http://localhost:8545"
#
#config :eth_contract, eth_bridge_contract_address: System.get_env("ETH_BRIDGE_SMART_CONTRACT")
#config :eth_contract, eth_htlc_contract_address: System.get_env("ETH_HTLC_SMART_CONTRACT")
#config :eth_contract, eth_contract_topics: System.get_env("ETH_TOPICS")
#config :fabric_contract, fabric_contract_address: System.get_env("FABRIC_CONTRACT_ADDRESS")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
