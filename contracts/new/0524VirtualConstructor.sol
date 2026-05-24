// SPDX-License-Identifier: MIT

// 继承-调用父类的构造函数 ,以及它们的执行顺序
pragma solidity 0.8.23;

contract P {
    event Log(string message);
}
contract D is P {
    constructor() {
        emit Log("this is D"); // unicode
    }
}
contract E is D {
    string public name;
    constructor(string memory _name) {
        emit Log("this is E; name= "); // unicode
        emit Log(_name);
        name = _name;
    }
}
contract G is P {
    constructor() {
        emit Log("this is G"); // unicode
    }
}

// NO.1
contract F is D, E("abc") {
    string public text;
    constructor(string memory _text) D() {
        emit Log("this is F");
        text = _text;
    }
}

// NO.2 继承是有顺序的
// FV2 是 D, E 顺序 → 符合线性化规则 ✅
// FV2 是 E, D 顺序 → 破坏了线性化规则 ❌
contract FV2 is D, E {
    string public text;
    constructor(string memory _name, string memory _text) D() E(_name) {
        emit Log("this is FV2");
        text = _text;
    }
}

// NO.3 继承顺序决定 构造函数初始化顺序
contract FV3 is E, G {
    string public text;
    constructor(string memory _name, string memory _text) G() E(_name) {
        emit Log("this is FV3");
        text = _text;
    }
}

contract FV4 is G, E {
    string public text;
    constructor(string memory _name, string memory _text) G() E(_name) {
        emit Log("this is FV4");
        text = _text;
    }
}
