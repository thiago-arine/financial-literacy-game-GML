TILE_SIZE = 16;
MOVE_SPEED = 100;

moving = false;
target_x = x;
target_y = y;
dir_x = 0;
dir_y = 0;

tilemap = layer_tilemap_get_id("Tiles_Col"); 

x = round(x / TILE_SIZE) * TILE_SIZE;
y = round(y / TILE_SIZE) * TILE_SIZE;

global.current_idle_sprite = spr_player_idle_down;