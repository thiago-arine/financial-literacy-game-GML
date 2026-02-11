var _gui_w = display_get_gui_width();

var _month_names = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"];
var _day_names   = ["Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado", "Domingo"];
var _date_string = _day_names[global.day_of_week] + ", " + string(global.day) + " de " + _month_names[global.month - 1];

var _period_text = "Noite";
var _period_color = c_aqua;
var _m = global.game_minute_total;

if (_m >= 300 && _m < 720) {
    _period_text = "Manhã"; _period_color = c_orange;
} else if (_m >= 720 && _m < 1140) {
    _period_text = "Tarde"; _period_color = c_yellow;
}

draw_set_halign(fa_right);
draw_set_valign(fa_top);

draw_set_color(c_black);
draw_text(_gui_w - 19, 21, _date_string);

draw_set_color(c_white);
draw_text(_gui_w - 20, 20, _date_string);

draw_set_color(_period_color);
draw_text(_gui_w - 20, 50, _period_text);

draw_set_color(c_white);
draw_set_halign(fa_left);