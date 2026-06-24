// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;
// 权限控制

contract AccessControl {
    event GrantRole(address account, bytes32 role);
    event RevokeRole(address account, bytes32 role);

    // 权限映射表
    mapping(bytes32 => mapping(address => bool)) public roles;

    // 角色
    // 0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    // 0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));

    // 角色映射
    mapping(string => bytes32) public roleMapping;

    // 装饰器
    modifier onlyRole(bytes32 _role) {
        require(roles[_role][msg.sender], "not authorized");
        _;
    }

    // 初始管理角色
    constructor() {
        roleMapping["admin"] = ADMIN;
        roleMapping["user"] = USER;

        _grantRole(ADMIN, msg.sender);
    }

    // 给角色赋权
    function _grantRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = true;
        emit GrantRole(_account, _role);
    }

    // 赋权
    function grantRole(
        bytes32 _role,
        address _account
    ) external onlyRole(ADMIN) {
        _grantRole(_role, _account);
    }

    // 撤销角色权限
    function revokeRole(
        bytes32 _role,
        address _account
    ) external onlyRole(ADMIN) {
        roles[_role][_account] = false;
        emit RevokeRole(_account, _role);
    }

    function getRoleBytes32(
        string memory _role
    ) external view returns (bytes32) {
        return roleMapping[_role];
    }

}
