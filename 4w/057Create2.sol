// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract DeployWithCreate2{
    address public owner;

    constructor(address _owner){
        owner = _owner;
    }
}

contract Create2Factory{
    event Deploy (address addr);

    function deploy() external {
        
    }
}