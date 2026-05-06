// 1. Controle de abrir/fechar
if (keyboard_check_pressed(ord("C"))) {
    // Travas para não abrir UI durante transição de dia
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

// 2. Lógica de Interação
if (phone_y < display_get_gui_height() - 10) {
    
    // --- NAVEGAÇÃO POR TECLADO (SETAS OU A/D) ---
    
    // Criamos variáveis genéricas de entrada para simplificar o código abaixo
    var input_right = keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"));
    var input_left  = keyboard_check_pressed(vk_left)  || keyboard_check_pressed(ord("A"));
    var _move_input = input_right - input_left;

    if (state == "HOME") {
        if (_move_input != 0) {
            selected_app += _move_input;
            // Limites entre 0 e 4 (Banco, Metas, Agenda, Pular, Sair)
            if (selected_app < 0) selected_app = 4;
            if (selected_app > 4) selected_app = 0;
        }

        // Confirmar com Espaço ou Enter
        if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
            if (selected_app == 0) state = "BANK";
            else if (selected_app == 1) state = "GOAL";
            else if (selected_app == 2) state = "CALENDAR";
            else if (selected_app == 3) {
                state = "SKIP_CONFIRM";
                skip_option_selected = 1; // Inicia focado no "Cancelar"
            }
            else if (selected_app == 4) {
                state = "EXIT_CONFIRM";
                exit_option_selected = 1; // Inicia focado no "Cancelar"
            }
        }
    }
    
    // --- LÓGICA DO MENU DE CONFIRMAÇÃO ---
    else if (state == "SKIP_CONFIRM") {
        if (_move_input != 0) {
            skip_option_selected += _move_input;
            if (skip_option_selected < 0) skip_option_selected = 1;
            if (skip_option_selected > 1) skip_option_selected = 0;
        }
        
        if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
            if (skip_option_selected == 0) { // OPÇÃO: PULAR DIA
                global.game_minute_total = 1380; // Define para 23:00
                state = "HOME";
                phone_open = false;
                global.time_is_paused = false;
            } else { // OPÇÃO: CANCELAR
                state = "HOME";
            }
        }
        
        if (keyboard_check_pressed(vk_escape)) {
            state = "HOME";
        }
    }
    
    // --- LÓGICA DO MENU DE SAIR DO JOGO ---
    else if (state == "EXIT_CONFIRM") {
        if (_move_input != 0) {
            exit_option_selected += _move_input;
            if (exit_option_selected < 0) exit_option_selected = 1;
            if (exit_option_selected > 1) exit_option_selected = 0;
        }
        
        if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
            if (exit_option_selected == 0) { 
                game_end(); 
            } else { 
                state = "HOME";
            }
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

    // Lógica de mouse original
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