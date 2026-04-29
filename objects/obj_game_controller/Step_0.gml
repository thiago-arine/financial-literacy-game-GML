
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
if (global.balance < 15 && !mentor_warned_low_balance && !_shop_blocking && !obj_time_controller.is_fading) {
    if (dialog_cooldown >= 30) {
        mentor_warned_low_balance = true;
        mentor_popup(global.dialog_mentor_low_balance);
    }
}

if (global.balance >= 16) {
    mentor_warned_low_balance = false;
}

//--- First goal reached warning ---//
if (global.balance >= 100 && !mentor_warned_first_goal_reached && !_shop_blocking && !obj_time_controller.is_fading) {
    if (!instance_exists(obj_dialog) && global.time_is_paused == false) {
        mentor_warned_first_goal_reached = true; 
        mentor_popup(global.dialog_mentor_first_goal_reached);
    }
}

//--- Tutorial de Extrato (Disparado após o primeiro gasto) ---//
// Verificamos se a loja fechou para não interromper a compra
if (!mentor_warned_statement_tutorial && !_shop_blocking && !obj_time_controller.is_fading) {
    
    // Verifica se existe ao menos uma entrada de gasto no extrato
    var _has_spent = false;
    var _size = array_length(global.statement);
    
    for (var i = 0; i < _size; i++) {
        if (global.statement[i].kind == "loss") {
            _has_spent = true;
            break;
        }
    }

    // Se houve gasto e o cooldown de diálogo permitiu 
    if (_has_spent && dialog_cooldown >= 30 && !instance_exists(obj_dialog) && !obj_time_controller.is_fading) {
        mentor_warned_statement_tutorial = true;
        mentor_popup(global.dialog_mentor_statement_tutorial);
    }
}

// --- Verificação de Derrota (Game Over) ---
   if (global.month >= 4 && !mentor_warned_game_over) {
       if (global.balance < 100) {
           // Se chegou no mês 4 sem os 100 reais
           if (!obj_time_controller.is_fading && !instance_exists(obj_dialog)) {
               mentor_warned_game_over = true;
               mentor_popup(global.dialog_mentor_game_over);
           }
       }
   }



if (trigger_no_item) {
    if (!instance_exists(obj_dialog) && !obj_time_controller.is_fading) {
        mentor_popup(global.dialog_mentor_no_item);
        trigger_no_item = false; // Reseta o gatilho após criar o diálogo
    }
}

// Dispara o quiz assim que o jogador atinge R$ X,XX e ainda não fez o quiz
if (global.balance <= 29 && !variable_global_exists("quiz_1_finished") && !obj_time_controller.is_fading) {
    mentor_popup(global.dialog_mentor_quiz);
}

if (global.balance >= 50 && !variable_global_exists("quiz_2_finished") && !obj_time_controller.is_fading) {
    mentor_popup(global.dialog_mentor_quiz_2);
}

if (global.balance <= 10 && !variable_global_exists("quiz_3_finished") && !obj_time_controller.is_fading) {
    mentor_popup(global.dialog_mentor_quiz_3);
}