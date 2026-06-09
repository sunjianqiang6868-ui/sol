// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;
// 可以支付ETH
contract Payable {
    // 可以
    address payable public owner;
    constructor() {
        // 转为 payable
        owner = payable(msg.sender);
    }

    // 支付
    function deposit() external payable {}

    // 查询
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
