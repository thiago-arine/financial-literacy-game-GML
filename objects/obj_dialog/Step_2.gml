if (current_message < 0) exit;
    
var _str = messages[current_message].msg;


if (current_char < string_length(_str)){
    current_char += char_speed * (1 + keyboard_check(input_key));
	if (messages[current_message].is_question = true){
		draw_message = string_copy(_str, 0, current_char)

	} else {
    draw_message = string_copy(_str, 0, current_char);
	}
} 
else if (messages[current_message].is_question = false and keyboard_check_pressed(input_key) or response = true){
	if (messages[current_message].is_end == true){
		instance_destroy();
		global.time_is_paused = false;
	} 
	response = false
	if (messages[current_message].number != -1 and messages[current_message].is_end == false){
		while (messages[current_message].number != number_option){
			current_message++;
		}
		current_message--
	}
	current_message++;
	if (current_message >= array_length(messages)){
	   show_debug_message("Destruindo dialogo")
	   global.time_is_paused = false;
	   instance_destroy();
	   number_option = 0
	}
	else {
	   current_char = 0;
	   show_debug_message("reseta_dialogo")
	    
	} 
}
