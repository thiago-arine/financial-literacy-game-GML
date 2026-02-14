TILE_SIZE = 16;
MOVE_SPEED = 128; //Múltiplo de 16

moving = false;
target_x = x;
target_y = y;
dir_x = 0;
dir_y = 0;

tilemap = layer_tilemap_get_id("Tiles_Col"); 


x = floor(x / TILE_SIZE) * TILE_SIZE + TILE_SIZE/2;
y = floor(y / TILE_SIZE) * TILE_SIZE + TILE_SIZE/2;

global.current_idle_sprite = spr_player_idle_down;
global.reputation = 100
