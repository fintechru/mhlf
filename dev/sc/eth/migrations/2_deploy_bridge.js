const Bridge = artifacts.require("Bridge");

module.exports = function (deployer) {
    deployer.deploy(Bridge, {
        // gas: "0x47E7C4",
        // gasPrice: "0x47E7C4",
        // from: "0x1498b1f46537d660dc40a908d64354763e18aa66"
    }).then(() => console.log("ETH_BRIDGE_SMART_CONTRACT: ", Bridge.address));
};
