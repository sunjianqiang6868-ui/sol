// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;
contract Immutable {
    address public owner;
    uint public x;

    // 构造函数：只能在这里赋值一次
    constructor() {
        owner = msg.sender;
    }
    function foo() external {
        require(msg.sender == owner);
        x += 1;
    }
}
