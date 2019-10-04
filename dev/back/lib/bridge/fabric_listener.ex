defmodule BridgeApp.Web3 do
  @moduledoc false

  alias Ethereumex.HttpClient

  def client_version() do

    case HttpClient.web3_client_version() do
      {:ok, client_version} -> {:ok, client_version}
      {:error, _} -> {:error, "Something went wrong"}
    end

  end

end
