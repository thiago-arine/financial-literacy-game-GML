if (keyboard_check_pressed(ord("X"))) {
    inventory_open = !inventory_open;
    global.time_is_paused = inventory_open;
}

if (keyboard_check_pressed(ord("C")) || keyboard_check_pressed(ord("Z"))) {
    inventory_open = false; 
}
