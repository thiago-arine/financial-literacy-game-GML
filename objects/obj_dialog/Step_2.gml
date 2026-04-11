if (current_message < 0 || _str == noone) exit;

var _dialog_data = _str.dialog[current_message];

// Lógica de escrita (Efeito typewriter)
if (current_char < string_length(_dialog_data.msg)){
    current_char += char_speed * (1 + keyboard_check(input_key));
    draw_message = string_copy(_dialog_data.msg, 1, floor(current_char));
} 
// Momento de avançar o diálogo
else if ((!_dialog_data.is_question and keyboard_check_pressed(input_key)) or response == true){
    response = false;
    
    // --- LÓGICA DE PULO PARA A MISSÃO (ORDEM CORRETA) ---
    // Verifica se a próxima fala pertence a um bloco diferente do atual
    var _next_index = current_message + 1;
    if (_next_index < array_length(_str.dialog)) {
        var _next_data = _str.dialog[_next_index];
        
        // Se a fala atual é do Sim(1) ou Não(2) e a próxima não é do mesmo grupo nem da missão(3)
        if (_dialog_data.number != 0 && _dialog_data.number != -1 && _dialog_data.number != 3) {
            if (_next_data.number != _dialog_data.number && _next_data.number != 3) {
                // Pula direto para onde começa a missão (number 3)
                while (current_message < array_length(_str.dialog) - 1 && _str.dialog[current_message].number != 3) {
                    current_message++;
                }
                current_message--; // Ajuste para o incremento padrão abaixo
            }
        }
    }

    // Lógica de Pulo por Escolha 
    if (_dialog_data.number != -1 and _dialog_data.is_end == false){
        if (_dialog_data.number != number_option && number_option != 0){
            while (current_message < array_length(_str.dialog) - 1 && _str.dialog[current_message].number != number_option){
                current_message++;
            }
            current_message--; 
        }
    }

    // Executa Trigger Event (Gatilho de missão) antes de fechar ou mudar
	if (variable_struct_exists(_dialog_data, "trigger_event")) {
	    if (instance_exists(obj_events)) {
	        with(obj_events) {
                
                // Verifica se existe o campo 'reward' dentro do trigger_event do diálogo
                var _val_reward = variable_struct_exists(_dialog_data.trigger_event, "reward") ? _dialog_data.trigger_event.reward : 0;
                
	            // Aqui ele chama o método que definimos acima
	            Process_game_event(_dialog_data.trigger_event.name, 
                _dialog_data.trigger_event.kind, 
                _dialog_data.trigger_event.result,
                _val_reward);
	        }
	    }
	}

    current_message++;

    // Verificação de fim de diálogo
    if (current_message >= array_length(_str.dialog) || _dialog_data.is_end == true){
        if (_str.kind == "unique") _str.happened = true;
        
        instance_destroy();
        global.time_is_paused = false;
        number_option = 0; // Reseta para o próximo diálogo
    }
    else {
        current_char = 0;
        draw_message = "";
    } 
}