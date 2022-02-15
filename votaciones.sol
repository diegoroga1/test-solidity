pragma solidity >=0.4.4 <0.7.1;
pragma experimental ABIEncoderV2;

contract votacion{
    //Direccion del propietario del contrato
    address public owner;

    //constructor
    constructor() public{
        owner = msg.sender;
    }

    // relacion entre el nombre del candidato y el hash de sus datos

    mapping (string=>bytes32) ID_Candidato;

    // Relacion entre el nombre del candidato y el nº de votos

    mapping (string=>uint) votos_candidato;

    //Listar los nombres de los candidatos

    string [] candidatos;

    //Lista de los hashed de la identidad de los votantes

    bytes32 [] votantes;
    

    function Representar(string memory _nombrePersona, uint _edadPersona, string memory _idPersona) public{

        // Calcular el Hash de los datos del candidato
        bytes32 hash_candidato = keccak256(abi.encodePacked(_nombrePersona,_edadPersona,_idPersona));

    }

}