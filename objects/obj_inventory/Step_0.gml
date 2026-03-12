if (keyboard_check_pressed(vk_tab)) {
    inventory_open = !inventory_open;
}

if (keyboard_check_pressed(ord("M")) || keyboard_check_pressed(ord("E"))) {
    inventory_open = false; 
}
