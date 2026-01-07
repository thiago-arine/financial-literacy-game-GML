if (current_message < 0) exit;
    
//var _str = messages[current_message].msg;
for (current_dialog = 0; current_dialog < array_length(messages); current_dialog++) {
    
    if (messages[current_dialog].happened == false) {
        _str = messages[current_dialog];
        break
    }
	show_debug_message(current_dialog)

}


if (current_char < string_length(_str.dialog[current_message].msg)){
    current_char += char_speed * (1 + keyboard_check(input_key));
	if (_str.dialog[current_message].is_question = true){
		draw_message = string_copy(_str.dialog[current_message].msg, 0, current_char)

	} else {
    draw_message = string_copy(_str.dialog[current_message].msg, 0, current_char);
	}
} 
else if ((!_str.dialog[current_message].is_question and keyboard_check_pressed(input_key)) or response == true){
	show_debug_message(_str.dialog[current_message].is_question)
	show_debug_message("Input pressed")
	response = false
	if (_str.dialog[current_message].is_end == true){
		if (_str.kind == "unique"){
			_str.happened = true
		}
		instance_destroy();
		global.time_is_paused = false;
	} 
	if (_str.dialog[current_message].number != -1 and _str.dialog[current_message].is_end == false){
		if (_str.dialog[current_message].number != number_option){
			while (_str.dialog[current_message].number != number_option){
				current_message++;
			}
		current_message--
		}	
	}
	current_message++;
	if (current_message >= array_length(_str.dialog)){
	   global.time_is_paused = false;
	   if (_str.kind == "unique"){
			_str.happened = true
		}
	   instance_destroy();
	   number_option = 0
	}
	else {
	   current_char = 0;
	   show_debug_message("reseta_dialogo")
	    
	} 
}
