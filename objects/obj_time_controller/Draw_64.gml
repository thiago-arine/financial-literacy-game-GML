var _gui_w = display_get_gui_width();

draw_set_font(Font_Medium)

var _month_names = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"];
var _day_names   = ["Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado", "Domingo"];
var _date_string = _month_names[global.month - 1];

draw_set_halign(fa_right);
draw_set_valign(fa_top);

draw_set_color(c_black);
draw_text(_gui_w - 19, 166, _date_string);
draw_set_color(c_white);
draw_text(_gui_w - 20, 165, _date_string);

var _icon_x = _gui_w - 230;
var _icon_y = 0;          
var _scale = 6;

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

// --- DESENHAR BANNER DE TRANSIÇÃO DE DIA ---
if (banner_alpha > 0) {
    // Usamos o banner_alpha (limitado a 1.0)
    draw_set_alpha(clamp(banner_alpha, 0, 1));
    
    var _months = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"];
    var _week = ((global.day - 1) div 7) + 1;
    var _banner_text = _months[global.month - 1] + "(" + string(global.month) + "/3) ";
    
    draw_set_font(Font_Banner); 
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var _center_x = display_get_gui_width() / 2;
    var _center_y = display_get_gui_height() / 2 - 400;
    
    // Desenha Sombra
    draw_set_color(c_black);
    draw_text(_center_x + 2, _center_y + 2, _banner_text);
    
    // Desenha Texto Principal
    draw_set_color(c_white);
    draw_text(_center_x, _center_y, _banner_text);
    
    // IMPORTANTE: Resetar sempre
    draw_set_alpha(1.0);
    draw_set_halign(fa_left); // Volta para o padrão do seu jogo
    draw_set_valign(fa_top);
}