// --- Inicialização Global ---
if (instance_number(object_index) > 1) {
    instance_destroy();
    exit;
}

global.balance = 0;
global.reputation = 50;
global.meta = 0;
global.statement = [];
global.draw_reward_value = 0;
global.reward_alpha = 0;
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
    { name: "buy_icecream",   loss: -5,  reputation: 0 }, // Preço base (Casquinha)
    { name: "buy_led_hat",    loss: -50, reputation: 20 },
	{ name: "buy_coxinha",    loss: -8, reputation: 0 },
	{ name: "buy_card",		  loss: -8, reputation: 0 },
	{ name: "buy_plushie",    loss: -12, reputation: 0 },
	{ name: "buy_painting",   loss: -20, reputation: 0 }
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

Process_game_event = function(event_name, event_kind, option_result, _reward = 0) {
    show_debug_message("Evento Recebido: " + string(event_name) + " | Valor: " + string(option_result) + " | Recompensa: " + string(_reward));
    
    // --- LÓGICA DE GASTOS (LOSS) ---
    if (event_kind == "loss") {
        for (var i=0; i < array_length(loss_events); i++){
            if (event_name == loss_events[i].name){
                
                var _final_price = loss_events[i].loss;
                var _item_label = loss_events[i].name;
                var _is_buying = true; 
        
                // --- LÓGICA DO AMIGO (Promoção do Jogo) ---
                if (event_name == "game_promotion") {
                    if (option_result == 2) { // 2 = "Queria muito, mas não vai dar..."
                        _is_buying = false;
                        show_debug_message("Player recusou a compra do jogo.");
                        return; // Encerra aqui, não tira dinheiro nem mostra erro de saldo
                    }
                }
        
                // --- LÓGICA DO SORVETEIRO ---
                if (event_name == "buy_icecream") {
                    if (option_result == 1) { _final_price = -5;  _item_label = "Sorvete Casquinha"; }
                    else if (option_result == 2) { _final_price = -10; _item_label = "Sorvete Copo"; }
                    else if (option_result == 3) { // 3 = "Não, obrigado"
                        _is_buying = false;
                        return; 
                    }
                }
				
				if (event_name == "buy_coxinha") {
                    if (option_result == 1) { _final_price = -6;  _item_label = "Coxinha"; }
                    else if (option_result == 2) {
						_is_buying = false;
							return; }
                    else if (option_result == 3) {
                        _is_buying = false;
                        return; 
                    }
                }
                
                if (event_name == "buy_led_hat") {
                    if (option_result == 1) { _final_price = -50; _item_label = "Boné de LED"; }
                    else if (option_result == 2) { // 2 = "Manter meta"
                        _is_buying = false;
                        return 
                    }
                    else if (option_result == 3) { // 3 - "Verificar se o boné é útil"
                        _is_buying = false;
                        return
                    }
                }
				
				if (event_name == "buy_card") {
                    if (option_result == 1) { _final_price = -8; _item_label = "Carta Rara"; }
                    else if (option_result == 2) { 
                        _is_buying = false;
                        return 
                    }
                    else if (option_result == 3) {
                        _is_buying = false;
                        return
                    }
                }
				
				if (event_name == "buy_plushie") {
                    if (option_result == 1) { _final_price = -12; _item_label = "Pelúcia"; }
                    else if (option_result == 2) { 
                        _is_buying = false;
                        return 
                    }
                    else if (option_result == 3) {
                        _is_buying = false;
                        return
                    }
                }
				
				if (event_name == "buy_painting") {
                    if (option_result == 1) { _final_price = -12; _item_label = "Pintura da Praça"; }
                    else if (option_result == 2) { 
                        _is_buying = false;
                        return 
                    }
                    else if (option_result == 3) {
                        _is_buying = false;
                        return
                    }
                }
        
                // --- PROCESSAMENTO FINAL ---
                if (_is_buying) {
                    if (global.balance >= abs(_final_price)) {
                        global.balance += _final_price;
                        global.reputation += loss_events[i].reputation;
                        update_statement(_item_label, abs(_final_price), "loss");
                        
                        // Efeito especial apenas se for sorvete
                        if (event_name == "buy_icecream") {
                            //global.player_speed = 4;
                            alarm[2] = 300;
                        }
                    } else {
                        // Se tentou comprar mas não tem dinheiro:
                        if (instance_exists(obj_dialog)) instance_destroy(obj_dialog);
                        create_dialog(global.dialog_sem_dinheiro);
                    }
                }
                break;
            }
        }
    }

    // --- LÓGICA ESPECIAL (METAS E MISSÕES) ---
    if (event_kind == "special") {
        
        // Se houver recompensa, adiciona ao saldo global
        if (_reward > 0) {
            global.balance += _reward;
            // Opcional: Registrar no extrato/statement se desejar
            update_statement("Recompensa: " + event_name, _reward, "gain"); 
        
            // --- feedback visual de recompensa ---
            global.draw_reward_value = _reward;
            global.reward_alpha = 1.5; // Começa acima de 1 para durar um pouco mais antes de sumir
        }
        
        switch(event_name) {
            case "meta":
                global.meta = option_result;
                show_debug_message("Meta definida: " + string(global.meta));
            break;
        
            case "start_phase_2":
                if (global.balance >= 100) {
                    global.balance -= 100; // Deduz o valor do fone
                    global.meta = 2;       // Atualiza para a meta do celular 
                    update_statement("Compra: Fone de Ouvido", 100, "loss"); // Registra no extrato
                    show_debug_message("Fase 2 iniciada: Meta 900");
                }
			
			case "open_shop":
			    if (option_result == 1) {
			        if (!instance_exists(obj_shop_ui)) {
						global.time_is_paused = true;
			            instance_create_depth(0, 0, -1000, obj_shop_ui);
			            global.time_is_paused = true; 
			            show_debug_message("Loja aberta.");
			        }
			    }
			break;
            
            case "start_quest_key": 
                global.quest_key_started = true;
                show_debug_message("Missão da chave Iniciada!");
            break;
        
            case "quest_key":
                if (option_result == 1 && global.has_key) {
                    global.reputation += 15;
                    global.has_key = false;
                    global.quest_key_finished = true;
                    inventory_remove_item("key"); 
                    show_debug_message("Missão da chave concluída.");
                }
            break;
            
            case "start_quest_headset": 
                global.quest_headset_started = true;
                show_debug_message("Missão do headset Iniciada!");
            break;
            
            case "quest_headset":
                if (option_result == 1 && global.has_headset) {
                    global.reputation += 25
                    global.has_headset = false;
                    global.quest_headset_finished = true;
                    inventory_remove_item("headset"); 
                    show_debug_message("Missão do headset concluída.");
                }
			break;
            
            case "start_quest_kite": 
                global.quest_kite_started = true;
                show_debug_message("Missão da Pipa Iniciada!");
            break;
            
            case "quest_kite":
                if (option_result == 1 && global.has_kite) {
                    global.reputation += 10
                    global.has_kite = false;
                    global.quest_kite_finished = true;
                    inventory_remove_item("kite"); 
                    show_debug_message("Missão kite concluída.");
                }
			break;
            case "quest_screwdriver":
                if (option_result == 1 && global.has_screwdriver) {
                    global.reputation += 20; // Defina a reputação que desejar
                    global.has_screwdriver = false;
                    global.quest_screwdriver_finished = true;
                    inventory_remove_item("Chave Inglesa"); 
                    show_debug_message("Missão da chave inglesa concluída.");
                }
break;
        }
    }
}