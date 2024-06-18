import { expect } from "chai";
import { ContractTransactionResponse } from "ethers";
import { ethers } from "hardhat";
import { Counter } from "../typechain-types";

let counter: Counter & { deploymentTransaction(): ContractTransactionResponse; };

describe("Counter", function () {
  async function init() {
    const [owner, otherAccount] = await ethers.getSigners();
    const Counter = await ethers.getContractFactory("Counter");
    counter = await Counter.deploy();
  }

  before(async function () {
    await init();
  });

  // 
  it("init equal 0", async function () {
    expect(await counter.get()).to.equal(0);
  });

  it("add 1 equal 1", async function () {
    let tx = await counter.count();
    await tx.wait();
    expect(await counter.get()).to.equal(1);
  });

});
