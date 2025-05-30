// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract BitwiseOps{
    // x     = 1110 = 8 + 4 + 2 + 0 = 14
    // y     = 1011 = 8 + 0 + 2 + 1 = 11
    // x & y = 1010 = 8 + 0 + 2 + 0 = 10
    // 与 -> 同1为1 不同为0
    function and(uint256 x, uint256 y) external pure returns (uint256) {
        return x & y;
    }
    // x     = 1100 = 8 + 4 + 0 + 0 = 12
    // y     = 1001 = 8 + 0 + 0 + 1 = 9
    // x | y = 1101 = 8 + 4 + 0 + 1 = 13
    // 或 -> 同1为1 同0为0 不同为1
    function or(uint256 x, uint256 y) external pure returns (uint256) {
        return x | y;
    }
    // x     = 1100 = 8 + 4 + 0 + 0 = 12
    // y     = 0101 = 0 + 4 + 0 + 1 = 5
    // x ^ y = 1001 = 8 + 0 + 0 + 1 = 9
    // 异或 -> 同1为0 同0为0 不同为1
    function xor(uint256 x,uint256 y) external pure returns (uint256) {
        return x ^ y;
    }

    // x   = 00001100 = 0 + 0 + 0 + 0 + 8 + 4 + 0 + 0 = 12
    // ~x  = 11110011 = 128 +64 +32 +16 +0 +0 +2 +1 = 243
    // 取反 -> 取反 0 to 1,1 to 0
    function not(uint256 x) external pure returns (uint256) {
        return ~x;
    }
   
    // 1<<0 = 0001 -> 0001 = 1
    // 1<<1 = 0001 -> 0010 = 2
    // 1<<2 = 0001 -> 0100 = 4
    // 1<<3 = 0001 -> 1000 = 8
    // 3<<2 = 0011 -> 1100 = 12
    function shiftLeft(uint256 x,uint256 bits) external pure returns (uint256) {
        return x << bits;
    }
    // 8 >> 0 = 1000 -> 1000 = 8
    // 8 >> 1 = 1000 -> 0100 = 4
    // 8 >> 2 = 1000 -> 0010 = 2
    // 8 >> 3 = 1000 -> 0001 = 1
    // 8 >> 4 = 1000 -> 0000 = 0
    // 12>> 1 = 1100 -> 0110 = 6
    function shiftRight(uint256 x,uint256 bits) external pure returns(uint256){
        return x >> bits;
    }

    // get last n bits from x
    // example, 13 last 3 bits
    // x      = 1101 = 13
    // mask   = (1<<n)-1 
    //          0001 << 3 = 1000 - 1 = 0111 = 6
    // output = 1101 & 0111 = 0101 = 4 + 1 = 5

    // example, 8 last 2 bits
    // x      = 0100 = 8
    // mask   = (1<<2)-1
    //           0001 << 2 = 0100 - 1 = 0011 = 3
    // output = 0100 & 0011 = 0000  = 0
    function getLastNBits(uint256 x,uint256 n)external pure returns(uint256){
        uint mask = (1<<n) - 1;
        return x & mask;
    }
    //- 数学上， x % (1 << n) 等价于 x & ((1 << n) - 1)
    //- 但模运算方法少了一次减法操作(不需要 -1 )
    function getLastNBitUsingMod(uint256 x,uint n) external pure returns(uint256){
        return x % (1<<n);
    }
}