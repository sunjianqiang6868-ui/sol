// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

// Solidity 合约数据分三大数据位置，最核心是 storage：
// storage
// 合约永久存储，存在区块链上，合约销毁前一直保留
// 消耗 Gas 最高，读写成本大
// 每个合约拥有独立存储空间，按「存储插槽（slot）」排列
// memory
// 临时内存，函数执行时存在，调用结束立即清空
// 仅用于函数内临时变量，无持久化
// calldata
// 只读，存放函数入参，外部调用传入的数据，不能修改

//---------------------------------------------
// 修饰符	调用范围
// public	外部账户、其他合约、本合约、子合约 都能调用
// external	仅外部账户 / 其他合约调用，本合约内部不能直接调用
// internal	本合约 + 继承的子合约 可调用；外部 / 其他合约无法调用
// private	仅当前合约内部可用；子合约、外部都不能用
//==============================================

// using 主要用于库绑定，给值类型 / 结构体挂载自定义方法，
// 语法：using 库名 for 类型;，搭配库（library）使用，日常开发、省代码、简化调用高频用到。
// 关键规则 & 限制
// 只能搭配 library 使用
// using 不能绑定普通合约，只能绑定库。
// 库函数可见性
// 绝大多数场景用 internal：内部调用、不生成外部函数、Gas 低。
// 参数位置
// 变量永远对应库函数第一个形参。
// 不能给地址 / 合约类型滥用扩展
// 语法允许，但工程上极少用，优先用于原生类型、结构体。
// 作用域
// 普通 using：仅当前合约有效
// using ... global：全局生效（高版本编译器）

library Match {
    function max(uint _x, uint _y) internal pure returns (uint) {
        return _x >= _y ? _x : _y;
    }
}

contract Test {
    function testMax(uint _x, uint _y) external pure returns (uint) {
        // 直接调用
        return Match.max(_x, _y);
    }
}

library ArrLib {
    function find(uint[] storage arr, uint _x) internal view returns (uint) {
        for (uint i; i <= arr.length - 1; i++) {
            if (arr[i] == _x) {
                return i;
            }
        }
        revert("not find");
    }
}

contract ArryTest {
    using ArrLib for uint[];

    uint[] public arr = [1, 2, 3, 4];

    function testFind(uint _x) external view returns (uint) {
        // 使用using
        return arr.find(_x);
    }
}
