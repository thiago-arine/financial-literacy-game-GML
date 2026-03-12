inventory_open = false;
invMaxX = 6;
invMaxY = 3;

inv = array_create(invMaxX);
for(var i=0; i<invMaxX; i++){
    inv[i] = array_create(invMaxY, -1);
}

inv[0][1] = [spr_enemy1, 0, 1, -1, "teste1"];
inv[1][1] = [spr_enemy2, 1, 1, -1, "teste2"];
