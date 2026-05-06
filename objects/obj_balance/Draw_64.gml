// --- CONFIGURAÇÕES BASE ---
draw_set_font(Font_Medium);
draw_set_halign(fa_left);
draw_set_valign(fa_top); // Voltamos para top para facilitar o cálculo do fundo

var _hud_x = 30;
var _hud_y = 50;
var _text_saldo = "Saldo: R$" + string_format(global.balance, 0, 2);

// Medidas para o fundo
var _tw = string_width(_text_saldo);
var _th = string_height(_text_saldo);
var _pad = 10;

// --- 1. DESENHO DO FUNDO (Padrão das Hints) ---
draw_set_alpha(0.5);
draw_set_color(c_black);
// Desenha o retângulo arredondado atrás do saldo
draw_roundrect(_hud_x - _pad, _hud_y - _pad, _hud_x + _tw + _pad, _hud_y + _th + _pad, false);

// --- 2. DESENHA O SALDO ---
draw_set_alpha(1);
// Sombra projetada para legibilidade extra
draw_set_color(c_black);
draw_text(_hud_x + 2, _hud_y + 2, _text_saldo);

draw_set_color(c_white);
draw_text(_hud_x, _hud_y, _text_saldo);

// --- 3. FEEDBACK DE RECOMPENSA (COM FLUTUAÇÃO) ---
if (global.reward_alpha > 0) {
    // O texto sobe conforme desaparece
    var _float_up = (1 - global.reward_alpha) * 40;
    var _rx = _hud_x + 10; // Leve recuo à direita
    var _ry = (_hud_y + _th + 15) - _float_up; // Começa abaixo do fundo do saldo
    
    var _txt_reward = "+ R$" + string_format(global.draw_reward_value, 0, 2);
    
    // Fundo para a recompensa (opcional, mas mantém o estilo)
    var _rw = string_width(_txt_reward);
    var _rh = string_height(_txt_reward);
    
    draw_set_alpha(global.reward_alpha * 0.5);
    draw_set_color(c_black);
    draw_roundrect(_rx - 5, _ry - 5, _rx + _rw + 5, _ry + _rh + 5, false);
    
    // Texto da recompensa
    draw_set_alpha(global.reward_alpha);
    draw_set_color(c_lime);
    draw_text(_rx, _ry, _txt_reward);
    
    // Fade out
    global.reward_alpha -= 0.015;
}

// --- RESET FINAL ---
draw_set_alpha(1);
draw_set_color(c_white);