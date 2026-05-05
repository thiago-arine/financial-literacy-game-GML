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
        draw_set_color(c_black); // Define a cor para os textos
        
        // 1. BANCO (Índice 0)
        var _s_bank = (selected_app == 0) ? spr_icon_bank_highlight : spr_icon_bank;
        draw_sprite(_s_bank, 0, _inner_x, _inner_y);
        draw_text_transformed(_inner_x + 5, _inner_y + 65, "Banco", 1, 1, 0);

        // 2. METAS (Índice 1)
        var _s_goal = (selected_app == 1) ? spr_icon_goal_highlight : spr_icon_goal;
        draw_sprite(_s_goal, 0, _inner_x + 80, _inner_y);
        draw_text_transformed(_inner_x + 85, _inner_y + 65, "Metas", 1, 1, 0);
        
        // 3. AGENDA (Índice 2)
        var _s_cal = (selected_app == 2) ? spr_icon_calendar_highlight : spr_icon_calendar;
        draw_sprite(_s_cal, 0, _inner_x, _inner_y + 90);
        draw_text_transformed(_inner_x + 5, _inner_y + 155, "Agenda", 1, 1, 0);
    
        // 4. PULAR (Índice 3) - Posicionado na segunda linha ou ao lado
        var _s_skip = (selected_app == 3) ? spr_icon_skip_highlight : spr_icon_skip;
        var _skip_x = _inner_x;      // Começa nova linha
        var _skip_y = _inner_y + 90; // 90 pixels abaixo da primeira linha
        
        draw_sprite(_s_skip, 0, _inner_x + 80, _inner_y + 90);
        draw_text_transformed(_inner_x + 85, _inner_y + 155, "Pular", 1, 1, 0);
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
                    draw_text_ext_transformed(_inner_x, _inner_y + 10, "Objetivo: " + _desc, 20, 150, 1, 1, 0);
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
    
    // --- RENDERIZAÇÃO DO MENU DE CONFIRMAÇÃO (ADICIONAR AO FINAL DO EVENTO) ---
   if (state == "SKIP_CONFIRM") {
       var _gw = display_get_gui_width();
       var _gh = display_get_gui_height();
       var _mw = 400; // Largura do menu
       var _mh = 200; // Altura do menu
       var _x1 = (_gw - _mw) / 2;
       var _y1 = (_gh - _mh) / 2;
       var _x2 = _x1 + _mw;
       var _y2 = _y1 + _mh;
   
       // Fundo preto
       draw_set_color(c_black);
       draw_set_alpha(0.9);
       draw_rectangle(_x1, _y1, _x2, _y2, false);
       
       // Borda Branca (Tripla como o seu padrão de HUD)
       draw_set_alpha(1);
       draw_set_color(c_white);
       for (var i = 0; i < 3; i++) {
           draw_rectangle(_x1 - i, _y1 - i, _x2 + i, _y2 + i, true);
       }
   
       // Texto de Pergunta
       draw_set_halign(fa_center);
       draw_text(_gw / 2, _y1 + 40, "Deseja pular para o\nfim do dia?");
   
       // Opções
       var _opt_y = _y1 + 130;
       
       // Opção: Pular Dia
       var _c_skip = (skip_option_selected == 0) ? c_yellow : c_white;
       draw_text_color(_gw / 2 - 80, _opt_y, "Pular dia", _c_skip, _c_skip, _c_skip, _c_skip, 1);
   
       // Opção: Cancelar
       var _c_canc = (skip_option_selected == 1) ? c_yellow : c_white;
       draw_text_color(_gw / 2 + 80, _opt_y, "Cancelar", _c_canc, _c_canc, _c_canc, _c_canc, 1);
       
       draw_set_halign(fa_left); // Reseta alinhamento
   }
}

// --- RESET DE ESTADOS DE DESENHO ---
draw_set_color(c_white);
draw_set_alpha(1.0);
draw_set_font(Font1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

