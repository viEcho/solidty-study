// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract StateVariable {
    uint public myUint = 123; //状态变量 存在于区块链上

    function foo() external pure returns (uint) {
        uint notStateVar = 456; //局部变量只在函数内部;
        return notStateVar;
    }
}