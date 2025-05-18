// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract HashFunc {
    function hash(
        string memory text,
        uint256 num,
        address addr
    ) external pure returns (bytes32) {
        // abi.encodePacked返回的是一个压缩的bytes
        return keccak256(abi.encodePacked(text, num, addr));
    }

    function encode(string memory text0, string memory text1)
        external
        pure
        returns (bytes memory)
    {
        // 返回是一个完整的bytes
        return abi.encode(text0, text1);
    }

     // encodePacked 传入参数“AAAA","BBB" 和传入参数”AAA“,"ABBB"加密结果一样
    function encodePacked(string memory text0, string memory text1)
        external
        pure
        returns (bytes memory)
    {
        return abi.encodePacked(text0, text1);
    }

    function collision(
        string memory text0,
        uint256 x,
        string memory text1
    ) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(text0, x, text1));
    }
}
