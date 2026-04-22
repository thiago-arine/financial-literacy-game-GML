if (variable_global_exists("statement")) {
    if (keyboard_check_pressed(ord("Z"))) {
        // Travas par não abrir UI durante transição de dia
        if (instance_exists(obj_time_controller) && obj_time_controller.is_fading) exit;
        if (instance_exists(obj_fade_transition)) exit;

        statement_open = !statement_open;
        global.time_is_paused = statement_open;
    }
}

if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(ord("C"))) {
    statement_open = false;
}