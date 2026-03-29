// 1. Captura de teclas (Usando ord para garantir que W/S também funcionem)
var _up    = keyboard_check_pressed(vk_up)    || keyboard_check_pressed(ord("W"));
var _down  = keyboard_check_pressed(vk_down)  || keyboard_check_pressed(ord("S"));
var _exit  = keyboard_check_pressed(vk_escape)  || keyboard_check_pressed(ord("E"));
var _buy   = keyboard_check_pressed(vk_space)   || keyboard_check_pressed(vk_enter);

if (_up) {
    selected -= 1;
    show_debug_message("Subiu: " + string(selected));
}

if (_down) {
    selected += 1;
    show_debug_message("Desceu: " + string(selected));
}

var _total = array_length(shop_items);
if (selected < 0) selected = _total - 1;
if (selected >= _total) selected = 0;

if (_buy) {
    var _item = shop_items[selected];
    if (global.balance >= _item.price) {
        global.balance -= _item.price;
        update_statement("Loja: " + _item.name, _item.price, "loss");
        show_debug_message("Comprou: " + _item.name);
    } else {
        show_debug_message("Sem saldo!");
    }
}

if (_exit) {
    global.time_is_paused = false;
    instance_destroy();
}