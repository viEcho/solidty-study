// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract GasGolf{

    // start-58400 gas
    // use calldata 56413
    // load state variable to memory 56170
    // short circuit 55811
    // loop increaments ++i >> 54576 i++>> 54611
    // cache array legth - deprecated
    // load array elements to memory 54417

    uint256 public total;
    //[1,2,3,4,5,100]
    // function sumIfEvenAndLessThan99(uint[] memory nums) external {
    //     for(uint i = 0; i< nums.length; i+=1){
    //         bool isEven = nums[i] % 2 == 0;
    //         bool isLessThan99 = nums[i] < 99;
    //         if(isEven && isLessThan99) {
    //             total += nums[i];
    //         }
    //     }
    // }

     function sumIfEvenAndLessThan99(uint[] calldata nums) external {
        uint _total = total;
        for(uint i = 0; i< nums.length; i++){
            uint num = nums[i];
            if(num % 2 == 0 && num < 99) {
                _total += num;
            }
        }
        total = _total;
    }
    
}