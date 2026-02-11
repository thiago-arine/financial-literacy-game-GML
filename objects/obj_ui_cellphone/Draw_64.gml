draw_sprite(spr_phone_body, 0, display_get_gui_width() - 250, phone_y);

if (phone_y < display_get_gui_height() - 10) {
    var _inner_x = display_get_gui_width() - 445;
    var _inner_y = phone_y + 130;
    
    draw_set_color(c_black);
    draw_set_font(-1);

    if (state == "HOME") {
        draw_sprite(spr_icon_bank, 0, _inner_x, _inner_y);
        draw_text_transformed(_inner_x + 5, _inner_y + 65, "Banco", 0.7, 0.7, 0);

        draw_sprite(spr_icon_goal, 0, _inner_x + 80, _inner_y);
        draw_text_transformed(_inner_x + 85, _inner_y + 65, "Metas", 0.7, 0.7, 0);
    } 
    else if (state == "BANK") {
        draw_text_transformed(_inner_x, _inner_y - 25, "< Voltar", 0.8, 0.8, 0);
        draw_text(_inner_x, _inner_y + 10, "Saldo Atual:");
        draw_set_color(make_color_rgb(0, 150, 0));
        draw_text(_inner_x, _inner_y + 35, "R$ " + string(global.balance));
    }
    else if (state == "GOAL") {
        draw_text_transformed(_inner_x, _inner_y - 25, "< Voltar", 0.8, 0.8, 0);
        
        if (variable_global_exists("meta") && variable_global_exists("goals")) {
            var _desc = global.goals[$ string(global.meta)]; 
            if (!is_undefined(_desc)) {
                draw_text_ext(_inner_x, _inner_y + 10, "Objetivo: " + _desc, 20, 150);
            }
        } else {
            draw_text(_inner_x, _inner_y + 10, "Nenhuma meta.");
        }
    }
}

draw_set_color(c_white);
draw_set_alpha(1.0);
draw_set_font(Font1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);