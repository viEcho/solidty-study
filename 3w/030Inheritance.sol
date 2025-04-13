// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract A{

    function foo() public virtual returns (string memory){
        return "A";
    }

    function bar() public pure virtual returns (string memory){
        return "A";
    }
     
   
}

contract B is A{
    function foo() public pure override  returns (string memory){
        return "B";
    }

    function bar()  public pure virtual   override  returns (string memory){
        return "B";
    }

}


contract C is B{
    function bar() public pure override returns (string memory){
        return "C";
    }
}

