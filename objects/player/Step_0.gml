if (instance_exists(obj_dialog)) exit;
if (instance_exists(obj_statement_ui)) exit;



if (!moving) {
    handle_input();
} 
if (moving) {
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

        var next_x = x + dir_x * TILE_SIZE;
        var next_y = y + dir_y * TILE_SIZE;

        var half = TILE_SIZE / 2 - 1;

        var check1_x, check1_y;
        var check2_x, check2_y;

        if (dir_x != 0) {
            check1_x = next_x + dir_x * half;
            check1_y = next_y - half;

            check2_x = next_x + dir_x * half;
            check2_y = next_y + half;
        }

        if (dir_y != 0) {
            check1_x = next_x - half;
            check1_y = next_y + dir_y * half;

            check2_x = next_x + half;
            check2_y = next_y + dir_y * half;
        }

        var tile1 = tilemap_get_at_pixel(tilemap, check1_x, check1_y);
        var tile2 = tilemap_get_at_pixel(tilemap, check2_x, check2_y);

        if (tile1 == 0 && tile2 == 0) {

            target_x = next_x;
            target_y = next_y;
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
        } else {
			if(room == rm_city){
				show_debug_message(tilemap)
				show_debug_message("Não passou em check tile, player não se move")
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

    var dx = target_x - x;
    var dy = target_y - y;

    if (dx != 0) {
        var step = sign(dx) * move_distance;
        if (abs(step) >= abs(dx)) {
            x = target_x;
        } else {
            x += step;
        }

    } else if (dy != 0) {
        var step = sign(dy) * move_distance;
        if (abs(step) >= abs(dy)) {
            y = target_y;
        } else {
            y += step;
        }
    }

    if (x == target_x && y == target_y) {
        moving = false;
    }
}

