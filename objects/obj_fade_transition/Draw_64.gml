if (fade_state != 0) {
    draw_set_alpha(fade_alpha);
    draw_set_color(color);
    
    // Desenha um retângulo cobrindo toda a interface
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    
    draw_set_alpha(1.0); // Reseta o alpha para não afetar outros draws
}