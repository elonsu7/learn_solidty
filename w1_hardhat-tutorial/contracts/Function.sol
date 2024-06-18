// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;
contract FunctionTypes{
    uint256 public number = 5;
    uint[] public x = [1,2,3,4,5]; 
    mapping(uint => address) public idToAddress;
    mapping(address => address) public swapPair;
    
    constructor() payable {}

    // 函数类型
    // function (<parameter types>) {internal|external} [pure|view|payable] [returns (<return types>)]
    // 默认function
    function add() external{
        number = number + 1;
    }

    // pure: 纯纯牛马
    function addPure(uint256 _number) external pure returns(uint256 new_number){
        new_number = _number+1;
    }
    
    // view: 看客
    function addView() external view returns(uint256 new_number) {
        new_number = number + 1;
    }

    // internal: 内部函数
    function minus() internal {
        number = number - 1;
    }

    // 合约内的函数可以调用内部函数
    function minusCall() external {
        minus();
    }

    // payable: 递钱，能给合约支付eth的函数
    function minusPayable() external payable returns(uint256 balance) {
        minus();    
        balance = address(this).balance;
    }

    function fStorage() public {
        uint[] storage xstorage = x;
        xstorage[0] = 100;
    }

    function fMemory() public view {
        uint[] memory xmemory = x;
        xmemory[0] = 10;
        xmemory[1] = 20;
        uint[] memory xmemory2 = xmemory;
        xmemory2[0] = 300;
    }

    function writeMap(uint _key, address _vlaue) public {
        idToAddress[_key] = _vlaue;
    }

    function insertionSort(uint[] memory a) public pure returns(uint[] memory) {
        for(uint i = 1; i < a.length; i++) {
            uint temp = a[i];
            uint j = i;
            while(j >= 1 && a[j - 1] > temp) { 
                a[j] = a[j - 1];
                j --;
            }
            a[j] = temp;
        }
        return a;
    }

        // 插入排序 错误版 [7,5,2,8,4]
    function insertionSortWrong(uint[] memory a) public pure returns(uint[] memory) {
        
        for (uint i = 1;i < a.length;i++){
            uint temp = a[i]; //5
            uint j=i-1; //0
            while( (j >= 0) && (temp < a[j])){
                a[j+1] = a[j]; // 5 <=> 7
                j--; // -1
            }
            a[j+1] = temp;
        }
        return(a);
    }
}