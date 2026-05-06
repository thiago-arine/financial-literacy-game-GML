draw_set_alpha(1); 
draw_set_font(Font1);
draw_set_valign(fa_top); // Garante que o texto alinhe pelo topo
draw_set_halign(fa_left);

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();
var _shop_w = 680;
var _shop_h = 620; // Aumentado um pouco para caber tudo com folga

var _center_x = _gui_w / 2;
var _center_y = _gui_h / 2;

var _x1 = _center_x - (_shop_w / 2);
var _y1 = _center_y - (_shop_h / 2);
var _x2 = _x1 + _shop_w;
var _y2 = _y1 + _shop_h;

// --- 1. DESENHO DO FUNDO E MOLDURA ---
draw_set_color(c_black);
draw_rectangle(_x1, _y1, _x2, _y2, false);

// Moldura branca tripla
draw_set_color(c_white);
for (var i = 0; i < 3; i++) {
    draw_rectangle(_x1 - i, _y1 - i, _x2 + i, _y2 + i, true);
}

// --- 2. POSICIONAMENTO DINÂMICO ---
var _margin = 30;
var _text_sep = 40; // Espaço vertical entre cada item da lista (aumentado de 30 para 40)
var _current_y = _y1 + 20;
var _right_align_x = _x2 - 140;

// --- 3. ABAS (COMPRAR / VENDER) ---
var _tab_buy_color = (menu_mode == 0) ? c_yellow : c_white;
var _tab_sell_color = (menu_mode == 1) ? c_yellow : c_white;

draw_text_color(_x1 + _margin, _current_y, "COMPRAR [A]", _tab_buy_color, _tab_buy_color, _tab_buy_color, _tab_buy_color, 1);
draw_text_color(_x1 + _margin + 180, _current_y, "VENDER [D]", _tab_sell_color, _tab_sell_color, _tab_sell_color, _tab_sell_color, 1);

_current_y += 50; // Pula para o cabeçalho

// --- 4. CABEÇALHO DA LOJA ---
draw_set_color(c_white);
draw_text(_x1 + _margin, _current_y, "Loja do Tadeu | SELECIONE UM ITEM |");
_current_y += 30;

// Linha divisória superior
draw_line(_x1 + _margin, _current_y, _x2 - _margin, _current_y);
_current_y += 20; // Espaço entre a linha e o primeiro item

var _item_list_start_y = _current_y;

// --- 5. LISTA DE ITENS ---
if (menu_mode == 0) {
    for (var i = 0; i < array_length(shop_items); i++) {
        var _shop_entry = shop_items[i];
        if (variable_struct_exists(_shop_entry, "id")) {
            var _item_data = get_item_data(_shop_entry.id); 
            
            var _yy = _item_list_start_y + (i * _text_sep);
            var _color = (selected == i) ? c_yellow : c_white;
            var _display_text = (selected == i ? "> " : "  ") + _item_data.name;
            
            draw_text_color(_x1 + _margin, _yy, _display_text, _color, _color, _color, _color, 1);
            draw_text_color(_right_align_x, _yy, "R$ " + string(_shop_entry.price), _color, _color, _color, _color, 1); 
        }
    }
}
else {
    if (array_length(sell_items) == 0) {
        draw_set_alpha(0.5);
        draw_text(_x1 + _margin, _item_list_start_y, "Inventário vazio.");
        draw_set_alpha(1);
    } else {
        for (var i = 0; i < array_length(sell_items); i++) {
            var _inventory_id = sell_items[i].info[4]; 
            var _item_data = get_item_data(_inventory_id); 
            
            var _yy = _item_list_start_y + (i * _text_sep);
            var _color = (selected == i) ? c_yellow : c_white;
            var _display_text = (selected == i ? "> " : "  ") + _item_data.name;
            
            draw_text_color(_x1 + _margin, _yy, _display_text, _color, _color, _color, _color, 1);
            draw_text_color(_right_align_x, _yy, "R$ " + string(_item_data.sell_price), _color, _color, _color, _color, 1);
        }
    }
}

// --- 6. RODAPÉ (SALDO E CONTROLES) ---
var _y_footer = _y2 - 90;

// Linha divisória inferior
draw_set_color(c_white);
draw_line(_x1 + _margin, _y_footer, _x2 - _margin, _y_footer);

// Saldo
var _balance_y = _y_footer + 15;
draw_text(_x1 + _margin, _balance_y, "Seu Saldo:");
draw_set_color(c_yellow);
draw_text(_right_align_x, _balance_y, "R$ " + string(global.balance));

// Comandos
draw_set_color(c_white);
draw_set_alpha(0.6);
draw_text(_x1 + _margin, _y2 - 35, "[A/D] Abas | [W/S] Itens | [ESPAÇO] Confirmar | [ESC] Sair");
draw_set_alpha(1);