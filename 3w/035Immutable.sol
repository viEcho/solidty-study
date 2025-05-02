// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

//immutable 是一种特殊的状态变量修饰符，用于定义在合约部署后不可修改的变量
//与普通状态变量不同，immutable 变量的值直接写入合约字节码，不占用存储插槽（Storage Slot），因此Gas成本更低
contract Immutable{
    address public owner1 = msg.sender; //gas 52588

    address public immutable owner = msg.sender; //gas 50111

    uint public x;
    function foo() external {
        require((msg.sender == owner1));
        x+=1;
    }
}