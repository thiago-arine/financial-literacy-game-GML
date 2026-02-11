if (global.time_is_paused) exit; 

real_time_accumulator += delta_time / 1000000;
if (real_time_accumulator >= global.REAL_SECONDS_PER_GAME_MINUTE) {
    global.game_minute_total += 1;
    real_time_accumulator -= global.REAL_SECONDS_PER_GAME_MINUTE;
    if (global.game_minute_total >= 1440) {
        global.game_minute_total = 0;
        global.day += 1;
        global.day_of_week = (global.day_of_week + 1) mod 7;
    }
}

var _m = global.game_minute_total;
var _target = bg_night;

if (_m >= 300 && _m < 480)       _target = bg_dawn;   // 05:00 - 08:00
else if (_m >= 480 && _m < 960)  _target = bg_day;    // 08:00 - 16:00
else if (_m >= 960 && _m < 1080) _target = bg_sunset; // 16:00 - 18:00
else if (_m >= 1080 && _m < 1200) _target = bg_dusk;   // 18:00 - 20:00
else                             _target = bg_night;  

if (next_bg != _target) {
    current_bg = next_bg;
    next_bg = _target;
    bg_alpha = 0;
}

if (bg_alpha < 1) {
    bg_alpha += 0.005;
}