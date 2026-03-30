draw_set_alpha(1); 

draw_set_color(c_black);
draw_rectangle(320, 70, 1000, 580, false);

draw_set_color(c_white);
for (var i = 0; i < 3; i++) {
    draw_rectangle(320 - i, 70 - i, 1000 + i, 580 + i, true);
}

var start_y = 110;
var start_x = 350;

draw_set_color(c_white);
draw_text(start_x, start_y - 30, "Loja do Tadeu | SELECIONE UM ITEM |");
draw_line(350, start_y + 5, 960, start_y + 5);

if (!is_array(shop_items)) exit;

for (var i = 0; i < array_length(shop_items); i++) {
    var _item = shop_items[i];
    var _yy = start_y + (i * 30);

    var _text_color = (selected == i) ? c_yellow : c_white;
    draw_set_color(_text_color);

    var _prefix = (selected == i) ? "> " : "  ";

    draw_text(start_x, _yy + 5, _prefix + string(_item.name));

    draw_text(880, _yy + 5, "R$ " + string(_item.price));
}
draw_set_color(c_white);
var y_line = 500;
draw_line(350, y_line, 960, y_line);

draw_text(350, y_line + 10, "Seu Saldo:");
draw_set_color(c_yellow);
draw_text(880, y_line + 10, "R$ " + string(global.balance));

draw_set_color(c_white);
draw_set_alpha(0.6);
draw_text(350, 535, "[W/S] Navegar | [ESPAÇO] Comprar | [ESC] Sair");
draw_set_alpha(1);