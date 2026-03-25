// --- Inicialização Global ---
if (instance_number(object_index) > 1) {
    instance_destroy();
    exit;
}

global.balance = 0;
global.reputation = 50;
global.meta = 0;
global.statement = [];
global.player_speed = 2; // Velocidade padrão do jogador

global.goals = {
    "1": "Fone de Ouvido - R$100,00", 
    "2": "Celular - R$900,00",
    "3": "Formatura - R$1700,00"
};

// --- Listas de Dados ---
loss_events = [
    { name: "game_promotion", loss: -15, reputation: 10 },
    { name: "cinema",         loss: -80, reputation: 20 },
    { name: "buy_icecream",   loss: -5,  reputation: 1 } // Preço base (Casquinha)
];

// --- Funções Auxiliares ---

// Função de Inventário
inventory_remove_item = function(_target_name) {
    if (!instance_exists(obj_inventory)) return false;
    with(obj_inventory) {
        for (var j = 0; j < invMaxY; j++) {
            for (var i = 0; i < invMaxX; i++) {
                if (is_array(inv[i][j]) && inv[i][j][4] == _target_name) {
                    inv[i][j] = -1; 
                    return true;
                }
            }
        }
    }
    return false;
}

// Função de Processar Eventos (CORRIGIDA E COMPLETA)
Process_game_event = function(event_name, event_kind, option_result) {
    show_debug_message("Evento Recebido: " + string(event_name) + " | Valor: " + string(option_result));
    
    // --- LÓGICA DE GASTOS (LOSS) ---
    if (event_kind == "loss") {
        for (var i=0; i < array_length(loss_events); i++){
            if (event_name == loss_events[i].name){
                
                var _final_price = loss_events[i].loss;
                var _item_label = loss_events[i].name;

                // Ajuste dinâmico para o Sorveteiro
                if (event_name == "buy_icecream") {
                    if (option_result == 1) { _final_price = -5;  _item_label = "Sorvete Casquinha"; }
                    if (option_result == 2) { _final_price = -10; _item_label = "Sorvete Copo"; }
                    if (option_result == 3) return; // Cancelou
                }

                // Verifica Saldo
                if (global.balance >= abs(_final_price)) {
                    global.balance += _final_price;
                    global.reputation += loss_events[i].reputation;
                    update_statement(_item_label, abs(_final_price), "loss");
                    
                    // Efeito de Velocidade do Sorvete
                    if (event_name == "buy_icecream") {
                        //global.MOVE_SPEED = 4;
                        alarm[2] = 300; // 5 segundos (a 60fps)
                        show_debug_message("Bônus de velocidade ativado!");
                    }
                } else {
                    show_debug_message("Saldo insuficiente!");
                }
                break;
            }
        }
    }

    // --- LÓGICA ESPECIAL (METAS E MISSÕES) ---
    if (event_kind == "special") {
        switch(event_name) {
            case "meta":
                global.meta = option_result;
                show_debug_message("Meta definida: " + string(global.meta));
            break;
            
            case "quest_key":
                if (option_result == 1 && global.has_key) {
                    global.reputation += 15;
                    global.has_key = false;
                    global.quest_key_finished = true;
                    inventory_remove_item("Chave"); 
                    show_debug_message("Missão da chave concluída.");
                }
            break;
        }
    }
}