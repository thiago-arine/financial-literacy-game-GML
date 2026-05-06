if (_str == noone || current_message < 0) exit;

// --- CONFIGURAÇÕES DE LAYOUT ---
var _boxw = gui_w * 0.9;
var _boxh = gui_h * 0.3; 
var _margin_bottom = 50;
var _padding_inner = 35; // Aumentado para o nome não colar no topo
var _gap_name_dialog = 20; // Espaço fixo entre Nome e Diálogo

if (_str.dialog[current_message].is_question == true) _boxh *= 1.2; 

var _dx = (display_get_gui_width() - _boxw) / 2;
var _dy = display_get_gui_height() - _boxh - _margin_bottom;

var _text_x_offset = 0; 

// --- LÓGICA DO MENTOR ---
if (variable_instance_exists(id, "is_mentor_popup") && is_mentor_popup) {
    var _scale = 15; 
    _text_x_offset = 200; 
    draw_sprite_ext(spr_npc_mentor, 0, _dx + 20, _dy + 20, _scale, _scale, 0, c_white, 1); 
}

// --- DESENHO DA CAIXA ---
draw_sprite_stretched(spr_box, 0, _dx, _dy, _boxw, _boxh);

// --- SETUP DE ALINHAMENTO (CRÍTICO PARA NÃO SUBIR) ---
draw_set_font(Font_Medium);
draw_set_valign(fa_top);    // Garante que o texto comece de cima para baixo
draw_set_halign(fa_left);   // Garante alinhamento à esquerda

var _name = _str.dialog[current_message].name;
var _draw_x = _dx + _padding_inner + _text_x_offset;
var _base_y = _dy + _padding_inner; // Âncora inicial fixa no topo da caixa

// --- 1. DESENHA O NOME ---
if (variable_global_exists("char_colors") && struct_exists(global.char_colors, _name)) {
    draw_set_colour(global.char_colors[$ _name]);
}
draw_text(_draw_x, _base_y, _name);

// --- 2. DESENHA O DIÁLOGO ---
draw_set_colour(c_white);

// A posição do diálogo é SEMPRE a posição do nome + sua altura + o gap
// Isso impede que o texto flutue ou suba.
var _name_height = string_height(_name);
var _dialog_y = _base_y + _name_height + _gap_name_dialog;

var _max_w = _boxw - (_padding_inner * 2) - _text_x_offset;
var _line_sep = 25; // Define uma separação de linha fixa em pixels para evitar saltos

draw_text_ext(_draw_x, _dialog_y, draw_message, _line_sep, _max_w);

// --- 3. LÓGICA DE OPÇÕES ---
if (_str.dialog[current_message].is_question == true) {
    // Calcula quanto o diálogo ocupou para as opções não sobreporem
    var _text_h = string_height_ext(draw_message, _line_sep, _max_w);
    var _option_y = _dialog_y + _text_h + 20; // 20px de respiro após o texto
    
    for (var i = 0; i < array_length(_str.dialog[current_message].options); i++) {
        var _option_text = "> " + _str.dialog[current_message].options[i];
        var _curr_y = _option_y + (i * 35);
        
        // Lógica de seleção (Mouse/Teclado)
        var _tw = string_width(_option_text);
        var _th = string_height(_option_text);
        var mx = device_mouse_x_to_gui(0);
        var my = device_mouse_y_to_gui(0);
        
        if (point_in_rectangle(mx, my, _draw_x, _curr_y, _draw_x + _tw, _curr_y + _th)) {
            selected_option = i;
        }

        draw_set_colour((selected_option == i) ? c_orange : c_white);
        draw_text(_draw_x, _curr_y, _option_text);
        
        if (selected_option == i && mouse_check_button_pressed(mb_left)) {
            response = true;
            handle_question_choice(_str.dialog[current_message].choice, i);
        }
    }
}