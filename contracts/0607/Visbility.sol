// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

// 可见性-关键字-
// privite  合约内部-作用范围函数和变量
// internal 合约内部和子合约-作用范围函数和变量
// public   合约内部外部-作用范围函数和变量
// external 只语序外部调用-作用范围函数

// history
// pure => 适用场景=纯计算、工具函数
// view => 适用场景=状态查询、只读视图
// payable => 适用场景=唯一能接收 ETH 的修饰符,可以改状态、读状态

contract Base {
    uint private x = 1;
    uint public y = 2;
    uint internal z = 3;

    function privFun() private pure returns (uint) {
        return 100;
    }
    function pubFun() public pure returns (uint) {
        return 200;
    }
    function interFun() internal pure returns (uint) {
        return 300;
    }
    function exterFun() external pure returns (uint) {
        return 400;
    }

    function examples() external view {
        //变量可在本合约内调用
        x + y + x;
        privFun();
        pubFun();
        interFun();
        // external 只允许外部调用
        // exterFun();
    }
}

contract Child is Base {
    function examples2() external view {
        y + z;
        // private 只允许内部调用
        // privFun();
        pubFun();
        interFun();
        // external 只允许外部调用
        // exterFun();
    }
}
