// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;
// Delegatecall 代理调用
//  (bool success, ) = _delegate.delegatecall(
//     abi.encodeWithSelector(A.setVar.selector, _num)
// )
// B 执行delegatecall 走Ad setVar 方法, 修改的B的全局变量

contract A {
    uint public num;
    address public sender;
    uint public value;

    function setVar(uint _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract B {
    uint public num;
    address public sender;
    uint public value;

    function setVar(address _delegate, uint _num) public payable {
        (bool success, ) = _delegate.delegatecall(
            abi.encodeWithSelector(A.setVar.selector, _num)
        );
        require(success, " delegatecall failed");
    }
}
