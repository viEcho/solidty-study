// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract caller{
    function setX(TestContract _test,uint _x) external {
        _test.setX(_x);
    }

    function getX(address _test) external view returns(uint x){
        x = TestContract(_test).getX();
        return x;
    }

    function setXandSendEther(TestContract _test,uint _x) external payable{
        _test.setXandSendEther{value: msg.value}(_x);
    }
    function getXandValue(address _test)external view returns(uint x, uint value){
        (x, value) = TestContract(_test).getXandValue();
    }
}

contract TestContract{
    uint256 public x;
    uint256 public value = 123;
    function setX(uint256 _x) public returns(uint256){
        x = _x;
        return x;
    }

    function getX() external view returns(uint){
        return x;
    }
    function setXandSendEther(uint256 _x) public payable{
        x = _x;
        value = msg.value;
    }

    function getXandValue() external view returns(uint, uint){
        return (x, value);
    }
}