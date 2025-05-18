// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract X {
    function foo() public pure virtual returns(string memory){
        return "x";
    }
    function bar() public pure virtual returns(string memory){
        return "x";
    }
    //more code here
    function x() public pure returns(string memory){
        return "x";
    }
}
contract Y is X {
    
    function foo() public pure virtual override  returns(string memory){
        return "Y";
    }
    function bar() public pure virtual override returns(string memory){
        return "Y";
    }

    //more code here
    function y() public pure returns(string memory){
        return "y";
    }

}
contract Z is X, Y {
    function foo() public pure virtual override(X,Y)  returns(string memory){
        return "z";
    }
    function bar() public pure virtual override(X,Y) returns(string memory){
        return "z";
    }
}