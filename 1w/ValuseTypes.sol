// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract ValueType{
    bool public b = true;
    uint public u = 123; //unit = uint256  0 to 2**256 -1;
                            //uint8 0 to 2**8 -1 ;
                            // uint 16 0 to 2**16 -1;

    int public i = -123; //int = int256  -2**255 to 2**255 -1;
                            // int128 -2**127 to 2**127-1;
    int public minInt = type(int).min;
    int public maxInt = type(int).max;

    address public addr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    bytes32 public bs32 = 'hello'; // 32位的一个字节

}