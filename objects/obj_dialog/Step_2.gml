if (current_message < 0 || _str == noone) exit;

var _dialog_data = _str.dialog[current_message];

// Lógica de escrita (Efeito typewriter)
if (current_char < string_length(_dialog_data.msg)){
    current_char += char_speed * (1 + keyboard_check(input_key));
    draw_message = string_copy(_dialog_data.msg, 1, floor(current_char));
} 
// Momento de avançar o diálogo
else if (keyboard_check_pressed(input_key) or response == true) {
    
    // Se for uma pergunta e o jogador apertou Espaço (confirmando a seleção do teclado)
    if (_dialog_data.is_question == true && response == false) {
        response = true;
        handle_question_choice(_dialog_data.choice, selected_option);
        exit; // Interrompe para processar a escolha antes de tentar avançar
    }
    
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
        
        global.is_dialog_active = false; // Ao morrer, libera para o Mentor

         // Buscamos o índice do objeto pelo nome para evitar o erro de "Variable not set"
         var _player_asset = asset_get_index("obj_player"); 
         if (_player_asset != -1) {
             var _inst_player = instance_find(_player_asset, 0);
             if (_inst_player != noone) {
                 _inst_player.moving = false; // Garante que o player pare de andar
             }   
         }        
     
             
             global.time_is_paused = false;
             instance_destroy();
             number_option = 0; // Reseta para o próximo diálogo
    }
    
    else {
        current_char = 0;
        draw_message = "";
    } 
}

// Lógica de Navegação por Teclado
if (_dialog_data.is_question == true) {
    var _max_options = array_length(_dialog_data.options);
    
    if (keyboard_check_pressed(vk_up)) {
        selected_option--;
        if (selected_option < 0) selected_option = _max_options - 1;
    }
    
    if (keyboard_check_pressed(vk_down)) {
        selected_option++;
        if (selected_option >= _max_options) selected_option = 0;
    }
}