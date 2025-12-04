if (instance_exists(player) && distance_to_object(player) < distance_to_player){
    target_x = player.x;
    target_y = player.y;
}
else{
    target_x = random_range(xstart - 100, xstart + 100);
    target_y = random_range(ystart - 100, ystart + 100);
}

alarm[0] = 60;