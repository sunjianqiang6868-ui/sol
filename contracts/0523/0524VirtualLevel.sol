// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;
// 多层继承关系

contract A {
    function foo() external pure virtual returns (string memory) {
        return "A_foo";
    }
    function barA() external pure returns (string memory) {
        return "A_barA";
    }
}

contract B is A {
    function foo() external pure virtual override returns (string memory) {
        return "B_foo";
    }
    function barB() external pure returns (string memory) {
        return "B_barB";
    }
}

contract C is A, B {
    function foo() external pure override(A, B) returns (string memory) {
        return "C_foo";
    }
}
