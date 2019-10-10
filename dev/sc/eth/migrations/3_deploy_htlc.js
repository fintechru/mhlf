const HashedTimelock = artifacts.require("HashedTimelockContract");

module.exports = function(deployer) {
  deployer.deploy(HashedTimelock, {
    from: "0x1498b1f46537d660dc40a908d64354763e18aa66"
  });
};
