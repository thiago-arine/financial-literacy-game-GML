var _up    = keyboard_check_pressed(vk_up)    || keyboard_check_pressed(ord("W"));
var _down  = keyboard_check_pressed(vk_down)  || keyboard_check_pressed(ord("S"));
var _exit  = keyboard_check_pressed(vk_escape)  || keyboard_check_pressed(ord("Q"));
var _buy   = keyboard_check_pressed(vk_space)   || keyboard_check_pressed(vk_enter); //var de compra e venda
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
                    // Armazena a info do item + sua posição na matriz para poder remover depois
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

    // Lógica de "Wrap" (circular)
    if (selected < 0) selected = _total - 1;
    if (selected >= _total) selected = 0;
} else {
    selected = 0;
}

if (_buy && _total > 0) {
	if (menu_mode == 0){
        var _item = shop_items[selected];
        if (global.balance >= _item.price) {
            var _success = obj_inventory.inventory_add(_item.sprite, _item.image_index, 1, _item.type, _item.name);
            if (_success) {
                global.balance -= _item.price;
                update_statement("Compra: " + _item.name, _item.price, "loss");
            }
        }
    } else {
        // --- LÓGICA DE VENDA ---
        var _sell_data = sell_items[selected];
        var _item_name = _sell_data.info[4]; // Nome do item no inventário
        
        // Define o preço baseado no nome
        var _price = 0;
        switch(_item_name) {
            case "Pipa": _price = 7; break;
            case "Chave": _price = 5; break;
            case "Headset": _price = 30; break; 
            case "Chave Inglesa":    _price = 5 break;   
            default: _price = 2; break;
        }
        
        // Adiciona saldo e extrato 
        global.balance += _price;
        update_statement("Venda: " + _sell_data.info[4], _price, "income");
        
        // Remove do inventário (volta para -1) 
        obj_inventory.inv[_sell_data.grid_x][_sell_data.grid_y] = -1;
        show_debug_message("Vendeu: " + _sell_data.info[4]);
    }
}

if (_exit) {
    global.time_is_paused = false;
	shop_open = false;
    instance_destroy();
}