draw_set_alpha(1.0);
draw_set_color(c_white);

var _cx = camera_get_view_x(view_camera[0]);
var _cy = camera_get_view_y(view_camera[0]);

draw_sprite(current_bg, 0, _cx, _cy);
draw_sprite_ext(next_bg, 0, _cx, _cy, 1, 1, 0, c_white, bg_alpha);