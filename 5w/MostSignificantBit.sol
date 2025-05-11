// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// x = 2^r + remainder
// 求一个整数的最高位是多少 即最多是2的多少次方+remainder
contract MostSignificantBit{
    function findMostSignificantBit(uint256 x) external pure returns(uint8 r){
        if(x >= 2 ** 128){
            x >>= 128;
            r+= 128;
        }
        if(x >= 2 ** 64){
            x >>= 64;
            r+= 64;
        }
        if(x >= 2 ** 32){
            x >>= 32;
            r+= 32;
        }
        if(x >= 2 ** 16){
            x >>= 16;
            r+= 16;
        }
        if(x >= 2 ** 8){
            x >>= 8;
            r+= 8;
        }
        if(x >= 2 ** 4){
            x >>= 4;
            r+= 4;
        }
        if(x >= 2 ** 2){
            x >>= 2;
            r+= 2;
        }
        if(x >= 2 ** 1){
            r+= 1;
        }
    }
}