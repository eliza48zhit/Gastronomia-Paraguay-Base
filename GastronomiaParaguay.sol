// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title GastronomiaParaguay
 * @dev Registro historico con Likes, Dislikes e Identificador de Tipo de Harina.
 */
contract GastronomiaParaguay {

    struct Plato {
        string nombre;
        string descripcion;
        string tipoHarina; // Ej: Harina de Maiz, Almidon de Mandioca, Mezcla
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public menuHistorico;
    uint256 public totalPlatos;

    constructor() {
        // Inauguramos con la Sopa Paraguaya (Sopa Solida)
        registrarPlato(
            "Sopa Paraguaya", 
            "Bizcocho salado de harina de maiz, queso paraguay, cebolla y leche.",
            "Harina de Maiz"
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _descripcion, 
        string memory _tipoHarina
    ) public {
        require(bytes(_nombre).length + bytes(_descripcion).length <= 200, "Texto demasiado largo");
        
        totalPlatos++;
        menuHistorico[totalPlatos] = Plato({
            nombre: _nombre, 
            descripcion: _descripcion,
            tipoHarina: _tipoHarina,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre, 
        string memory descripcion, 
        string memory tipoHarina,
        uint256 likes, 
        uint256 dislikes
    ) {
        require(_id > 0 && _id <= totalPlatos, "ID invalido.");
        Plato storage p = menuHistorico[_id];
        return (p.nombre, p.descripcion, p.tipoHarina, p.likes, p.dislikes);
    }
}
