// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

// 合约调用

contract Caller {
    // 指定调用的合约地址
    function setX(Receiver _to, uint _x) external returns (uint256) {
        return _to.setX(_x);
    }

    // 调用getx address 转 Receiver 再调用
    function getX(address _to) external view returns (uint256 x) {
        x = Receiver(_to).getX();
    }

    // 发送ETH
    function setXAndSendEther(Receiver _to, uint256 _x) external payable {
        _to.setXAndSendEther{value: msg.value}(_x);
    }

    // 返回多个属性
    function getXAndEther(
        Receiver _to
    ) external view returns (uint256, uint256) {
        (uint256 _x, uint256 _value) = _to.getXAndEther();
        return (_x, _value);
    }
}
// 0xd9145CCE52D386f254917e481eB44e9943F39138
contract Receiver {
    uint256 public x;
    uint256 public value = 123;

    // 设置
    function setX(uint256 _x) external returns (uint256) {
        x = _x;
        return x;
    }

    // 获取
    function getX() external view returns (uint256) {
        return x;
    }

    // 设置+发送ETH
    function setXAndSendEther(uint256 _x) external payable {
        x = _x;
        value = msg.value;
    }

    // 获取多个属性
    function getXAndEther() external view returns (uint256, uint256) {
        return (x, value);
    }
}
