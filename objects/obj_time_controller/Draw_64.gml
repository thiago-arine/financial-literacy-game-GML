var _gui_w = display_get_gui_width();

var _month_names = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"];
var _day_names   = ["Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado", "Domingo"];
var _date_string = _day_names[global.day_of_week] + ", " + string(global.day) + " de " + _month_names[global.month - 1];

draw_set_halign(fa_right);
draw_set_valign(fa_top);

draw_set_color(c_black);
draw_text(_gui_w - 19, 21, _date_string);
draw_set_color(c_white);
draw_text(_gui_w - 20, 20, _date_string);

var _icon_x = _gui_w - 160;
var _icon_y = 30;          
var _scale = 4;

if (alpha_morning > 0) {
    draw_sprite_ext(icon_morning, 0, _icon_x, _icon_y, _scale, _scale, 0, c_white, alpha_morning);
}

if (alpha_afternoon > 0) {
    draw_sprite_ext(icon_afternoon, 0, _icon_x, _icon_y, _scale, _scale, 0, c_white, alpha_afternoon);
}

if (alpha_evening > 0) {
    draw_sprite_ext(icon_evening, 0, _icon_x, _icon_y, _scale, _scale, 0, c_white, alpha_evening);
}

draw_set_halign(fa_left);