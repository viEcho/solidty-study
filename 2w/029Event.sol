// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
contract Event {

    // up to 3 index
    // Topics 存储：每个事件最多允许 3 个索引参数，存入 Topics 数组
    event Log(string message, uint256 _myData);
    event IndexedLog(address indexed sender, uint val);
    
    function example() external  {
        emit Log("foo", 1234);
        emit IndexedLog(msg.sender, 789);
    }

    event Message (address indexed _from, address indexed _to, string mesage);

    function sendMessgae(address _to,string calldata message) external {
        emit Message(msg.sender,_to,message);
    }
}