// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// visibility 可见性有以下几类
// private -> 只在合约内部
// internal -> 合约内部或子合约
// public -> 内部或外部合约 
// external -> 只能被外部合约调用
contract Base{
    uint private x = 0;
    uint internal y = 1;
    uint public z = 2;

    function privateFunc() private pure returns (uint){
        return 0;
    }
    function internalFunc() internal pure returns (uint) { 
        return 100;
    }

    function publicFunc() public pure returns(uint) {
        return 200;
    }
    function externalFunc() external pure returns (uint){
        return 300;
    }

    function examples() external view{
        x + y+ z;
        privateFunc();
        internalFunc();
        publicFunc();
    }
}
contract Child is Base {

    function example2() external view{
        y  + z;
        internalFunc();
        publicFunc();
        //privateFunc(); 私有合约函数--只能在当前合约内访问
        //externalFunc(); 子合约也不能访问，子合约不属于合约外部
    }

}