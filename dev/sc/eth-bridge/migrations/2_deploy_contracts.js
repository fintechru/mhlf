const EthBridge = artifacts.require("EthBridge");

module.exports = function(deployer) {
  deployer.deploy(EthBridge, {
    // gas: "0x47E7C4", 
    // gasPrice: "0x47E7C4",
    from: "0x1498b1f46537d660dc40a908d64354763e18aa66"
  });
};