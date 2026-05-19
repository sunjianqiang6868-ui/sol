// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "hardhat/console.sol";

contract Mapping {
    mapping(address => uint) public myMap;
    mapping(address => mapping(address => bool)) public myMap2;

    function update(uint _newNumber) public {
        // 设置值
        myMap[msg.sender] = _newNumber;
        uint myMapVal = myMap[msg.sender];
        console.log("myMapVal =", myMapVal);

        delete myMap[msg.sender];
        uint myMapValNew = myMap[msg.sender];
        console.log("myMapValNew =", myMapValNew);
    }
}
