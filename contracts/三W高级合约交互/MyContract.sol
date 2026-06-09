// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

// 通过结构调用其他合约

interface ITestCounter {
    function count() external view returns (uint);
    function increment() external;
}

contract MyContract {
    // get
    function getCount(ITestCounter _target) external view returns (uint) {
        return _target.count();
    }

    // increment
    function toIncrement(address _target) external {
        ITestCounter(_target).increment();
    }
}
