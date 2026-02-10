if (global.time_is_paused) exit; 

// 1. Passagem do Tempo
real_time_accumulator += delta_time / 1000000;

if (real_time_accumulator >= global.REAL_SECONDS_PER_GAME_MINUTE) {
    global.game_minute_total += 1;
    real_time_accumulator -= global.REAL_SECONDS_PER_GAME_MINUTE;

    if (global.game_minute_total >= 1440) {
        global.game_minute_total = 0;
        global.day += 1;
        global.day_of_week = (global.day_of_week + 1) mod 7;
        
        // Lógica de mês (opcional)
        if (global.day > 30) {
            global.day = 1;
            global.month += 1;
        }
    }
}

var _m = global.game_minute_total;
var _target_bg = bg_night;

if (_m >= 300 && _m < 480) {
    _target_bg = bg_dawn; // Dawn
}
else if (_m >= 480 && _m < 1020) {
    _target_bg = bg_day; // Day
}
else if (_m >= 1020 && _m < 1140) {
    _target_bg = bg_dusk; // Dusk
}
else {
    _target_bg = bg_night; // Night
}

if (layer_background_get_sprite(back_id) != _target_bg) {
    layer_background_sprite(back_id, _target_bg);
    layer_background_stretch(back_id, true); 
    
    layer_background_alpha(back_id, 1.0); 
    layer_background_blend(back_id, c_white);
}