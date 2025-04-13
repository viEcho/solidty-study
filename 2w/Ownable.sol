// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 一定要点左侧acoount那边的复制才能复制到完整的地址 
contract Ownable{
    address public owner;

    constructor(){
        owner = msg.sender;
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner, "Only owner can do this");
        _;
    }

    function setOwner(address _newOwner) external onlyOwner{
        require(_newOwner != address(0),"invid address");
        owner = _newOwner;
    }

    function onlyOwnerCanCallThisFunc () external onlyOwner{
         // code
    }
    function anyOneCanCall()external {
        // code
    }
}