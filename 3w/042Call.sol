// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract TestCall{
    string public message;
    uint public x;

    event Log(address caller,uint256 amount,string message);

    receive()external payable {}
    fallback() external payable { 
        emit Log(msg.sender,msg.value, "fallback was called");
    }

    function foo(string memory _message, uint256 _x) public payable returns(bool,uint){
        message = _message;
        x= _x;
        return (true, 9999);
    }

}

contract Call {
    bytes public data;
    function callFoo(address _test) external payable {
        // 使用call根据函数的签名去调用指定的方法，指定发送的以太和消耗的gas  
        // 这里5000的gas调用失败是因为gas不足 如果传入的不是指定的111的以太则也报错
        (bool success,bytes memory _data) = _test.call{value:111,gas:5000}(abi.encodeWithSignature("foo(string,uint256)", "call foo",123));
        require(success, "call failed");
        data = _data;
    }

    // 使用call去调用一个默认不存在的方法 如果目标函数所在的合约中没有fallback函数则直接报错；如果有fallback则触发fallback函数的执行
    function callNoExist(address _test) external {
        (bool success,) = _test.call(abi.encodeWithSignature("doNotExistMethod()"));
        require(success,"call failed");
    }
}