// SPDX-License-Identifier: MIT
pragma solidity >= 0.4.4 <0.9.0;
pragma experimental ABIEncoderV2;

contract notas {
    // Direccion del profesor (El que ejecuta el contrato)
    address public profesorDir;

    // constructor
    constructor()  {
        profesorDir = msg.sender; 
    }

    // mapping para relacionar el hash del alumno(dir del usuario) con su nota
    mapping(bytes32=>uint) Notas;

    // array de los alumnos que pidan revisiones
     string [] revisiones;

     // eventos
     event alumno_evaluado(bytes32);
     event evento_revision(string);

    modifier UnicamenteProfesor(address _dir){
        require(_dir == profesorDir,"No tiene permiso para votas");
        _;
    }
     function Evaluar(string memory _idAlumno, uint _nota) public UnicamenteProfesor(msg.sender){
         bytes32 hash_alumno=keccak256(abi.encodePacked(_idAlumno));
         Notas[hash_alumno] = _nota;
         emit alumno_evaluado(hash_alumno);
     }

     function VerNotas(string memory _idAlumno) public view returns(uint){
        bytes32 hash_alumno=keccak256(abi.encodePacked(_idAlumno));
        return Notas[hash_alumno];
     }
     function Revision(string memory _idAlumno) public {
         revisiones.push(_idAlumno);
         emit evento_revision(_idAlumno);
     }
     function VerRevisiones() public view UnicamenteProfesor(msg.sender) returns(string[] memory){
         return revisiones;

     }


}

