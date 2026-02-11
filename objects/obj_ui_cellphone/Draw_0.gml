draw_sprite(spr_phone_body, 0, display_get_gui_width() - 250, phone_y);

if (phone_y < display_get_gui_height()) {
    var _inner_x = display_get_gui_width() - 445;
    var _inner_y = phone_y + 130;
    draw_set_color(c_black);

    // --- TELA INICIAL (ÍCONES) ---
    if (state == "HOME") {
        // Desenha Ícone do Banco (Exemplo: use um sprite 16x16 ou um retângulo)
        draw_sprite(spr_icon_bank, 0, _inner_x, _inner_y);
        draw_text_transformed(_inner_x, _inner_y + 20, ".", 0.5, 0.5, 0);

        // Desenha Ícone da Meta (posicionado ao lado)
        draw_sprite(spr_icon_goal, 0, _inner_x + 60, _inner_y);
        draw_text_transformed(_inner_x + 60, _inner_y + 20, ".", 0.5, 0.5, 0);
    } 

    // --- TELA DO BANCO ---
    else if (state == "BANK") {
        draw_text_transformed(_inner_x, _inner_y - 20, "< Voltar", 0.5, 0.5, 0);
        draw_text(_inner_x, _inner_y, "Saldo:");
        draw_text(_inner_x, _inner_y + 25, "R$ " + string(global.balance) + ".00");
    }

    // --- TELA DA META ---
    else if (state == "GOAL") {
        draw_text_transformed(_inner_x, _inner_y - 20, "< Voltar", 0.5, 0.5, 0);
        if (variable_global_exists("meta")) {
            var _target_key = string(global.meta);
            var _goal_description = global.goals[$ _target_key]; 
            if (!is_undefined(_goal_description)) {
                draw_text_ext(_inner_x, _inner_y, "Objetivo:", 20, 100);
                draw_text_ext(_inner_x, _inner_y + 25, _goal_description, 15, 100);
            }
        } else {
            draw_text(_inner_x, _inner_y, "Sem metas.");
        }
    }
}