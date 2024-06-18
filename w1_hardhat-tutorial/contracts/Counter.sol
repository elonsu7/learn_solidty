// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "hardhat/console.sol";

// Author: Elon Xu
contract Counter {
    uint counter;
    constructor() {
        counter = 0;
    }

    function count() public {
        counter = counter + 1;
        console.log("counter is %s", counter);
    }

    function get() public view returns (uint) {
        return counter;
    }
}

contract Token is ERC20 {
  constructor(uint256 initialSupply) ERC20("NewToken", "NT") {
    _mint(msg.sender, initialSupply);
  }
}