// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyERC20 is ERC20 {
    constructor() ERC20(unicode"西游记妖精谱","Journey to the West Fairy Collection"){
        _mint(msg.sender, 10000 * 10 ** 18);
    }
}