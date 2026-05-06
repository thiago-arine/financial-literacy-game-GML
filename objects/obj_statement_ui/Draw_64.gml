if (statement_open) {
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();

    // --- 1. OVERLAY DE ESCURECIMENTO DE FUNDO ---
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    
    // --- 2. CONFIGURAÇÕES DA JANELA ---
    draw_set_alpha(1); 
    draw_set_font(Font1);
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);

    var _w = 700; // Largura levemente aumentada para acomodar a barra de rolagem
    var _h = 500; // Altura corrigida para melhor proporção

    var _center_x = _gui_w / 2;
    var _center_y = _gui_h / 2;

    var _x1 = _center_x - (_w / 2);
    var _y1 = _center_y - (_h / 2);
    var _x2 = _x1 + _w;
    var _y2 = _y1 + _h;

    // Fundo e Borda Tripla
    draw_set_color(c_black);
    draw_rectangle(_x1, _y1, _x2, _y2, false);

    draw_set_color(c_white);
    for (var i = 0; i < 3; i++) {
        draw_rectangle(_x1 - i, _y1 - i, _x2 + i, _y2 + i, true);
    }

    if (!is_array(global.statement)) {
        draw_set_alpha(1);
        exit;
    }

    // --- 3. INICIALIZAÇÃO E CAPTURA DO SCROLL ---
    // Cria a variável de scroll na instância caso ela ainda não exista
    if (!variable_instance_exists(id, "statement_scroll")) {
        statement_scroll = 0;
    }

    var _start_x = _x1 + 35;
    var _list_y1 = _y1 + 40;  // Onde a lista começa
    var _list_y2 = _y2 - 95;  // Limite máximo onde a lista deve parar (antes do rodapé)
    var _visible_height = _list_y2 - _list_y1;
    var _item_h = 38;         // Altura e espaçamento vertical fixo de cada item
    var _right_align_x = _x2 - 150;

    var _total_content_height = array_length(global.statement) * _item_h;
    var _max_scroll = max(0, _total_content_height - _visible_height);

    // Captura entrada do Mouse Wheel ou Setas do Teclado
    var _wheel_input = mouse_wheel_down() - mouse_wheel_up();
    var _kbd_input = keyboard_check(vk_down) - keyboard_check(vk_up);
    
    if (_wheel_input != 0) {
        statement_scroll += _wheel_input * 25; // Velocidade do scroll pelo mouse
    } else if (_kbd_input != 0) {
        statement_scroll += _kbd_input * 4;    // Velocidade do scroll pelo teclado
    }
    
    // Garante que o scroll não passe dos limites válidos
    statement_scroll = clamp(statement_scroll, 0, _max_scroll);

    // --- 4. DESENHO DOS ITENS (COM LIMITADOR VISUAL) ---
    for (var i = 0; i < array_length(global.statement); i++) {
        var entry = global.statement[i];
        if (!is_struct(entry)) continue;

        // Calcula a posição Y aplicando a rolagem subtraída
        var _yy = _list_y1 + (i * _item_h) - statement_scroll;

        // SÓ DESENHA se o item estiver dentro do campo de visão permitido
        if (_yy >= _list_y1 && _yy <= _list_y2 - 25) {
            // Sombra do texto informativo
            draw_set_color(c_black);
            var text_header = string(entry.date) + " | " + string(entry.from) + " |";
            draw_text(_start_x + 1, _yy + 1, text_header);
            
            draw_set_color(c_white);
            draw_text(_start_x, _yy, text_header);

            // Valor formatado com cor dinâmica (Ganho ou Perda)
            var value_color = (entry.kind == "gain") ? c_lime : c_red;
            
            draw_set_color(c_black);
            draw_text(_right_align_x + 1, _yy + 1, "R$ " + string(entry.values)); // Sombra do valor
            
            draw_set_color(value_color);
            draw_text(_right_align_x, _yy, "R$ " + string(entry.values));
        }
    }

    // --- 5. DESENHO DA BARRA DE ROLAGEM VISUAL (SCROLLBAR) ---
    if (_total_content_height > _visible_height) {
        var _sb_x = _x2 - 20;
        var _sb_w = 6;
        
        // Desenha o fundo da barra (trilho)
        draw_set_color(c_white);
        draw_set_alpha(0.2);
        draw_rectangle(_sb_x, _list_y1, _sb_x + _sb_w, _list_y2, false);
        
        // Calcula o tamanho e a posição do indicador (thumb)
        var _thumb_h = max(20, (_visible_height / _total_content_height) * _visible_height);
        var _thumb_y = _list_y1 + (statement_scroll / _max_scroll) * (_visible_height - _thumb_h);
        
        // Desenha o indicador ativo
        draw_set_alpha(0.7);
        draw_rectangle(_sb_x, _thumb_y, _sb_x + _sb_w, _thumb_y + _thumb_h, false);
        draw_set_alpha(1);
    }

    // --- 6. RODAPÉ ESTÁTICO (FIXO NO FUNDO) ---
    draw_set_color(c_white);
    
    // A linha divisória agora fica em uma posição fixa absoluta
    draw_line(_start_x, _list_y2, _x2 - 35, _list_y2);

    var _text_footer_y = _list_y2 + 15;
    
    // Texto do Saldo com sombra
    draw_set_color(c_black);
    draw_text(_start_x + 1, _text_footer_y + 1, "Saldo Atual Disponível:");
    draw_text(_right_align_x + 1, _text_footer_y + 1, "R$ " + string(global.balance));

    draw_set_color(c_white);
    draw_text(_start_x, _text_footer_y, "Saldo Atual Disponível:");
    
    draw_set_color(c_yellow);
    draw_text(_right_align_x, _text_footer_y, "R$ " + string(global.balance));
}

// Reset de propriedades globais de desenho
draw_set_alpha(1);
draw_set_color(c_white);