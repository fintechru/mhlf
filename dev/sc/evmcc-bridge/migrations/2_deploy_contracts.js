const FabricBridge = artifacts.require("FabricBridge");

module.exports = function(deployer) {
  deployer.deploy(FabricBridge);
};
