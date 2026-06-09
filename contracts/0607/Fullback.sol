// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

// receive = 只收钱，不调用函数
// fallback = 调用函数，但找不到

// receive()：专门收 ETH 的函数（无数据、纯转账）
// fallback()：兜底函数（调用了不存在的方法 或 发 ETH 带数据）

// 1. receive()满足 2 个条件就触发：
// 向合约转 ETH
// 不带任何数据（空 data）

// 2. fallback()满足任一条件就触发：
// 调用了合约里没有的函数
// 转 ETH 带了数据

// ✅ receive()
// 必须：external payable
// 不能有：function 关键字、参数、返回值
// 一个合约最多 1 个
// ✅ fallback()
// 必须：external
// 可加：payable（能收钱）
// 一个合约最多 1 个

contract Fallback {
    event Log(string func, address sender, uint val, bytes data);

    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value, msg.data);
    }

    receive() external payable {
        emit Log("receive", msg.sender, msg.value, "");
    }

    // 调用存在的函数哪个都不触发
    function deposit() external payable {}
}
