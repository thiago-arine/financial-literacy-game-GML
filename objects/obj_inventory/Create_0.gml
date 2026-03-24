inventory_open = false;
invMaxX = 6;
invMaxY = 3;

inv = array_create(invMaxX);
for(var i=0; i<invMaxX; i++){
    inv[i] = array_create(invMaxY, -1);
}

//Função para adicionar itens na matriz do inventário
function inventory_add(_sprite, _index, _amount, _type, _name) {
    //Varre a matriz em busca de um espaço vazio (-1)
    for (var j = 0; j < invMaxY; j++) {
        for (var i = 0; i < invMaxX; i++) {
            if (inv[i][j] == -1) {
                //Armazena o array com as informações do item no slot encontrado
                inv[i][j] = [_sprite, _index, _amount, _type, _name];
                return true; //Sucesso: item guardado e loop encerrado
            }
        }
    }
    return false; //Inventário cheio: nenhum slot -1 encontrado
}