// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
contract AbiDecode{
    struct MyStruct{
        string name;
        uint[2] nums;
    }
    /**
    x: 1
    addr: "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4"
    arr: [2,3,4]
    myStruct: ["solidity",[1,2]]
     */
    function encode(uint x,address addr,uint[] calldata arr,MyStruct calldata myStruct) external pure returns(bytes memory){
        return abi.encode(x,addr,arr,myStruct);
    }
    function decode(bytes calldata data) external pure returns(uint x,address addr,uint[] memory arr,MyStruct memory myStruct){
       (x,addr,arr,myStruct) =  abi.decode(data,(uint,address,uint[],MyStruct));
    }
}