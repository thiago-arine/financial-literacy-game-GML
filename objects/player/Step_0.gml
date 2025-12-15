if (instance_exists(obj_dialog)) exit;

if (!moving) {
    handle_input();
} 
else {
    move_to_target();
}

function handle_input() {

    var input_dir_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
    var input_dir_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));
	
    if (input_dir_x != 0 || input_dir_y != 0) {
        
        if (input_dir_y != 0) {
            dir_x = 0;
            dir_y = input_dir_y;
        } else {
            dir_x = input_dir_x;
            dir_y = 0;
        }

        var _next_target_x = x + dir_x * TILE_SIZE;
        var _next_target_y = y + dir_y * TILE_SIZE;

        if (tilemap_get_at_pixel(tilemap, _next_target_x, _next_target_y) == 0) {

            target_x = _next_target_x;
            target_y = _next_target_y;
            moving = true;

            if (dir_y < 0) {
                sprite_index = spr_player_walk_up;
                global.current_idle_sprite = spr_player_idle_up;
            } else if (dir_y > 0) {
                sprite_index = spr_player_walk_down;
                global.current_idle_sprite = spr_player_idle_down;
            } else if (dir_x < 0) {
                sprite_index = spr_player_walk_left;
                global.current_idle_sprite = spr_player_idle_left;
            } else if (dir_x > 0) {
                sprite_index = spr_player_walk_right;
                global.current_idle_sprite = spr_player_idle_right;
            }
        }
    }
    else {
        sprite_index = global.current_idle_sprite;
    }
}

function move_to_target() {
    var dt = delta_time / 1000000; 

    var move_distance = MOVE_SPEED * dt;
    
    var move_vector_x = (target_x - x) / point_distance(x, y, target_x, target_y);
    var move_vector_y = (target_y - y) / point_distance(x, y, target_x, target_y);
    
    if (point_distance(x, y, target_x, target_y) <= move_distance) {
        x = target_x;
        y = target_y;
        moving = false;
    } else {
        x += move_vector_x * move_distance;
        y += move_vector_y * move_distance;
		
		x = round(x);
        y = round(y);
    }
}