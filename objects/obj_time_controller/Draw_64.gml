var _gui_w = display_get_gui_width();

var _period_text = "";
var _period_color = c_white;

if (global.game_minute_total >= 360 && global.game_minute_total < 720) {
    _period_text = "Manhã";
    _period_color = make_color_rgb(255, 180, 100);
}

else if (global.game_minute_total >= 720 && global.game_minute_total < 1080) {
    _period_text = "Tarde"
    _period_color = make_color_rgb(255, 230, 100);
} 

else {
    _period_text = "Noite";
    _period_color = make_color_rgb(150, 200, 255);
}

var _month_names = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"];
var _day_names    = ["Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado", "Domingo"];

var _month_name = _month_names[global.month - 1]; 
var _day_name    = _day_names[global.day_of_week];

var _day_string = (global.day < 10) ? ("0" + string(global.day)) : string(global.day);
var _date_string = _day_name + ", " + _day_string + " " + _month_name;


draw_set_halign(fa_right);
draw_set_valign(fa_top);

var _x_pos = _gui_w - 20;
var _y_pos = 20;

draw_set_color(c_white);
draw_text(_x_pos, _y_pos, _date_string);

draw_set_color(_period_color);
draw_text(_x_pos, _y_pos + 30, _period_text);

draw_set_color(c_white);
draw_set_halign(fa_left);