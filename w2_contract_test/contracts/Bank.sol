// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.24;

contract Bank {
    address public owner;
    mapping (address => uint) deposits;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(owner == msg.sender,"Not owner");
        _;
    }

    receive() external payable {
        deposits[msg.sender] += msg.value;
    }

    function myDeposit() public view returns(uint) {
        return deposits[msg.sender];
    }

    function myWithDraw() public {
        (bool success,) = msg.sender.call{value: deposits[msg.sender]}(new bytes(0));
        require(success == true,"ETH withdraw failed");
        deposits[msg.sender] = 0;
    }

    function withDrawAll() public onlyOwner{
        uint balance = address(this).balance;
        payable(owner).transfer(balance);
    }
}