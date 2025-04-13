// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

/**
* Array -动态或固定长度数组
* 初始化
* Insert(push) get update delete pop length
* creating arr in memory
* returning arry from function
**/

contract Array{
    uint [] public nums = [1,2,3];
    uint [3] public numsFixed = [4,5,6];

    function examples() external {
        nums.push(4);
        uint x = nums[1];
        nums[2] = 777;
        delete nums[1]; // [1,0,777,4]
        nums.pop();
        uint len = nums.length;

        // create array in memory
        uint [] memory a = new uint[] (3);
        a[1] = 123;
    }


    function returnArray() external view returns (uint [] memory){
        return nums;
    }

}