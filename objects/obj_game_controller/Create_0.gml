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

dialog_cooldown = 0; // Novo contador de segurança

mentor_warned_low_balance = false;
mentor_warned_first_goal_reached = false;