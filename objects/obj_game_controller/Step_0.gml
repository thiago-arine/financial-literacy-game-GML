// 1. Gerenciar o cooldown (tempo de espera)
if (instance_exists(obj_dialog)) {
    dialog_cooldown = 0; // Enquanto houver diálogo, o tempo não conta
} else {
    if (dialog_cooldown < 30) dialog_cooldown++; // Conta até 30 frames (0.5s)
}

// 2. Verificação de Saldo com trava de tempo
if (global.balance < 50 && !mentor_warned_low_balance) {
    // Só dispara se o saldo for baixo E não houver diálogo E já passou o tempo de segurança
    if (dialog_cooldown >= 30) {
        mentor_warned_low_balance = true; 
        mentor_popup(global.dialog_mentor_low_balance);
    }
}

// 3. Reset do gatilho
if (global.balance >= 60) {
    mentor_warned_low_balance = false;
}