var _name_to_find = "player";
var _player_asset = asset_get_index(_name_to_find);
var _can_interact = !instance_exists(obj_dialog) && !(instance_exists(obj_statement_ui) && obj_statement_ui.statement_open);

if (_player_asset == -1) {
    show_debug_message("ERRO: O objeto " + _name_to_find + " não foi encontrado no projeto!");
}

if (instance_exists(_player_asset) && _can_interact) {
    var _inst = instance_find(_player_asset, 0);
    var _dist = distance_to_object(_inst);
    
    // Define se o ícone deve aparecer (raio de 20 pixels) 
    can_collect = (_dist < 20); 

    if (can_collect && keyboard_check_pressed(vk_space)) {

        if (instance_exists(obj_inventory)) {
            // Tenta adicionar
            var _success = obj_inventory.inventory_add(spr_item_key, 0, 1, "special", "Chave");
            
            if (_success) {
                global.has_key = true;
                instance_destroy();
            } else {
                show_debug_message("AVISO: inventory_add retornou FALSE (Matriz cheia?)");
            }
        } else {
            show_debug_message("ERRO CRÍTICO: obj_inventory_ui não existe nesta Room!");
        }
    }
} else {
    can_collect = false;
}