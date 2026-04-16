var _player = asset_get_index("player");
var _can_interact = !instance_exists(obj_dialog) && !(instance_exists(obj_statement_ui) && obj_statement_ui.statement_open);

if (instance_exists(_player) && _can_interact) {
    var _dist = distance_to_object(instance_find(_player, 0));
    can_collect = (_dist < 20);

    if (can_collect && keyboard_check_pressed(vk_space)) {
        if (instance_exists(obj_inventory)) {
            
            var _success = obj_inventory.inventory_add(item_sprite, 0, 1, item_type, item_name);
            
            if (_success) {
                // --- LÓGICA DINÂMICA ---
                
                // 1. Se for item de missão, ativa a flag global "has_NomeDoItem"
                if (item_type == "special") {
                    // Transforma "Chave Inglesa" em "has_chave_inglesa"
                    var _var_name = "has_" + string_replace_all(string_lower(item_name), " ", "_");
                    
                    if (variable_global_exists(_var_name)) {
                        variable_global_set(_var_name, true);
                    }
                } 
                
                // 2. Se for coletável, incrementa o contador específico "NomeDoItem_count"
                else if (item_type == "collectible") {
                    // Transforma "Chave Inglesa" em "chave_inglesa_count"
                    var _count_name = string_replace_all(string_lower(item_name), " ", "_") + "_count";
                    
                    if (variable_global_exists(_count_name)) {
                        var _current_val = variable_global_get(_count_name);
                        variable_global_set(_count_name, _current_val + 1);
                    }
                }
                
                show_debug_message("Coletado: " + item_name);
                instance_destroy();
            }
        }
    }
} else {
    can_collect = false;
}