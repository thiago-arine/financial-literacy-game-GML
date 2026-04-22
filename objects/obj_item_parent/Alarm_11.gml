// 1. Verificar se o ID manual foi preenchido na Room
if (manual_id == "") {
    show_debug_message("AVISO: Item em " + string(x) + "," + string(y) + " está sem manual_id!");
    exit;
}

// Debug para acompanhar no console
show_debug_message("Checando persistência para: " + manual_id);

// 2. Verificar se este ID já consta na lista global de coletados
if (variable_global_exists("collected_items_list")) {
    if (ds_map_exists(global.collected_items_list, manual_id)) {
        show_debug_message("Item " + manual_id + " já foi coletado. Removendo da sala.");
        instance_destroy();
        exit;
    }
}

// 3. Lógica extra para itens de missão (Special)
// Se o jogador já possui o item ou já terminou a quest, o item não deve aparecer
if (item_type == "special") {
    var _has_var = "has_" + item_id;
    if (variable_global_exists(_has_var)) {
        if (variable_global_get(_has_var) == true) {
            instance_destroy();
        }
    }
}