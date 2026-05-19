// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
contract IterableMapping {
    mapping(address => uint) public balances;
    mapping(address => bool) public inserted;
    address[] public addressList;

    // 插入地址
    function insert(address _address, uint _amount) public {
        if (!inserted[_address]) {
            inserted[_address] = true;
            addressList.push(_address);
        }
        balances[_address] = _amount;
    }
    // 获取地址列表的长度
    function getSize() public view returns (uint) {
        return addressList.length;
    }
    // 获取下标指定地址
    function getAddress(uint _index) public view returns (address) {
        return addressList[_index];
    }

    // 获取下标指定地址的余额
    function getAmount(uint _index) public view returns (uint) {
        return balances[addressList[_index]];
    }
}
