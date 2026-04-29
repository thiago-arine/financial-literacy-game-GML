
// --- Lógica da Mesada com trava de fim de jogo ---
if (global.day == 1 and global.month != last_payment_month) {
    
    // SÓ recebe se estivermos nos meses 1, 2 ou 3
    if (global.month < 4) {
        global.balance += 30.00;
        update_statement("Mesada Pais", "30", "gain");
        last_payment_month = global.month;
    } 
    else {
        // Se o mês virou para 4, apenas registramos que o mês passou 
        // para o código não rodar em loop, mas não damos o dinheiro.
        last_payment_month = global.month;
    }
}