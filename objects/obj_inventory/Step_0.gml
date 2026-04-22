if (keyboard_check_pressed(ord("X"))) {
    // Travas par não abrir UI durante transição de dia
    if (instance_exists(obj_time_controller) && obj_time_controller.is_fading) exit;
    if (instance_exists(obj_fade_transition)) exit;

    inventory_open = !inventory_open;
    global.time_is_paused = inventory_open;
}

if (keyboard_check_pressed(ord("C")) || keyboard_check_pressed(ord("Z"))) {
    inventory_open = false; 
}
