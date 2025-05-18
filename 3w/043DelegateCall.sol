// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// Note:deploy this contract first
contract B {
    // Note: storage layout must be the same sa contract A
    // 状态变量的声明顺序必须和A一致
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(uint256 _num)public payable{
        num = 2 * _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract A{
    uint256 public num;
    address public sender;
    uint256 public value;

    //代理调用B的函数
    function setVars(address _contract, uint256 _num) public payable {
        //  _contract.delegatecall(abi.encodeWithSignature("setVars(uint256",_num));

        // 使用函数选择器的好处是，不用写死函数名及参数名在字符串中，只需要B修改后就会同步更新过来
        (bool success,bytes memory data) = _contract.delegatecall(abi.encodeWithSelector(B.setVars.selector, _num));
        require (success,"delegatecall failed");
    }
}