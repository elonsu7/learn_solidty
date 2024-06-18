import { ethers } from "hardhat";

async function main() {
    const Bank = await ethers.getContractFactory("Bank");
    const bank = await Bank.deploy();
    bank.waitForDeployment();
    const address = await bank.getAddress();
    console.log("Bank address:", address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });