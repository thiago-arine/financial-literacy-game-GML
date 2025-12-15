var _dx = 0;
var _dy = gui_h * 0.7;
var _boxw = gui_w;
var _boxh = gui_h - _dy;

draw_sprite_stretched(spr_box, 0, _dx, _dy, _boxw, _boxh);

_dx += 16;
_dy += 16;

draw_set_font(Font1);
var _name = messages[current_message].name;

draw_set_colour(global.char_colors[$ _name]);

draw_text(_dx, _dy, _name);

draw_set_colour(c_white);

_dy += 40;

draw_text_ext(_dx, _dy, draw_message, -1, _boxw - _dx * 2);

if (messages[current_message].is_question == true) {
    var _y = y_position;
    for (var i = 0; i < array_length(messages[current_message].options); i++) {
		draw_set_colour(c_black)
        draw_text(x_position, _y, "> " + messages[current_message].options[i]);
   
        // Verificar clique (exemplo simplificado)
        var mx = device_mouse_x_to_gui(0);
        var my = device_mouse_y_to_gui(0);
        
        if (point_in_rectangle(mx, my, x_position, _y, x_position + 200, _y + 20)) {

            if (mouse_check_button_pressed(mb_left)) {
				switch(messages[current_message].choice){
					case "meta": 
						global.meta = messages[current_message].option_results[i]; // 1 = celular, 2 = viagem, 3 = intercâmbio
						show_debug_message("Definição da meta")
						response = true
						break;
				}
				
            }
        }
        
        _y += 25;
    }
}
