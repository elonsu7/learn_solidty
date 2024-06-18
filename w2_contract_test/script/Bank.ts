import { ethers } from "hardhat";

async function main() {
    const Bank = await ethers.getContractFactory("Bank");
    const bank = await Bank.deploy();
    bank.waitForDeployment;
    const address = await bank.getAddress();
    console.log("bank address:", address);
}

main();
