// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// 库的使用
library Math {
    function max(uint256 x, uint256 y) internal pure returns (uint256) {
        return x >= y ? x : y;
    }
}

contract Test {
    function testMax(uint256 x, uint256 y) external pure returns (uint256) {
        return Math.max(x, y);
    }
}

library ArrayLib {
    function find(uint256[] storage arr, uint256 x)
        internal
        view
        returns (uint256 index)
    {
        for (uint256 i = 0; i < arr.length; i++) {
            if (arr[i] == x) return i;
        }
        revert("not found");
    }
}

contract TestArray {
    // 将ArrayLib这个库的所有功能赋给 unit[]类型相关的数组
    using ArrayLib for uint256[];
    // 声明一个全局数组变量
    uint256[] public arr = [3, 2, 1];

    function testFind() external view returns (uint256) {
        return ArrayLib.find(arr, 1);
    }

    // using声明后可以简化函数调用
    function testFind1() external view returns (uint256) {
        return arr.find(2);
    }
}
