accounts = ExW3.accounts()
meth_main_abi = ExW3.load_abi("abi/build/MethMain.abi")
ExW3.Contract.start_link()
ExW3.Contract.register(:MethMain, abi: meth_main_abi)

{:ok, address, tx_hash} =
  ExW3.Contract.deploy(:MethMain,
    bin: ExW3.load_bin("abi/build/MethMain.bin"),
    options: %{gas: 3000000, from: Enum.at(accounts, 0)}
  )

ExW3.Contract.at(:MethMain, address)

ExW3.Contract.send(:MethMain, :setValueInBurrow, [187], %{
  from: Enum.at(ExW3.accounts(), 0),
  gas: 50000
})

ExW3.Contract.call(:MethMain, :getValueInBurrow)
{:ok, filter_simple} = ExW3.Contract.filter(:MethMain, "RequestForSignature")
{:ok, filter_id} = ExW3.Contract.filter(:MethMain, "RequestForSignature", %{fromBlock: 0, toBlock: "latest"})
{:ok, changes} = ExW3.Contract.get_filter_changes(filter_simple)

