var _gui_h = display_get_gui_height();
var _center_y = _gui_h / 2;
var _total_height = array_length(hints) * 40;
var _draw_x = 30;
var _draw_y = _center_y - (_total_height / 2);
var _spacing = 50;

draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_font(Font1);

pulse_timer += 0.05;
var _alpha_pulse = 0.8 + sin(pulse_timer) * 0.2;

for (var i = 0; i < array_length(hints); i++) {
    var _key = hints[i][0];
    var _action = hints[i][1];
    var _text = "[" + _key + "] " + _action;
    
    var _text_w = string_width(_text);
    var _text_h = string_height(_text);
    
    draw_set_alpha(0.5);
    draw_set_color(c_black);
    draw_roundrect(_draw_x - 5, _draw_y - (_text_h/2) - 5, _draw_x + _text_w + 10, _draw_y + (_text_h/2) + 5, false);
    
    draw_set_alpha(_alpha_pulse);
    draw_set_color(c_white);
    draw_text(_draw_x, _draw_y, _text);
    
    _draw_y += _spacing;
}

draw_set_alpha(1);
draw_set_color(c_white);