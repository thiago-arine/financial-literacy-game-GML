draw_set_alpha(1); 

draw_set_color(c_black);
draw_rectangle(320, 70, 1000, 580, false);

draw_set_color(c_white);

var _tab_buy_color = (menu_mode == 0) ? c_yellow : c_white;
var _tab_sell_color = (menu_mode == 1) ? c_yellow : c_white;

var start_y = 110;
var start_x = 350;

draw_text_color(start_x, start_y - 60, "COMPRAR [A]", _tab_buy_color, _tab_buy_color, _tab_buy_color, _tab_buy_color, 1);
draw_text_color(start_x + 165, start_y - 60, "VENDER [D]", _tab_sell_color, _tab_sell_color, _tab_sell_color, _tab_sell_color, 1);

// --- MODO DE COMPRA ---
if (menu_mode == 0) {
    for (var i = 0; i < array_length(shop_items); i++) {
        var _shop_entry = shop_items[i];
        
        // Verificação de segurança: garante que o ID existe antes de chamar o banco de dados
        if (variable_struct_exists(_shop_entry, "id")) {
            var _item_data = get_item_data(_shop_entry.id); 
            
            var _yy = start_y + (i * 30);
            var _color = (selected == i) ? c_yellow : c_white;
            var _display_text = (selected == i ? "> " : "") + _item_data.name;
            
            draw_text_color(start_x, _yy, _display_text, _color, _color, _color, _color, 1);
            draw_text(880, _yy, "R$ " + string(_shop_entry.price)); 
        }
    }
}
// --- MODO DE VENDA ---
else {
    if (array_length(sell_items) == 0) {
        draw_text(start_x, start_y + 20, "Inventário Vazio");
    } else {
        for (var i = 0; i < array_length(sell_items); i++) {
            var _inventory_id = sell_items[i].info[4]; // O ID (inglês) que está no slot 4 do inventário
            var _item_data = get_item_data(_inventory_id); // Puxa nome e preço de venda do script
            
            var _yy = start_y + (i * 30);
            var _color = (selected == i) ? c_yellow : c_white;
            
            var _display_text = (selected == i ? "> " : "") + _item_data.name;
            
            draw_text_color(start_x, _yy, _display_text, _color, _color, _color, _color, 1);
            draw_text(880, _yy, "R$ " + string(_item_data.sell_price));
        }
    }
}

// --- RODAPÉ E UI ---
draw_set_color(c_white);
draw_text(start_x, start_y - 30, "Loja do Tadeu | SELECIONE UM ITEM |");
draw_line(350, start_y + 5, 960, start_y + 5);

var y_line = 500;
draw_line(350, y_line, 960, y_line);

draw_text(350, y_line + 10, "Seu Saldo:");
draw_set_color(c_yellow);
draw_text(880, y_line + 10, "R$ " + string(global.balance));

draw_set_color(c_white);
draw_set_alpha(0.6);
draw_text(350, 535, "[A/D] Abas | [W/S] Itens | [ESPAÇO] Confirmar | [ESC] Sair");
draw_set_alpha(1);