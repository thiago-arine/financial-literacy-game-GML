//_str = messages[current_dialog];

var _boxw = gui_w * 0.9;
var _boxh = gui_h * 0.3; 
var _margin_bottom = 50;

if ( _str.dialog[current_message].is_question == true) {
    _boxh *= 1.1; 
}

var _dx = (display_get_gui_width() - _boxw) / 2;
var _dy = display_get_gui_height() - _boxh - _margin_bottom;

draw_sprite_stretched(spr_box, 0, _dx, _dy, _boxw, _boxh);

_dx += 16;
_dy += 16;
var _padding = 10; 

draw_set_font(Font1);
var _name = _str.dialog[current_message].name;

draw_set_colour(global.char_colors[$ _name]);

draw_text(_dx + _padding, _dy + _padding, _name);

draw_set_colour(c_white);

_dy += 40;

draw_text_ext(_dx + _padding, _dy + 10, draw_message, -1, _boxw - (_padding * 2));
var _y_options = _dy + _padding + 10

if ( _str.dialog[current_message].is_question == true) {

    var _option_start_y = _y_options + 40;
    var _selected_option = -1; 
    
    for (var i = 0; i < array_length( _str.dialog[current_message].options); i++) {
        var _current_y = _option_start_y + (i * 30);
        var _option_text = "> " +  _str.dialog[current_message].options[i];
        
        var _text_width = string_width(_option_text);
        var _text_height = string_height(_option_text);
        
        var mx = device_mouse_x_to_gui(0);
        var my = device_mouse_y_to_gui(0);
        
        var _hover = point_in_rectangle(mx, my, 
            _dx + _padding, _current_y,
            _dx + _padding + _text_width, _current_y + _text_height
        );
        
        if (_hover && mouse_check_button_pressed(mb_left)) {
            _selected_option = i;
            response = true;
            
            handle_question_choice( _str.dialog[current_message].choice, i);
        }
    }
    
    for (var i = 0; i < array_length( _str.dialog[current_message].options); i++) {
        var _current_y = _option_start_y + (i * 30);
        var _option_text = "> " +  _str.dialog[current_message].options[i];
        
        var _text_width = string_width(_option_text);
        var _text_height = string_height(_option_text);
        
        var mx = device_mouse_x_to_gui(0);
        var my = device_mouse_y_to_gui(0);
        
        var _hover = point_in_rectangle(mx, my, 
            _dx + _padding, _current_y,
            _dx + _padding + _text_width, _current_y + _text_height
        );
        
        if (_selected_option == i) {
            draw_set_colour(c_green); 
        } else if (_hover) {
            draw_set_colour(c_orange); 
        } else {
            draw_set_colour(c_white); 
        }
        
        draw_text(_dx + _padding, _current_y, _option_text);
    }
}

function handle_question_choice(choice_type, option_index) {
    switch(choice_type) {
        case "meta": 
            global.meta = _str.dialog[current_message].option_results[option_index];
            global.meta_display = instance_create_depth(0, 0, -1000, obj_meta_display);
            show_debug_message("Meta definida: " + string(global.meta));
            break;
            
        case "game_promotion": //mudar para "reputation_quest" e aplicar ama função que recebe o nome da quest e altera a reputação e o saldo do jogador
            if ( _str.dialog[current_message].option_results[option_index] == 1) {
                global.balance -= 15.00;
				global.reputation += 10;
				update_statement("Baldur's gate", "15", "loss")
                show_debug_message("Promoção adquirida! Saldo: " + string(global.balance));
            }
            number_option = _str.dialog[current_message].option_results[option_index];
			global.reputation -= 5; //Criar função para verificar se a reputação do player já é máxima ou mínima, visto que não pode ultrapassar esses valores
            break;
    }
}
