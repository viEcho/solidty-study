// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// 定义对应的接口
interface ICounter{
    function count() external view returns(uint);
    function increment() external ;
}

contract MyContract{
    function incrementCounter(address _counter) external {
        ICounter(_counter).increment();
    }

    function getCount(address _counter) external view returns (uint256){
        return ICounter(_counter).count();
    }
}