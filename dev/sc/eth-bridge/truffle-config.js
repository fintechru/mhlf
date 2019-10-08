module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "2019",
      gas: 6721975,
      // gasPrice: 7000000,
      from: "0x1498b1f46537d660dc40a908d64354763e18aa66"
    },
    test: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*"
    }
  }
};
