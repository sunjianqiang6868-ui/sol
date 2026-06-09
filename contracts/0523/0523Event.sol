// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;
contract Event {
    event Log(string message, uint val);
    event IndexedLog(address indexed sender, uint val);

    function example(string calldata _message, uint _val) external {
        emit Log(_message, _val);
        emit IndexedLog(msg.sender, _val);
    }

    event Message(address indexed _from, address indexed _to, string _val);

    function sendMsg(address _to, string calldata _message) external {
        emit Message(msg.sender, _to, _message);
    }
}
