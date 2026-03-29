// Overlay Escuro (Fundo)
draw_set_alpha(0.6);
draw_set_color(c_black);
draw_rectangle(0, 0, gui_w, gui_h, false);
draw_set_alpha(1);

// Caixa da Loja
draw_set_color(make_color_rgb(60, 40, 20)); // Marrom Escuro
draw_rectangle(start_x, start_y, start_x + shop_w, start_y + shop_h, false);
draw_set_color(c_white);
draw_rectangle(start_x, start_y, start_x + shop_w, start_y + shop_h, true);

// Cabeçalho
draw_set_halign(fa_center);
draw_text_transformed(start_x + shop_w/2, start_y + 25, "LOJINHA DO TADEU", 1.5, 1.5, 0);
draw_set_halign(fa_left);

// Linha Divisória
draw_line(start_x + 20, start_y + 60, start_x + shop_w - 20, start_y + 60);

// Saldo Atual (Destaque em Amarelo/Verde)
draw_set_color(c_yellow);
draw_text(start_x + 30, start_y + 75, "Seu Saldo: R$ " + string(global.balance));
draw_set_color(c_white);

// Lista de Itens
for (var i = 0; i < array_length(shop_items); i++) {
    var _yy = start_y + 110 + (i * 35);
    var _item = shop_items[i];
    
    if (selected == i) {
        draw_set_color(c_yellow);
        draw_text(start_x + 30, _yy, "> " + _item.name);
        draw_set_halign(fa_right);
        draw_text(start_x + shop_w - 30, _yy, "R$ " + string(_item.price));
        draw_set_halign(fa_left);
        
        // Desenha a descrição do item selecionado no rodapé
        draw_set_color(c_ltgray);
        draw_text(start_x + 30, start_y + shop_h - 40, _item.desc);
    } else {
        draw_set_color(c_white);
        draw_text(start_x + 45, _yy, _item.name);
        draw_set_halign(fa_right);
        draw_text(start_x + shop_w - 30, _yy, "R$ " + string(_item.price));
        draw_set_halign(fa_left);
    }
}