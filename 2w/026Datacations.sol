// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title Datacations 数据传输
 * 1.如果我们想修改链上的数据我们就用storage来声明
 * 2.在方法中修改链上数据会被影响到状态变量
 * 3.想要读取只是读的话我们就用memory来声明
 * 4.
 * @author
 * @author 
 */
contract Datacations {

    struct MyStruct{
        uint256 foo;
        string text;
    }

    mapping(address => MyStruct) myStructs;

    function examples(uint[] calldata y,string calldata) external returns(uint [] memory){
        myStructs[msg.sender] = MyStruct({foo:123, text:"bar"});
        // 将对象声明为storage，这样就修改就可以影响到对应的状态变量，表明是要在链上修改
        MyStruct storage myStruct1 = myStructs[msg.sender];
        myStruct1.text = "foo";

        // 将对象声明为内存存只读在方法内部修改为456，并没有把值修改到链上
        MyStruct memory readOnly = myStructs[msg.sender];
        readOnly.foo = 456;

        // 如果我们将_internal 的参数y改为memory类型，在调用_internal 传入y时，就会在内存中重新创建一份
        // 如果直接声明为calldata 因为其不可被修改 就少了一步复制的过程，节省对应的gas
        _internal(y);

        uint []memory memArr = new uint[](3);
        memArr[0] = 123;
        return memArr;
    }

    function _internal(uint[] calldata y) private {
        uint x = y[0];
    }
}