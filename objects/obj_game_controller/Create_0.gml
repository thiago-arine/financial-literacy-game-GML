if (instance_number(obj_game_controller) > 1) {
    instance_destroy();
    exit;
}

if (!variable_global_exists("statement")) {
    global.statement = [];
}

if (!variable_global_exists("balance")) {
    global.balance = 0.00;
}


