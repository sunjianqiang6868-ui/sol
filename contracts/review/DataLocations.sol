// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

// storage
// memory
// calldata
contract DataLoactions {
    struct MyStruct {
        uint foo;
        string text;
    }

    mapping(address => MyStruct) myStructs;

    function examples() external returns (uint) {
        myStructs[msg.sender] = MyStruct({foo: 123, text: "bar"});
        
        MyStruct storage mystruct = myStructs[msg.sender];
        mystruct.text = "foo";



        return myStructs[msg.sender].foo;
    }
}
