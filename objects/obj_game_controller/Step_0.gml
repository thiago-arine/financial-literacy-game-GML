
if (instance_exists(obj_dialog)) {
    dialog_cooldown = 0; // Enquanto houver diálogo, o tempo não conta
} else {
    if (dialog_cooldown < 30) dialog_cooldown++; // Conta até 30 frames (0.5s)
}

// --- TRAVA DA LOJA ---
// Criamos uma variável local para simplificar a checagem abaixo
var _shop_blocking = false;
if (instance_exists(obj_shop_ui)) {
    if (obj_shop_ui.shop_open) _shop_blocking = true;
}

//--- Low Balance warning ---//
if (global.balance < 50 && !mentor_warned_low_balance && !_shop_blocking) {
    if (dialog_cooldown >= 30) {
        mentor_warned_low_balance = true;
        mentor_popup(global.dialog_mentor_low_balance);
    }
}

if (global.balance >= 60) {
    mentor_warned_low_balance = false;
}

//--- First goal reached warning ---//
if (global.balance >= 100 && !mentor_warned_first_goal_reached && !_shop_blocking) {
    if (!instance_exists(obj_dialog) && global.time_is_paused == false) {
        mentor_warned_first_goal_reached = true; 
        mentor_popup(global.dialog_mentor_first_goal_reached);
    }
}