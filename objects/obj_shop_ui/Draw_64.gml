draw_set_alpha(1); 

draw_set_color(c_black);
draw_rectangle(320, 70, 1000, 580, false);

draw_set_color(c_white);

var _tab_buy_color = (menu_mode == 0) ? c_yellow : c_white;
var _tab_sell_color = (menu_mode == 1) ? c_yellow : c_white;

var start_y = 110;
var start_x = 350;

draw_text_color(start_x, start_y - 60, "COMPRAR [A]", _tab_buy_color, _tab_buy_color, _tab_buy_color, _tab_buy_color, 1);
draw_text_color(start_x + 150, start_y - 60, "VENDER [D]", _tab_sell_color, _tab_sell_color, _tab_sell_color, _tab_sell_color, 1);

if (menu_mode == 0) {
    // Desenha shop_items (seu código original de compra) [cite: 10, 13]
    for (var i = 0; i < array_length(shop_items); i++) {
        var _item = shop_items[i];
        var _yy = start_y + (i * 30);
        var _color = (selected == i) ? c_yellow : c_white;
        draw_text_color(start_x, _yy, (selected == i ? "> " : "") + _item.name, _color, _color, _color, _color, 1);
        draw_text(880, _yy, "R$ " + string(_item.price));
    }
} else {
    // Desenha itens do inventário para venda
    if (array_length(sell_items) == 0) {
        draw_text(start_x, start_y + 20, "Inventário Vazio");
    } else {
        for (var i = 0; i < array_length(sell_items); i++) {
            var _item_info = sell_items[i].info;
            var _item_name = _item_info[4];
            var _yy = start_y + (i * 30);
            var _color = (selected == i) ? c_yellow : c_white;
            
            // Lógica de Preço (Deve ser IGUAL à do Step_0.gml) 
        var _sell_price = 0;
        switch(_item_name) {
            case "Pipa":    _sell_price = 7; break;
            case "Chave":   _sell_price = 5; break;
            case "Headset": _sell_price = 30; break; 
            case "Chave Inglesa":    _sell_price = 5 break;
            default:        _sell_price = 2; break;
        }
            
            // O nome do item está no índice 4 do array do inventário [cite: 4]
            draw_text_color(start_x, _yy, (selected == i ? "> " : "") + string(_item_name), _color, _color, _color, _color, 1);
            draw_text(880, _yy, "R$ " + string(_sell_price));
        }
    }
}



draw_set_color(c_white);
draw_text(start_x, start_y - 30, "Loja do Tadeu | SELECIONE UM ITEM |");
draw_line(350, start_y + 5, 960, start_y + 5);


draw_set_color(c_white);
var y_line = 500;
draw_line(350, y_line, 960, y_line);

draw_text(350, y_line + 10, "Seu Saldo:");
draw_set_color(c_yellow);
draw_text(880, y_line + 10, "R$ " + string(global.balance));

draw_set_color(c_white);
draw_set_alpha(0.6);
draw_text(350, 535, "[A/D] Abas | [W/S] Itens | [ESPAÇO] Confirmar | [Z] Sair");
draw_set_alpha(1);