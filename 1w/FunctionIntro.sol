// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract FunctionIntroduction {
    function add(uint x,uint y) external pure returns (uint) {
        return x+y;
    }

    function sub(uint x, uint y) external pure returns (uint) {
        return x-y;
    }
}