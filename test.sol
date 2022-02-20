// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 <0.9.0;
pragma experimental ABIEncoderV2;
contract Usuario{
    
    address owner;
 
    function calcularHash(string memory _cadena) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_cadena));
    }
    function calcularHash2(string memory _cadena,uint _k,address _direccion) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_cadena,_k,_direccion));
    }
    function MsgSender() public view returns(address){
        return msg.sender;
    }
    function Now() public view returns(uint){
        return block.timestamp;
    }
    function BlockCoinbase() public view returns(address){
        return block.coinbase;
    }

    function BlockDifficulty() public view returns(uint){
        return block.difficulty;
    }

    function BlockNumber() public view returns(uint){
        return block.number;
    }
}