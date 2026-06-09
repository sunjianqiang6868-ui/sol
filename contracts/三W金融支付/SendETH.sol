// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

// ✅ 现在行业标准：只用 call
// ❌ transfer 和 send 基本废弃了

// 方法	转账失败	传递 Gas	安全性	现在还能用吗
// transfer	自动回滚	固定 2300	低	❌ 不推荐
// send	返回 bool	固定 2300	低	❌ 不推荐
// call	返回 bool	传递 所有 Gas	高	✅ 强烈推荐


// 你用这三个方法转钱时：
// transfer / send → 只带 2300 gas → 触发 receive()
// call → 带所有 gas → 触发 receive() 或 fallback()



// 发送者
contract SendEther {
    // 构造函数
    constructor() payable {}

    receive() external payable { }

    // transfer
    function sendViaTransfer(address payable _to) external payable {
        _to.transfer(123);
    }

    // send 不常用
    function sendViaSend(address payable _to) external payable {
        bool send = _to.send(123);
        require(send, "send failed");
    }

    // call
    function sendViaCall(address payable _to) external payable {
        (bool success, ) = _to.call{value: 123}("");
        require(success, "send failed");
    }
}

// 接收者
contract EthReciver {
    event Log(address sender, uint amount, uint gas);

    receive() external payable {
        emit Log(msg.sender, msg.value, gasleft());
    }
}
