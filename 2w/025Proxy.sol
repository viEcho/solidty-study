// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract TestContract1{
    address public owner = msg.sender;

    function setOwner(address _owner) public {
        require(msg.sender == owner,"not owner");
        owner = _owner;
    }

}
contract TestContract2 {
    address public owner = msg.sender;
    uint256 public value = msg.value;
    uint256 public x;
    uint256 public y;
    constructor(uint256 _x,uint256 _y){
        x = _x;
        y = _y;
    }
}

contract Proxy{
    event Deploy(address);
    function deploy(bytes memory _code) external payable returns(address addr){

        assembly{
            addr:=create(callvalue(), add(_code,0x20),mload(_code))
        }
        require(addr!= address(0),"deploy failed");
        emit Deploy(addr);
    }

    function exectue(address _target, bytes memory _data)external payable{  
        (bool success,) = _target.call{value: msg.value}(_data);
        require(success,"failed");
    }

}

contract Helper{
    function getBytecode1( )external  pure returns (bytes memory){ 
        bytes memory bytecode = type(TestContract1).creationCode;
        return bytecode;
    }
    function getBytecode2(uint256 _x,uint256 _y)external pure returns (bytes memory){
        bytes memory bytecode = type(TestContract2).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_x,_y));
    }

    function getCalldata(address _owner) external pure returns (bytes memory){
        return abi.encodeWithSignature("setOwner(address)", _owner);
    }
}