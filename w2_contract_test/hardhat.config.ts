import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const INFURA_API_KEY = "4086141d25bc4e7cb13ef0fbcb44532f";
const SEPOLIA_PRIVATE_KEY = "6511e11fd534d5e98e9149746472e1a831c99cdb5a024935ca17b8b986675084";
const ETHERSCAN_API_KEY = "3NGYM7Z8H6B42GAE8DP2V1WXGR87U8MAI2";

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    sepolia: {
      url: `https://sepolia.infura.io/v3/${INFURA_API_KEY}`,
      accounts: [SEPOLIA_PRIVATE_KEY]
    }
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY
  },
  sourcify: {
    enabled: true
  },
};

export default config;
