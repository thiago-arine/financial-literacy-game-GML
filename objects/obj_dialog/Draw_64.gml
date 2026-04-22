if (_str == noone || current_message < 0) exit;

var _boxw = gui_w * 0.9;
var _boxh = gui_h * 0.3; 
var _margin_bottom = 50;

if (_str.dialog[current_message].is_question == true) _boxh *= 1.1; 

var _dx = (display_get_gui_width() - _boxw) / 2;
var _dy = display_get_gui_height() - _boxh - _margin_bottom;

var _text_x_offset = 0; // Espaço que o texto vai "pular" para a direita

if (variable_instance_exists(id, "is_mentor_popup") && is_mentor_popup) {
    // Desenha a sprite do Mentor alinhada à esquerda da caixa
    // O y é o mesmo da caixa (_dy), subtraindo a altura da sprite se quiser que ele "saia" da caixa
    var _scale = 15; 
    _text_x_offset = 200; // Define que o texto deve recuar 100 pixels
    draw_sprite_ext(spr_npc_mentor, 0, _dx + 20, _dy + 20, _scale, _scale, 0, c_white, 1); 
}

// Desenha a caixa
draw_sprite_stretched(spr_box, 0, _dx, _dy, _boxw, _boxh);

_dx += 16; 
_dy += 16;
var _padding = 10; 

draw_set_font(Font_Medium);
var _name = _str.dialog[current_message].name;

// Cores (Acessando a struct global que você definiu)
if (variable_global_exists("char_colors") && struct_exists(global.char_colors, _name)) {
    draw_set_colour(global.char_colors[$ _name]);
}
draw_text(_dx + _padding + _text_x_offset, _dy + _padding, _name);
draw_set_colour(c_white);

_dy += 40;
draw_text_ext(_dx + _padding + _text_x_offset, _dy + 10, draw_message, -1, _boxw - (_padding * 2) - _text_x_offset);

// Lógica de Opções/Perguntas
if (_str.dialog[current_message].is_question == true) {
    var _option_start_y = _dy + 50;
    
    for (var i = 0; i < array_length(_str.dialog[current_message].options); i++) {
        var _current_y = _option_start_y + (i * 30);
        var _option_text = "> " + _str.dialog[current_message].options[i];
        
        var _tw = string_width(_option_text);
        var _th = string_height(_option_text);
        var mx = device_mouse_x_to_gui(0);
        var my = device_mouse_y_to_gui(0);
        
        var _hover = point_in_rectangle(mx, my, _dx + _padding + _text_x_offset, _current_y, _dx + _padding + _tw, _current_y + _th);
        
        if (_hover) {
            selected_option = i; 
        }

        // Desenha com cor diferente se for a opção selecionada (por mouse ou teclado)
        if (selected_option == i) {
            draw_set_colour(c_orange); 
            
            // Clique do mouse ainda funciona
            if (mouse_check_button_pressed(mb_left)) { 
                response = true;
                handle_question_choice(_str.dialog[current_message].choice, i);
            }
        } else {
            draw_set_colour(c_white); 
        }
        
        draw_text(_dx + _padding + _text_x_offset, _current_y, _option_text);
    }
}