// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MyERC20_2 is IERC20 {
    mapping (address => uint) public override balanceOf;
    mapping (address => mapping (address => uint)) public override allowance;

    uint256 public override totalSupply;

    string public name;
    string public symbol;

    uint8 public decimals = 18;

    constructor(string memory _name,string memory _symbol) payable {
        name = _name;
        symbol = _symbol;
        totalSupply = 10000 * (10 ** uint256(decimals));
    } 

    function transfer(address _recipient,uint _amount) public override returns(bool){
        balanceOf[msg.sender] -= _amount;
        balanceOf[_recipient] += _amount;
        emit Transfer(msg.sender,_recipient,_amount);
        return true;
    }

    function approve(address _spender,  uint _amount) public override returns(bool) {
        allowance[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }

    //合约调用，msg.sender为合约
    function transferFrom(address _spender,address _recipient,uint _amount) public override returns(bool) {
        require(allowance[_spender][msg.sender] >= _amount, "allowance error");
        allowance[_spender][msg.sender] -= _amount;
        balanceOf[_spender] -= _amount;
        balanceOf[_recipient] += _amount;
        emit Transfer(_spender,_recipient,_amount);
    }

    function mint(uint _amount) public returns(bool) {
        balanceOf[msg.sender] += _amount;
        totalSupply += _amount;
        emit Transfer(address(0),msg.sender,_amount);
        return true;
    }

    function burn(uint _amount) public returns(bool) {
        balanceOf[msg.sender] -= _amount;
        totalSupply -= _amount;
        emit Transfer(msg.sender,address(0),_amount);
        return true;
    }
}