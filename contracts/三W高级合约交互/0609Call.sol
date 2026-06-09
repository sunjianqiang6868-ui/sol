// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

contract TestCall {
    string public message;
    uint public x;

    event Log(address sender, uint256 amount, string message);

    receive() external payable {}

    fallback() external payable {
        emit Log(msg.sender, msg.value, "fallback was called");
    }

    function foo(
        uint256 _x,
        string memory _message
    ) external payable returns (bool, uint) {
        // emit Log(msg.sender, msg.value, "seccess ");
        x = _x;
        message = _message;
        return (true, 1);
    }
}

contract Call {
    bytes public i;

    // 调用给足ETH
    function callFoo(address _target) external payable {
        // {value: 111}  合约必须存在数据
        (bool b, bytes memory _i) = _target.call{value: 111}(
            abi.encodeWithSignature("foo(uint256,string)", 123, "call foo")
        );
        require(b, "call foo failed");
        i = _i;
    }

    // 调用不存在的方法 会调用 fallback 
    function callNotExist(address _target) external {
        (bool b, ) = _target.call(abi.encodeWithSignature("callNotExist()"));
        require(b, "call foo failed");
    }
}
