var _player = asset_get_index("player");
var _can_interact = !instance_exists(obj_dialog) && !(instance_exists(obj_statement_ui) && obj_statement_ui.statement_open);
var _is_visible = true;

// Verificar se é um item de missão e se a missão correspondente começou
if (item_type == "special") {
    if (item_id == "kite" && !global.quest_kite_started) _is_visible = false;
    if (item_id == "headset" && !global.quest_headset_started) _is_visible = false;
    if (item_id == "key" && !global.quest_key_started) _is_visible = false;
    
    
    if (item_id == "key" && !global.quest_key_started) _is_visible = false;
    if (item_id == "headset" && !global.quest_headset_started) _is_visible = false;
    if (item_id == "kite" && !global.quest_kite_started) _is_visible = false;
    if (item_id == "screwdriver" && !global.quest_screwdriver_started) _is_visible = false;    
}

// Se a missão não começou, o item não deve ser processado
if (!_is_visible) {
    can_collect = false;
    exit; 
}

if (instance_exists(_player) && _can_interact) {
    var _inst = instance_find(_player, 0);
    var _dist = distance_to_object(_inst);
    can_collect = (_dist < 20);

    if (can_collect && keyboard_check_pressed(vk_space)) {
        if (instance_exists(obj_inventory)) {
            
            var _success = obj_inventory.inventory_add(item_sprite, 0, 1, item_type, item_id);
            
            if (_success) {
                
                // --- Popup diálogo item ---
                with (obj_game_controller) {
                    if (!mentor_warned_inventory_tip) {
                        mentor_warned_inventory_tip = true;
                        mentor_popup(global.dialog_mentor_inventory_tip);
                    }
                }
                
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
                
                show_debug_message("ID Coletado: " + item_id + " | Nome: " + item_display_name);
                instance_destroy();
            }
        }
    }
} else {
    can_collect = false;
}