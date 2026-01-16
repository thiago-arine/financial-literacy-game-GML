draw_set_font(Font1); 
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_text(10, 50, "Saldo: R$" + string_format(global.balance, 0, 2));