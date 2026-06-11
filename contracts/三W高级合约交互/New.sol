// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

contract Account {
    address public bank;
    address public owner;
    constructor(address _owner) {
        owner = _owner;
        bank = msg.sender;
    }
}

contract AccnountFactory {
    Account[] public accounts;

    function createAccount(address _owner) external payable {
        Account newAccount = new Account(_owner);
        accounts.push(newAccount);
    }
}
