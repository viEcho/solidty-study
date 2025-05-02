// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// 定义基础的counter方法
contract Counter{
    uint256 count;
    function increment() public {
        count += 1;
    }
}