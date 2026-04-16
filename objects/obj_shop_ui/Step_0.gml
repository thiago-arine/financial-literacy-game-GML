var _up    = keyboard_check_pressed(vk_up)    || keyboard_check_pressed(ord("W"));
var _down  = keyboard_check_pressed(vk_down)  || keyboard_check_pressed(ord("S"));
var _exit  = keyboard_check_pressed(vk_escape)  || keyboard_check_pressed(ord("Q"));
var _buy   = keyboard_check_pressed(vk_space)   || keyboard_check_pressed(vk_enter); 
var _right = keyboard_check_pressed(vk_right)   || keyboard_check_pressed(ord("D")); 
var _left  = keyboard_check_pressed(vk_left)    || keyboard_check_pressed(ord("A"));  
    
if (_left)  { menu_mode = 0; selected = 0; }
if (_right) { menu_mode = 1; selected = 0; }

// Atualizar lista de venda se estiver no modo de venda
if (menu_mode == 1) {
    sell_items = [];
    if (instance_exists(obj_inventory)) {
        for (var j = 0; j < obj_inventory.invMaxY; j++) {
            for (var i = 0; i < obj_inventory.invMaxX; i++) {
                var _slot = obj_inventory.inv[i][j];
                if (is_array(_slot)) {
                    array_push(sell_items, { info: _slot, grid_x: i, grid_y: j });
                }
            }
        }
    }
}

var _total = (menu_mode == 0) ? array_length(shop_items) : array_length(sell_items);

if (_total > 0) {
    if (_up)   selected--; 
    if (_down) selected++;
    if (selected < 0) selected = _total - 1;
    if (selected >= _total) selected = 0;
} else {
    selected = 0;
}

if (_buy && _total > 0) {
    if (menu_mode == 0) {
        // --- LÓGICA DE COMPRA ---
        var _shop_entry = shop_items[selected];
        var _item_data = get_item_data(_shop_entry.id); // Puxa os dados (sprite, nome, etc) do Script
        
        if (global.balance >= _shop_entry.price) {
            // Adicionamos ao inventário usando o ID técnico (em inglês)
            var _success = obj_inventory.inventory_add(_item_data.sprite, 0, 1, _item_data.type, _shop_entry.id);
            
            if (_success) {
                global.balance -= _shop_entry.price;
                update_statement("Compra: " + _item_data.name, _shop_entry.price, "loss");
                
                // Ativa a flag global se o item for especial
                var _global_var = "has_" + _shop_entry.id;
                if (variable_global_exists(_global_var)) {
                    variable_global_set(_global_var, true);
                }
            }
        }
    } else {
        // --- LÓGICA DE VENDA ---
        var _sell_data = sell_items[selected];
        var _item_id = _sell_data.info[4]; // Pegamos o ID que salvamos no inventário
        var _item_data = get_item_data(_item_id); // Puxamos o preço de venda do Script
        
        var _price = _item_data.sell_price;
        
        global.balance += _price;
        update_statement("Venda: " + _item_data.name, _price, "profit");
        
        // Remove do inventário
        obj_inventory.inv[_sell_data.grid_x][_sell_data.grid_y] = -1;
        
        // Desativa a flag global se o item for vendido
        var _global_var = "has_" + _item_id;
        if (variable_global_exists(_global_var)) {
            variable_global_set(_global_var, false);
        }
    }
}

if (_exit) {
    global.time_is_paused = false;
    shop_open = false;
    instance_destroy();
}