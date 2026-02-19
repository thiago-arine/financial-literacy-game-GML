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

var _target_bg = bg_night;
if (_m >= 300 && _m < 480)       _target_bg = bg_dawn;
else if (_m >= 480 && _m < 960)  _target_bg = bg_day;
else if (_m >= 960 && _m < 1080) _target_bg = bg_sunset;
else if (_m >= 1080 && _m < 1200) _target_bg = bg_dusk;
else                             _target_bg = bg_night;

if (next_bg != _target_bg) {
    current_bg = next_bg;
    next_bg = _target_bg;
    bg_alpha = 0;
}
if (bg_alpha < 1) bg_alpha += 0.005;

var _t_morning   = (_m >= 300 && _m < 720)  ? 1 : 0;
var _t_afternoon = (_m >= 720 && _m < 1080) ? 1 : 0;
var _t_evening   = (_m >= 1080 || _m < 300) ? 1 : 0;

alpha_morning   = lerp(alpha_morning,   _t_morning,   0.05);
alpha_afternoon = lerp(alpha_afternoon, _t_afternoon, 0.05);
alpha_evening   = lerp(alpha_evening,   _t_evening,   0.05);