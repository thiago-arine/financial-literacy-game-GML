// 1. Controle de abrir/fechar
if (keyboard_check_pressed(ord("M"))) {
    phone_open = !phone_open; 
}

if (phone_open) {
    phone_y = lerp(phone_y, display_get_gui_height() - 500, 0.1);
} else {
    phone_y = lerp(phone_y, display_get_gui_height(), 0.1);
}

// 2. Lógica de Interação (Somente se o celular estiver visível)
if (phone_y < display_get_gui_height()) {
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    
    // DEFINIÇÃO DAS COORDENADAS (Importante para evitar o erro de variável não definida)
    var _inner_x = display_get_gui_width() - 445;
    var _inner_y = phone_y + 130;
    var _icon_size = 64; // Tamanho para ícones 64x64

    // Clique com o botão esquerdo do mouse
    if (mouse_check_button_pressed(mb_left)) {
        
        if (state == "HOME") {
            // Clique no Banco (Área do ícone 1)
            if (point_in_rectangle(_mx, _my, _inner_x, _inner_y, _inner_x + _icon_size, _inner_y + _icon_size)) {
                state = "BANK";
            }
            // Clique na Meta (Área do ícone 2 - deslocado 80px)
            var _meta_x = _inner_x + 80;
            if (point_in_rectangle(_mx, _my, _meta_x, _inner_y, _meta_x + _icon_size, _inner_y + _icon_size)) {
                state = "GOAL";
            }
        } 
        else {
            // Botão Voltar (Área acima dos apps)
            if (point_in_rectangle(_mx, _my, _inner_x, _inner_y - 40, _inner_x + 100, _inner_y)) {
                state = "HOME";
            }
        }
    }
}