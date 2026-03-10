draw_self();

if (can_talk && !instance_exists(obj_dialog)){
    draw_sprite(spr_talk, 0, x + 10, y - 25);
};