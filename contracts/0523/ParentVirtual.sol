// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;
// 调用父级方法

//     E
//     /\
//    F  G
//     \/
//     H

contract E {
    event Log(string message);
    function foo() public virtual {
        emit Log("E.foo");
    }

    function bar() public virtual {
        emit Log("E.bar");
    }
}

// 继承 E 重写两个方法
contract F is E {
    function foo() public virtual override {
        emit Log("F.foo");
        E.foo();
    }

    function bar() public virtual override {
        emit Log("F.bar");
        super.bar();
    }
}

// 继承 E 重写两个方法
contract G is E {
    function foo() public virtual override {
        emit Log("G.foo");
        E.foo();
    }

    function bar() public virtual override {
        emit Log("G.bar");
        super.bar();
    }
}

// 继承 E 重写两个方法
contract H is F, G {
    function foo() public override(F, G) {
        emit Log("H.foo");
        F.foo();
    }

    function bar() public override(F, G) {
        emit Log("H.bar");
        super.bar();
    }
}
