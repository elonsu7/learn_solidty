import { ethers } from "hardhat";

async function main() {
    const Counter = await ethers.getContractFactory("Counter");
    const counter = await Counter.deploy();
    counter.waitForDeployment;
    const address = await counter.getAddress();
    console.log("Counter address:", address);
}

main();