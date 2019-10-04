accounts = ExW3.accounts()
burrow_main_abi = ExW3.load_abi("abi/build/BurrowMain.abi")
ExW3.Contract.start_link()
ExW3.Contract.register(:BurrowMain, abi: burrow_main_abi)

{:ok, address, tx_hash} =
  ExW3.Contract.deploy(:BurrowMain,
    bin: ExW3.load_bin("abi/build/BurrowMain.bin"),
    options: %{gas: 3000000, from: Enum.at(accounts, 0)}
  )

ExW3.Contract.at(:BurrowMain, "0xfce3be05e6b4938ae94f64d48dbb987afc972c2b")

ExW3.Contract.send(:BurrowMain, :setValue, [187], %{
  from: Enum.at(ExW3.accounts(), 0),
  gas: 50000
})

{:ok, {receipt, logs}} = ExW3.Contract.tx_receipt(:BurrowMain, "2d60a18e3f3abc58af2645ce4249aa93b0af51b4306120485dcb9ebf14be0d30")

ExW3.Contract.call(:BurrowMain, :getValue)
{:ok, filter_simple} = ExW3.Contract.filter(:BurrowMain, "ChangeValue") # TODO есть ли eth.NewFilter в Burrow
{:ok, filter_id} = ExW3.Contract.filter(:BurrowMain, "ChangeValue", %{fromBlock: 0, toBlock: "latest"})
{:ok, changes} = ExW3.Contract.get_filter_changes(filter_simple)

defmodule Bridge do
  def listen_for_event do
    # Get our changes from the blockchain
    {:ok, changes} = ExW3.Contract.get_filter_changes(filter_id)
    # Some function to deal with the data. Good place to use pattern matching.
    handle_changes(changes)
    # Some delay in milliseconds. Recommended to save bandwidth, and not spam.
    :timer.sleep(1000)
    # Recurse
    listen_for_event()
  end
end
