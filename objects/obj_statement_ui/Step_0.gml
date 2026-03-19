if (variable_global_exists("statement")) {
    if (keyboard_check_pressed(ord("E"))) {
        statement_open = !statement_open;
    }
}

if (keyboard_check_pressed(vk_tab) || keyboard_check_pressed(ord("M"))) {
    statement_open = false;
}