
if (instance_exists(obj_dialog)) {
    dialog_cooldown = 0; // Enquanto houver diálogo, o tempo não conta
} else {
    if (dialog_cooldown < 30) dialog_cooldown++; // Conta até 30 frames (0.5s)
}

//--- Low Balance warning ---//
if (global.balance < 50 && !mentor_warned_low_balance) {
    // Só dispara se o saldo for baixo E não houver diálogo E já passou o tempo de segurança
    if (dialog_cooldown >= 30) {
        mentor_warned_low_balance = true; 
        mentor_popup(global.dialog_mentor_low_balance);
    }
}

if (global.balance >= 60) {
    mentor_warned_low_balance = false;
}

//--- First goal reached warning ---//
if (global.balance >= 100 && !mentor_warned_first_goal_reached) {
    if (!instance_exists(obj_dialog) && global.time_is_paused == false) {
        mentor_warned_first_goal_reached = true; 
        mentor_popup(global.dialog_mentor_first_goal_reached);
    }
}