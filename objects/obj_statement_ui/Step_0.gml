if (keyboard_check_pressed(ord("E"))) {
    open = !open;
}

if (keyboard_check_pressed(vk_tab) || keyboard_check_pressed(ord("M"))) {
    open = false;
}