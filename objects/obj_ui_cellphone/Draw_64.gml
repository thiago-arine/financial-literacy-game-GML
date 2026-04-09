// Desenha o corpo do celular
draw_sprite(spr_phone_body, 0, display_get_gui_width() - 250, phone_y);

// Só desenha o conteúdo se o celular estiver visível na tela
if (phone_y < display_get_gui_height() - 10) {
    var _inner_x = display_get_gui_width() - 445;
    var _inner_y = phone_y + 130;
    
    draw_set_color(c_black);
    draw_set_font(-1); // Reseta para a fonte padrão do sistema ou sua Font1

    // --- TELA INICIAL (HOME) ---
    if (state == "HOME") {
        draw_sprite(spr_icon_bank, 0, _inner_x, _inner_y);
        draw_text_transformed(_inner_x + 5, _inner_y + 65, "Banco", 1, 1, 0);

        draw_sprite(spr_icon_goal, 0, _inner_x + 80, _inner_y);
        draw_text_transformed(_inner_x + 85, _inner_y + 65, "Metas", 1, 1, 0);
        
        draw_sprite(spr_icon_calendar, 0, _inner_x, _inner_y + 90);
        draw_text_transformed(_inner_x + 5, _inner_y + 155, "Agenda", 1, 1, 0);
    } 
    
    // --- APP BANCO ---
    else if (state == "BANK") {
        draw_text_transformed(_inner_x, _inner_y - 25, "< Voltar", 1, 1, 0);
        draw_text(_inner_x, _inner_y + 10, "Saldo Atual:");
        draw_set_color(make_color_rgb(0, 150, 0));
        draw_text(_inner_x, _inner_y + 35, "R$ " + string(global.balance));
    }
    
    // --- APP METAS ---
    else if (state == "GOAL") {
        draw_text_transformed(_inner_x, _inner_y - 25, "< Voltar", 1, 1, 0);
        if (variable_global_exists("meta") && variable_global_exists("goals")) {
            var _desc = global.goals[$ string(global.meta)]; 
            if (!is_undefined(_desc)) {
                draw_text_ext_transformed(_inner_x, _inner_y + 10, "Objetivo: " + _desc, 20, 180, 1, 1, 0);
            }
        } else {
            draw_text(_inner_x, _inner_y + 10, "Nenhuma meta.");
        }
    }
    
    // --- APP CALENDÁRIO --- 
    else if (state == "CALENDAR") {
        draw_text_transformed(_inner_x, _inner_y - 25, "< Voltar", 1, 1, 0);
        
        // Nome do Mês
        draw_set_halign(fa_center);
        var _month_name = calendar_months[global.month - 1];
        draw_text_transformed(_inner_x + 72, _inner_y + 5, _month_name, 1, 1, 0);
        
        // Grade de dias (4 colunas)
        var _start_x = _inner_x - 10; 
        var _start_y = _inner_y + 35;
        var _col_w = 40; 
        var _row_h = 32;
        
        for (var i = 1; i <= 28; i++) {
            var _row = (i - 1) div 4;
            var _col = (i - 1) mod 4;
            
            var _dx = _start_x + (_col * _col_w) + 20;
            var _dy = _start_y + (_row * _row_h);
            
            // Destaque do dia atual
            if (i == global.day) {
                draw_set_color(c_orange);
                draw_rectangle(_dx - 15, _dy - 2, _dx + 15, _dy + 22, false);
                draw_set_color(c_white);
            } else {
                draw_set_color(c_dkgray);
            }
            
            draw_set_halign(fa_center);
            draw_text_transformed(_dx, _dy, string(i), 1, 1, 0); 
        }
    }
}

// --- RESET DE ESTADOS DE DESENHO ---
draw_set_color(c_white);
draw_set_alpha(1.0);
draw_set_font(Font1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);