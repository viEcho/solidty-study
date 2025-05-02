// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;


contract Etherwallet{
    address payable public owner;

    constructor(){
        owner = payable  (msg.sender);
    }

    // 接收以太放入内置对象address的属性balance中
    receive() external payable {

    }

    // 取款，校验
    function withdraw(uint _amount) external {
        require(msg.sender == owner, "caller is not owner");
        payable(msg.sender).transfer(_amount);
    }

    // 获取当前余额
    function getBalance() external view returns (uint){
        return address(this).balance;
    }
}