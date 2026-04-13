draw_self(); 

if (can_collect) {
    var _escala = 0.75; 
    
    draw_sprite_ext(spr_spacebar_input, 0, x + 10, y - 6, _escala, _escala, 0 , c_white, 1);
}