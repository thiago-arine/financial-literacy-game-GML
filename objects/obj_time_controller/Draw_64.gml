var _gui_w = display_get_gui_width();

// --- Lógica de Texto de Data e Período ---
var _month_names = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"];
var _day_names   = ["Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado", "Domingo"];

var _date_string = _day_names[global.day_of_week] + ", " + string(global.day) + " de " + _month_names[global.month - 1];

// Cores do Período
var _period_text = "Noite";
var _period_color = make_color_rgb(150, 200, 255);

if (global.game_minute_total >= 300 && global.game_minute_total < 720) {
    _period_text = "Manhã"; _period_color = make_color_rgb(255, 180, 100);
} else if (global.game_minute_total >= 720 && global.game_minute_total < 1080) {
    _period_text = "Tarde"; _period_color = make_color_rgb(255, 230, 100);
}

draw_set_halign(fa_right);
draw_text(_gui_w - 20, 20, _date_string);
draw_set_color(_period_color);
draw_text(_gui_w - 20, 50, _period_text);
draw_set_color(c_white);