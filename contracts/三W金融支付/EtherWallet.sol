// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

contract EtherWallet {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {}

    // 提现到钱包
    function withdraw(uint _amount) external payable {
        require(msg.sender == owner, " caller is not owner");
        payable(msg.sender).transfer(_amount);
    }

    // 查余额
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
