var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

// tamanho do frame escalado
var frame_w = sprite_get_width(spr_reputation_bar) ;
var frame_h = sprite_get_height(spr_reputation_bar);

var bottom_x = gui_w - frame_w - margin;
var bottom_y = gui_h - margin;

display_value = lerp(display_value, global.reputation, 0.1);


draw_sprite_ext(
    spr_reputation_bar,
    0,
    bottom_x ,
    bottom_y,
    2,
    4,
    0,
    c_white,
    1
);

draw_sprite_ext(
    spr_reputation_bar2,
    0,
    bottom_x,
    bottom_y,
    2,
    (global.reputation/100) * 4,
    0,
    c_white,
    1
);
