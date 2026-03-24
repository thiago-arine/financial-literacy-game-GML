//Eventos serão divididos em três grupos: gain_event, loss_event e special_event.
//gain_event e loss_event são tratados de maneiras semelhantes, alteraldo as var globais balance e reputation
//special_event são outras escolhas do jogados, que não trabalha com balance ou reputation, como o evento de escolha de meta.
   //special_events de maneiras distintas
   
//Os diálogos com opções de escolha devem ter uma chave de tipo de escola: gain, loss ou special.

function Process_game_event(event_name, event_kind, option_result){
//event_name tem que ser igual ao valor de "choice", event_kind também fica nos diálogos e deve ser igual a "gain", "loss" ou "special"
	
	//Tratamento de eventos de perda de dinheiro
	if (event_kind == "loss") {
		for (var i=0; i < array_length(loss_events); i++){
			if (event_name == loss_events[i].name){
				if (option_result == 1){
					//Jogador aceitou gastar: altera saldo e reputação
					global.balance += loss_events[i].loss
					global.reputation += loss_events[i].reputation
					
					//Registra a transação no extrato bancário
					if (variable_global_exists("statement")) {
						array_push(global.statement, {
							date: "24/03", 
							from: loss_events[i].name, 
							values: loss_events[i].loss, 
							kind: "loss"
						});
					}
				} else {
					//Jogador recusou: perde reputação por não participar
					global.reputation -= loss_events[i].reputation
				}
				break
			}
		}
	} 
	
	//Tratamento de eventos de ganho de dinheiro
	else if (event_kind == "gain") {
		for (var i=0; i < array_length(gain_events); i++){
			if (event_name == gain_events[i].name){
				if (option_result == 1){
					global.balance += gain_events[i].gain
					global.reputation += gain_events[i].reputation
				}
				break
			}
		}
	} 
	
	//Tratamento de eventos especiais (missões e itens coletáveis)
	else if (event_kind == "special") {
		//tratar com switch case, já que cada special_event terá um comportamento e saída diferente
		switch(event_name) {
			
			case "quest_headset":
				//Se o jogador escolher entregar (1) e possuir o item coletado
				if (option_result == 1 && global.has_headset) {
					global.reputation += 20
					global.has_headset = false //Remove a flag de posse para o diálogo
					inventory_remove_item("Headset") //Remove o item visualmente da grade
				}
			break;

			case "quest_key":
				if (option_result == 1 && global.has_key) {
					global.reputation += 10
					global.has_key = false
					inventory_remove_item("Chave")
				}
			break;

			case "quest_kite":
				if (option_result == 1 && global.has_kite) {
					global.reputation += 5
					global.has_kite = false
					inventory_remove_item("Pipa")
				}
			break;
			
			case "meta":
				//Define a meta de vida do jogador baseada na escolha
				if (option_result == 1) global.player_meta = "economizar";
			break;
		}
	}
}

//Lista de eventos de perda de saldo
loss_events = [
	{
	name: "game_promotion",
	loss: -15,
	reputation: 2,
	},
	{
	name: "cinema",
	loss: -80,
	reputation: 5,
	}
]

//Lista de eventos de ganho de saldo
gain_events = [
	{
	name: "work_payout",
	gain: 150,
	reputation: 1,
	}
]

//Função auxiliar para remover item da matriz inv[i][j] pelo nome
function inventory_remove_item(_name) {
    if (!instance_exists(obj_inventory_ui)) return;
    
    with(obj_inventory_ui) {
        for (var j = 0; j < invMaxY; j++) {
            for (var i = 0; i < invMaxX; i++) {
                //O nome do item está guardado no índice 4 do array do slot
                if (is_array(inv[i][j]) && inv[i][j][4] == _name) {
                    inv[i][j] = -1 //Limpa o slot da matriz
                    return true;
                }
            }
        }
    }
    return false;
}