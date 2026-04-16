if (inventory_open) {
    draw_set_color(c_white);
    
    var size = 80;
    var total_width = invMaxX * size;
    var total_height = invMaxY * size;
    
    var xx = (display_get_gui_width() / 2) - (total_width / 2);
    var yy = (display_get_gui_height() / 2) - (total_height / 2);
    
    for(var i=0; i<invMaxX; i++){
        for(var j=0; j<invMaxY; j++){
            var posX = xx + (size * i);
            var posY = yy + (size * j);
            
            draw_rectangle(posX, posY, posX + size, posY + size, true);
            
            if (is_array(inv[i][j])) {
                var _item_id = inv[i][j][4]; 
                var _item_info = get_item_data(_item_id);
                
                var _sprite = inv[i][j][0];
                var _index  = inv[i][j][1];
                
                if (sprite_exists(_sprite)) {
                    var _sw = sprite_get_width(_sprite);
                    var _scale = size / _sw;
                    
                    draw_sprite_ext(_sprite, _index, posX, posY, _scale, _scale, 0, c_white, 1);
                }
            }
        }
    }
}
