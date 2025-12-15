var _gui_w = display_get_gui_width();

var _current_hour = floor(global.game_minute_total / 60);
var _current_minute = global.game_minute_total mod 60;

if (_current_hour == 24) {
    _current_hour = 0;
}

var _hour_string = string_format(_current_hour, 2, 0);
var _minute_string = string_format(_current_minute, 2, 0);

var _time_string = _hour_string + "h" + _minute_string;

var _month_names = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novemnbro", "Dezembro"];
var _day_names = ["Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado", "Domingo"];

var _month_name = _month_names[global.month - 1]; 
var _day_of_week_name = _day_names[global.day_of_week];

var _date_string = _day_of_week_name + "," + string_format(global.day, 2, 0) + " de " + _month_name;


draw_set_halign(fa_right);
draw_set_valign(fa_top);
draw_set_color(c_white);

var _x_pos = _gui_w - 20;
var _y_pos = 20;

draw_text(_x_pos, _y_pos, _date_string);

draw_text(_x_pos, _y_pos + 30, _time_string); 

draw_set_halign(fa_left);