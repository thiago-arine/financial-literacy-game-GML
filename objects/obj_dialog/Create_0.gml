choice_made = false
_str = noone;
messages = [];
current_dialog = 0;
current_message = -1;
current_char = 0;
draw_message = "";
number_option = 0;
selected_option = 0;
char_speed = 0.5;
input_key = vk_space;
response = false;

is_mentor_popup = false;
global.is_dialog_active = true; // Ao nascer, avisa que o diálogo está ativo

gui_w = display_get_gui_width();
gui_h = display_get_gui_height();

// Método para lidar com escolhas
handle_question_choice = function(choice_name, option_index) {
	if (choice_made) return;
    choice_made = true;
	
    var _dialog_data = _str.dialog[current_message];
    var _result = _dialog_data.option_results[option_index];
    var _kind = _dialog_data.kind;

    if (instance_exists(obj_events)) {
        with(obj_events) {
            Process_game_event(choice_name, _kind, _result);
        }
    }

    number_option = _result; // Isso faz o código pular para o bloco 1 ou 2
    response = true;
	
	alarm[1] = 5;
}

alarm[0] = 1; // Busca o bloco de diálogo no próximo frame

/*global.time_is_paused = true;