if (variable_global_exists("statement")) {
    if (keyboard_check_pressed(ord("Z"))) {
        statement_open = !statement_open;
        global.time_is_paused = statement_open;
    }
}

if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(ord("C"))) {
    statement_open = false;
}