// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

//payable 是用于处理以太币（Ether）的核心修饰符，允许合约或函数接收、转移和管理以太币
//balance 是地址（address 或 address payable 类型）的内置属性

//msg 是内置对象，包含 sender、value 等属性。
//block 是内置对象，包含 timestamp、number 等属性。
//balance 仅依附于地址类型，不构成独立对象
contract Payable{
    address payable public owner;

    constructor (){
        owner = payable (msg.sender);
    }
    function deposit() external payable{
        //空函数体：发送的以太币会自动存入合约地址的余额中，无需额外逻辑
    }
    function getBalance() external view returns(uint){
        require(msg.sender == owner,"only the owner can getBalance");
        return address(this).balance;
    }
}