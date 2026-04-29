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
mentor_warned_statement_tutorial = false;
mentor_warned_inventory_tip = false;
mentor_warned_welcome = false;
mentor_warned_game_over = false;
mentor_warned_quiz_4 = false;
mentor_warned_quiz_1 = false
trigger_no_money = false;
trigger_no_item = false;
