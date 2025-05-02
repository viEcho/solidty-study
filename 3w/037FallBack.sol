// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;


/**
*
函数不存在，直接发送以太

        Ether
          |
       is msg.data empty?
         /           \
        Yes           No
        /               \
    receive() exists?  fallback()
    /        \
  Yes         No
   |           |
 receive()     fallback()
*/
contract Fallback {
    
    event Log(string func,address sender,uint value,bytes data);

    fallback() external payable { 
        emit Log("fallback",msg.sender,msg.value,msg.data);
    }
    // receive() external payable{
    //     emit Log("Receive",msg.sender,msg.value,"");
    // }
}