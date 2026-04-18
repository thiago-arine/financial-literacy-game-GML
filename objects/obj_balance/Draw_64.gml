draw_set_font(Font1); 
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_text(10, 50, "Saldo: R$" + string_format(global.balance, 0, 2));

// --- feedback visual de recompensa ---
if (global.reward_alpha > 0) {
    draw_set_color(c_green);
    draw_set_alpha(min(global.reward_alpha, 1)); // Garante que o alpha não passe de 1
    
    var _txt = "+ R$" + string_format(global.draw_reward_value, 0, 2);
    draw_text(62, 75, _txt);
    
    // Diminui o alpha gradualmente para o efeito de "fade out"
    global.reward_alpha -= 0.01; 
    
    draw_set_alpha(1); // Reseta o alpha para não afetar outros desenhos
}