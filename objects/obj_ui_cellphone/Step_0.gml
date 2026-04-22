// 1. Controle de abrir/fechar
if (keyboard_check_pressed(ord("C"))) {
    // Travas par não abrir UI durante transição de dia
    if (instance_exists(obj_time_controller) && obj_time_controller.is_fading) exit;
    if (instance_exists(obj_fade_transition)) exit;

    phone_open = !phone_open;
    global.time_is_paused = phone_open;
}

if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(ord("Z"))) {
    phone_open = false; 
}

// Interpolação para movimento suave
var _target = phone_open ? (display_get_gui_height() - 500) : display_get_gui_height();
phone_y = lerp(phone_y, _target, 0.15);

// 2. Lógica de Interação (Cliques)
// 2. Lógica de Interação
if (phone_y < display_get_gui_height() - 10) {
    
    // --- NAVEGAÇÃO POR TECLADO (SETAS) ---
    if (state == "HOME") {
        var _move = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
        if (_move != 0) {
            selected_app += _move;
            // Limites entre 0 e 2 (Banco, Metas, Agenda)
            if (selected_app < 0) selected_app = 2;
            if (selected_app > 2) selected_app = 0;
        }

        // Confirmar com Espaço ou Enter
        if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
            if (selected_app == 0) state = "BANK";
            else if (selected_app == 1) state = "GOAL";
            else if (selected_app == 2) state = "CALENDAR";
        }
    }

    // --- BOTÃO VOLTAR / SAIR (ESC) ---
    if (keyboard_check_pressed(vk_escape)) {
        if (state != "HOME") {
            state = "HOME";
        } else {
            phone_open = false;
            global.time_is_paused = false;
        }
    }

    // Mantém a lógica de mouse original por compatibilidade
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    var _inner_x = display_get_gui_width() - 445;
    var _inner_y = phone_y + 130;
    var _icon_size = 64;

    if (mouse_check_button_pressed(mb_left)) {
        if (state == "HOME") {
            if (point_in_rectangle(_mx, _my, _inner_x, _inner_y, _inner_x + _icon_size, _inner_y + _icon_size)) state = "BANK";
            var _meta_x = _inner_x + 80;
            if (point_in_rectangle(_mx, _my, _meta_x, _inner_y, _meta_x + _icon_size, _inner_y + _icon_size)) state = "GOAL";
            var _cal_y = _inner_y + 90;
            if (point_in_rectangle(_mx, _my, _inner_x, _cal_y, _inner_x + _icon_size, _cal_y + _icon_size)) state = "CALENDAR";
        } else {
            if (point_in_rectangle(_mx, _my, _inner_x, _inner_y - 40, _inner_x + 100, _inner_y)) state = "HOME";
        }
    }
}