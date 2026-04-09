var _up    = keyboard_check_pressed(vk_up)    || keyboard_check_pressed(ord("W"));
var _down  = keyboard_check_pressed(vk_down)  || keyboard_check_pressed(ord("S"));
var _exit  = keyboard_check_pressed(vk_escape)  || keyboard_check_pressed(ord("Z"));
var _buy   = keyboard_check_pressed(vk_space)   || keyboard_check_pressed(vk_enter);

if (_up) selected--;
if (_down) selected++;

var _total = array_length(shop_items);
if (selected < 0) selected = _total - 1;
if (selected >= _total) selected = 0;

if (_buy) {
    var _item = shop_items[selected];
	
    if (global.balance >= _item.price) {
        if (instance_exists(obj_inventory)) {
            var _success = obj_inventory.inventory_add(_item.sprite, _item.image_index, 1, _item.type, _item.name);
            
            if (_success) {
                global.balance -= _item.price;
                update_statement("Loja: " + _item.name, _item.price, "loss");
                show_debug_message("Comprou e guardou: " + _item.name);
            } else {
                show_debug_message("Inventário cheio!");
            }
        }
    } else {
        instance_destroy();
        if (variable_global_exists("dialog_sem_dinheiro")) {
            create_dialog(global.dialog_sem_dinheiro);
        }
    }
}

if (_exit) {
    global.time_is_paused = false;
	shop_open = false;
    instance_destroy();
}