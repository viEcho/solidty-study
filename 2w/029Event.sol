// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
// Topics 是以太坊事件日志的“快速索引”，用于高效过滤关键参数（如地址）。
// Data 是“详细数据存储区”，保存非索引参数的原始信息，需结合 ABI 解析后使用。 
// 两者共同构成了事件日志的完整信息结构，平衡了检索效率与数据完整性
contract Event {

    // up to 3 index
    // Topics 存储：每个事件最多允许 3 个索引参数，存入Topics 数组;
    // 非索引参数存储在 Data 区域，Gas 消耗与数据大小相关
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