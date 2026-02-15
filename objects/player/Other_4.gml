moving = false;
target_x = x;
target_y = y;
dir_x = 0;
dir_y = 0;

tilemap = layer_tilemap_get_id("Tiles_Col"); 

x = floor(x / TILE_SIZE) * TILE_SIZE + TILE_SIZE/2;
y = floor(y / TILE_SIZE) * TILE_SIZE + TILE_SIZE/2;
