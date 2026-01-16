//Eventos serão dividos em três grupos: gain_event, loss_event e special_event.
//gain_event e loss_event são tratados de maneiras semelhantes, alteraldo as var globais balance e reputation
//special_event são outras escolhas do jogados, que não trabalha com balance ou reputation, como o evento de escolha de meta.
   //special_events de maneiras distintas
   
//Os diálogos com opções de escolha devem ter uma chave de tipo de escola: gain, loss ou special.

function Process_loss_event(event_name, event_kind, option_result){
//event_name é tem que ser igual ao valor de "choice", event_kind também fica nos diálogos e deve ser igual a "gain", "loss" ou "special"
	if (event_kind == "loss") {
		for (var i=0; i < loss_events; i++){
			if (event_name == loss_events[i].name){
				if (option_result == 1){
					global.balance += loss_events[i].loss
					global.reputation += loss_events[i].reputation
				} else {
					global.reputation -= loss_events[i].reputation
				}
				break
			}
		}
	} else if (event_kind == "gain") {
		//planejar como serão feitos os eventos de ganho
	} else {
		//tratar com switch case, já que cada special_event terá um compportamento e saída diferente
	
	}
}

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

//gain_events = [{}]

//special_events = [{
	//name: "meta"
//}]