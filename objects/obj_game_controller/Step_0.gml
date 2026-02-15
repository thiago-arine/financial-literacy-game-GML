if (keyboard_check_pressed(ord("E"))) {
    
    if (!instance_exists(obj_statement_ui)) {
        instance_create_layer(0, 0, "UI", obj_statement_ui);
    } else {
        with (obj_statement_ui) instance_destroy();
    }
}