// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

// 验证签名

// 调用 getMessageHash 获取消息的hash结果 = 0x9c97d796ed69b7e69790ae723f51163056db3d55a7a6a82065780460162d4812
// 登录小狐狸签镖
// F12 控制台 ethereum.enable() => log  [[PromiseState]]:"fulfilled"
// account = "0x24D4EeB6b95a525EE53C0d00173bD03f3677af3f" (小狐狸 账户)
// hash ="0x9c97d796ed69b7e69790ae723f51163056db3d55a7a6a82065780460162d4812" (getMessageHash 结果)
// ethereum.request({method:"personal_sign",params:[account,hash]}) (发送请求,调用personal_sign方法,弹出小狐狸前名页面)
// 点击 sign 获取结果:
//Promise {<pending>}[[Prototype]]: Promisecatch: ƒ catch()constructor: ƒ Promise()finally: ƒ finally()then: ƒ then()Symbol(Symbol.toStringTag): "Promise"[[Prototype]]: Object[[PromiseState]]: "fulfilled"
//[[PromiseResult]]: "0xae470526ff995165cb3a42a261f7c5a583ff69bc5ca533df00c792dc1817e38620f54209a5c0a0a4899cd27da0ed9c3b820c6d52da810499b6460f325ea648621c"


contract VerifySig {
    function verify(
        address _signer,
        string memory _message,
        bytes memory _sig
    ) external pure returns (bool) {
        //1. message Hash
        bytes32 messageHash = getMessageHash(_message);

        //2.
        bytes32 ethSingedMessageHash = getEthSignedMessage(messageHash);

        //3.
        return recover(ethSingedMessageHash, _sig) == _signer;
    }

    // 1. return  0x9c97d796ed69b7e69790ae723f51163056db3d55a7a6a82065780460162d4812
    function getMessageHash(
        string memory _message
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_message));
    }

    // 2.return  0x95a786464acc06fafc0d46036515722ec35acb840ecc291f251e086ebfeb9099
    function getEthSignedMessage(
        bytes32 messageHash
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", messageHash));
    }

    // 3.return  0x24D4EeB6b95a525EE53C0d00173bD03f3677af3f
    function recover(
        bytes32 ethSingedMessageHash,
        bytes memory _sig
    ) public pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
        return ecrecover(ethSingedMessageHash, v, r, s);
    }

    function _split(
        bytes memory _sig
    ) internal pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(_sig.length == 65, " invalid signatrue length");
        assembly {
            r := mload(add(_sig, 32))
            s := mload(add(_sig, 64))
            v := byte(0, mload(add(_sig, 96)))
        }
    }
}
