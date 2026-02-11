// 1. Controle de abrir/fechar
if (keyboard_check_pressed(ord("M"))) {
    phone_open = !phone_open; 
}

// Interpolação para movimento suave (Animação de subir/descer)
var _target = phone_open ? (display_get_gui_height() - 500) : display_get_gui_height();
phone_y = lerp(phone_y, _target, 0.15);

// 2. Lógica de Interação
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
            // Clique na Meta (deslocado 80px para bater com o Draw)
            var _meta_x = _inner_x + 80;
            if (point_in_rectangle(_mx, _my, _meta_x, _inner_y, _meta_x + _icon_size, _inner_y + _icon_size)) {
                state = "GOAL";
            }
        } 
        else {
            // Botão Voltar (Área do texto "< Voltar")
            if (point_in_rectangle(_mx, _my, _inner_x, _inner_y - 40, _inner_x + 100, _inner_y)) {
                state = "HOME";
            }
        }
    }
}