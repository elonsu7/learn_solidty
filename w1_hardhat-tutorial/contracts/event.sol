// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;
contract WTF_Event {
    address public contractOwner;

    constructor() payable{
        contractOwner = msg.sender;
        _balance[contractOwner] = 1000000000;

    }

    mapping(address => uint256) public _balance;

    // from和to前面带有indexed关键字，他们会保存在以太坊虚拟机日志的topics中
    event Transfer(address indexed from,address indexed to, uint256 value); 

    function transfer(
        address to,
        uint256 amount
    ) external {
        
        _balance[contractOwner] -= amount;
        _balance[to] += amount;
        
        emit Transfer(contractOwner, to, amount);
    }
}