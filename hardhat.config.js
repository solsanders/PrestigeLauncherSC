require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.27",
  networks: {
    argochain: {
      url: "https://rpc-mainnet.devolvedai.com",
      accounts: ["394b4c1022588e4e05ed9d4568d810dcc88537c3df67cca9172f9bb9f9619756"]
    },
  },
};
