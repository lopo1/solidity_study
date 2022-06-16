// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
/**
0. message to sign
1. hash(message)
2. sign(hash(message),private key) | offchain
3. ecrecover(hash(message),signature) == signer
 */
 /**
web3 
1. ethereum.enable()
2. set account = "metamask address" // eg: account = "0x796fa99985003Bb3868E15bb5A9e5C9BE19E4F21"
3. set hash = "getMessageHash("secret message")" // eg: hash = "0x9c97d796ed69b7e69790ae723f51163056db3d55a7a6a82065780460162d4812"
4. _sig = ethereum.request({method:"personal_sign",params:[account,hash]})
5. verify(account,"secret message",_sig)
 */

 contract VerifySig{
     struct MyStruct{
        string name;
        uint[2] nums;
    }
     function verify(address _signer,MyStruct calldata _message,bytes memory _sig) external pure returns(bool){
         bytes32 messageHash = getMessageHash(_message);
         bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);
         return recover(ethSignedMessageHash,_sig) == _signer;
     }

     function getMessageHash(MyStruct calldata _message) public pure returns(bytes32){
         return keccak256(abi.encodePacked(_message.name,_message.nums));
     }
     function getEthSignedMessageHash(bytes32 _messageHash) public pure returns(bytes32){
         return keccak256(abi.encodePacked(
             "\x19Ethereum Signed Message:\n32",
             _messageHash
             ));
     }

     function recover(bytes32 _ethSignedMessageHash,bytes memory _sig) public pure returns(address){
         (bytes32 r,bytes32 s,uint8 v) = _spit(_sig);
         return ecrecover(_ethSignedMessageHash, v, r, s);
     }

     function _spit(bytes memory _sig) internal pure returns(bytes32 r,bytes32 s,uint8 v){
         require(_sig.length==65,"invalid signature length");
         assembly{
             r:=mload(add(_sig,32))
             s:=mload(add(_sig,64))
             v:=byte(0,mload(add(_sig,96)))
         }
     }
     function decode(bytes calldata data) external pure returns(string memory x){
       (x) =  abi.decode(data,(string));
    }
     
 }