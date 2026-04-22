// 1. Definições Iniciais
var _player = asset_get_index("player"); // Confirma se o nome do teu objeto player é exatamente este
var _can_interact = !instance_exists(obj_dialog) && !(instance_exists(obj_statement_ui) && obj_statement_ui.statement_open);
var _is_visible = true;

// 2. Verificar Visibilidade (Itens de Missão)
if (item_type == "special") {
    if (item_id == "kite" && !global.quest_kite_started) _is_visible = false;
    if (item_id == "headset" && !global.quest_headset_started) _is_visible = false;
    if (item_id == "key" && !global.quest_key_started) _is_visible = false;
    if (item_id == "screwdriver" && !global.quest_screwdriver_started) _is_visible = false;    
}

if (!_is_visible) {
    can_collect = false;
    exit; 
}

// 3. Proximidade e Interação
if (instance_exists(_player) && _can_interact) {
    var _inst = instance_nearest(x, y, _player);
    can_collect = (distance_to_object(_inst) < 15);

    if (can_collect && keyboard_check_pressed(vk_space)) {
        if (instance_exists(obj_inventory)) {
            
            // Tenta adicionar ao inventário
            var _success = obj_inventory.inventory_add(item_sprite, 0, 1, item_type, item_id);
            
            if (_success) {
                    // Forçamos a conversão para string para garantir
                    var _id_para_salvar = string(manual_id);
                    
                    if (_id_para_salvar != "") {
                        if (!variable_global_exists("collected_items_list")) {
                           global.collected_items_list = ds_map_create();
                         }
                        global.collected_items_list[? _id_para_salvar] = true;
                        show_debug_message("SALVANDO ID: " + _id_para_salvar);
                    } else {
                          show_debug_message("ERRO: Tentou coletar, mas o manual_id está VAZIO!");
                      }
                
                // --- B) ATUALIZAR STATUS E CONTADORES ---
                if (item_type == "special") {
                    var _var_name = "has_" + item_id;
                    if (variable_global_exists(_var_name)) {
                        variable_global_set(_var_name, true);
                    }
                } 
                else if (item_type == "collectible") {
                    var _count_name = item_id + "_count";
                    if (variable_global_exists(_count_name)) {
                        var _current_val = variable_global_get(_count_name);
                        variable_global_set(_count_name, _current_val + 1);
                    }
                }

                // --- C) FEEDBACK E POPUPS ---
                with (obj_game_controller) {
                    if (variable_instance_exists(id, "mentor_warned_inventory_tip") && !mentor_warned_inventory_tip) {
                        mentor_warned_inventory_tip = true;
                        mentor_popup(global.dialog_mentor_inventory_tip);
                    }
                }
                
                show_debug_message("Item Coletado com Sucesso: " + manual_id);
                instance_destroy(); 
            }
        }
    }
} else {
    can_collect = false;
}