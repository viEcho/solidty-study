// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract SendEther {
    constructor() payable{}

    receive() external payable { }

    function sendViaTransfer(address payable _to) external payable {
        _to.transfer(123);
    }

    function sendViaSend(address payable _to)external payable{ 
        bool sent = _to.send(123);
        require(sent,"send failed");
    }
    function sendViaCall(address payable _to) external payable returns (bool isSuccess, bytes memory returnData){
        (bool success, bytes memory data) =  _to.call{value : 123}("");
        require(success ,"call failed");
        return (success, data);
    }

    function testName1() external pure returns (bool resIsTrue,uint resAmout, string memory resMessage){
        (bool isTrue, uint amout, string memory message) = testSameName();
        return (isTrue, amout,message);
    }

    function testSameName() public pure returns(bool isTrue,uint amout, string memory message){
        return(true,123,"ok");
    }

}
contract EthReciver{
    event Log(uint amount,uint gas);

    receive() external payable { 
        emit Log(msg.value, gasleft());
    }
}