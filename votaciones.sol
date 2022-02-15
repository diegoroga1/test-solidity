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

        // Almacenamos el hash de los datos del candidato ligados a su nombre
        ID_Candidato[_nombrePersona] = hash_candidato;

        // Actualizar el array de candidatos con el nombre del candidato
        candidatos.push(_nombrePersona);

    }
    // funcion que devuelve los candidatos
    function VerCandidatos() public view returns(string[] memory){
        return candidatos;
    }

    // Los votantes podrán votar candidatos
    function Votar(string memory _candidato) public{
        // calculamos el hash de la persona que ejecutar esta funcion Votar (votante)
        bytes32 hashVotante = keccak256(abi.encodePacked(msg.sender));
        // verificamos si el votante ya ha votado
        for(uint i = 0 ;i<votantes.length; i++){
            require(votantes[i]!=hashVotante,"Ya has votado previamente.");
        }
        votantes.push(hashVotante);
        votos_candidato[_candidato]++;
    }
    //funcion para ver los votos de un candidato
    function VerVotos(string memory _candidato) public view returns(uint){
        return votos_candidato[_candidato];
    }

    //funcion para ver los resultados de las votaciones
    function VerResultados() public view returns(string memory){
        // Guardamos candidatos con los votos
        string memory resultados;
        for(uint i = 0 ;i<candidatos.length; i++){
          //resultados = string(abi.encodePacked(resultados,"------ (",candidatos[i],", ",uint2str(VerVotos(candidatos[i])),") -----"));
          resultados = string(abi.encodePacked(resultados,"------ (",candidatos[i],", ",uint2str(votos_candidato[candidatos[i]]),") -----"));
        }
        return resultados;
    }
    // Devolver el ganador segun numero de votos
    function Ganador() public view returns(string memory){
        // variable donde guardaremos el ganador para devolverlo
        string memory ganador=candidatos[0];
        bool flag;
        for(uint i = 1; i < candidatos.length;i++){
            if(votos_candidato[candidatos[i]]>votos_candidato[ganador]){
                ganador = candidatos[i];
                flag=false;
            }else{
                if(votos_candidato[ganador]==votos_candidato[candidatos[i]]){
                  flag=true;  
                }
            }
        }
        if(flag){
            ganador = "!Hay un empate entre los candidatos!";
        }
        return ganador;
    }

    // funcion que pasa un entero a string
    function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;
        while (_i != 0) {
            bstr[k--] = byte(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);
    }

}