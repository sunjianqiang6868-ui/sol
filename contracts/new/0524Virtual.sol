// SPDX-License-Identifier: MIT
//  B is A B继承A的所有方法

// virtual 关键字
// 用于继承
// 允许子合约重写函数
// 必须配合 override 使用
pragma solidity 0.8.23;
contract A {
    function foo() external pure virtual returns (string memory) {
        return "A_foo";
    }
    function bar() external pure returns (string memory) {
        return "A_bar";
    }
}
contract B is A {
    function foo() external pure override returns (string memory) {
        return "B_foo";
    }
}
