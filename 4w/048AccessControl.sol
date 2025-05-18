// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract AccessControl{
    // 赋予角色事件
    event GrantRole(bytes32 indexed role, address indexed account);
    // 取消角色事件
    event RevokeRole(bytes32 indexed role,address indexed account);

    // role-> accountAddr-> bool
    mapping (bytes32 => mapping (address => bool)) public roles;

    //0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    //0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));

    constructor() {
        _grantRole(ADMIN, msg.sender);
    }

    modifier onlyRole(bytes32 _role){
       require(roles[_role][msg.sender], "not authrized");
       _;
    }
    // 内部调用 赋予角色
    function _grantRole(bytes32 _role, address _account )internal{
        roles[_role][_account] = true;
        emit GrantRole(_role, _account);
    }

    // 外部调用赋予角色 增加只有管理员才能增加角色的权限修饰
    function grantRole(bytes32 _role,address _account) external onlyRole(ADMIN){
        _grantRole(_role, _account);
    }

    // 外部调研取消角色，增加只有管理员才能取消的权限修饰
    function revokeRole(bytes32 _role, address _account)external onlyRole(ADMIN){
        roles[_role][_account] = false;
        emit RevokeRole(_role, _account);
    }

}