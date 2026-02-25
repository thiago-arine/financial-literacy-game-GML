// 1. Controle de abrir/fechar
if (keyboard_check_pressed(ord("M"))) {
    phone_open = !phone_open; 
}

// Interpolação para movimento suave
var _target = phone_open ? (display_get_gui_height() - 500) : display_get_gui_height();
phone_y = lerp(phone_y, _target, 0.15);

// 2. Lógica de Interação (Cliques)
if (phone_y < display_get_gui_height() - 10) {
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    
    // Coordenadas internas da tela do celular
    var _inner_x = display_get_gui_width() - 445;
    var _inner_y = phone_y + 130;
    var _icon_size = 64; 

    if (mouse_check_button_pressed(mb_left)) {
        if (state == "HOME") {
            // Clique no Banco
            if (point_in_rectangle(_mx, _my, _inner_x, _inner_y, _inner_x + _icon_size, _inner_y + _icon_size)) {
                state = "BANK";
            }
            // Clique na Meta
            var _meta_x = _inner_x + 80;
            if (point_in_rectangle(_mx, _my, _meta_x, _inner_y, _meta_x + _icon_size, _inner_y + _icon_size)) {
                state = "GOAL";
            }
            // Clique no Calendário
            var _cal_x = _inner_x;
            var _cal_y = _inner_y + 90;
            if (point_in_rectangle(_mx, _my, _cal_x, _cal_y, _cal_x + _icon_size, _cal_y + _icon_size)) {
                state = "CALENDAR";
            }
        } 
        else {
            // Botão Voltar (Área do texto "< Voltar" no topo da tela interna)
            // Funciona para sair de qualquer App e voltar para a HOME
            if (point_in_rectangle(_mx, _my, _inner_x, _inner_y - 40, _inner_x + 100, _inner_y)) {
                state = "HOME";
            }
        }
    }
}