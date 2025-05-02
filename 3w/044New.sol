// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Account {

    address public bank;
    address public owner;

    constructor(address _owner)payable  {
        bank = msg.sender;
        owner = _owner;
    }
    
}

// 合约工厂
contract AccountFactory{
    Account[] public accounts;

    // new Account{value: aaa}(_owner); 这种写法是固定结构，
    // value 是Solidity的保留关键字，专门用于指定转账金额;不能自定义为其他名称如 aaa ，编译器会报错
    function createAccount(address _owner) external payable {
        uint aaa = 1111;
        Account account = new Account{value: aaa}(_owner);
        accounts.push(account);
    }
}