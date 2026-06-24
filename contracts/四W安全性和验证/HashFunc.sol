// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

// abi.encode：标准安全编码，带长度与对齐，防碰撞，适合调用、验签；
// abi.encodePacked：紧凑精简编码，无填充、省 Gas，但多参数易哈希碰撞，适合简单哈希、插槽计算。

contract HashFunc {
    function hash(
        string memory text,
        uint num,
        address addr
    ) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(text, num, addr));
    }

    // 哈希碰撞风险 低
    function encode(
        string memory text1,
        string memory text2
    ) external pure returns (bytes32) {
        return keccak256(abi.encode(text1, text2));
    }

    // 哈希碰撞风险 高
    // hash 碰撞 用例 "AAA"+"BBB" ="AA"+"ABBB"
    function encodePacked(
        string memory text1,
        string memory text2
    ) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(text1, text2));
    }

    // 中间拼接参数 防止hash冲突
    function encodePacked2(
        string memory text1,
        uint num,
        string memory text2
    ) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(text1, num, text2));
    }
}
