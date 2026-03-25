if (global.time_is_paused) exit; 

real_time_accumulator += delta_time / 1000000;

if (real_time_accumulator >= global.REAL_SECONDS_PER_GAME_MINUTE) {
    global.game_minute_total += 1;
    real_time_accumulator -= global.REAL_SECONDS_PER_GAME_MINUTE;
    
    // Passagem de Dia
    if (global.game_minute_total >= 1440) {
        global.game_minute_total = 0;
        global.day += 1;
        global.day_of_week = (global.day_of_week + 1) mod 7;

        if (global.day > 30) {
            global.day = 1;
            global.month += 1;
            
            if (global.month > 12) {
                global.month = 1;
            }
        }
    }
}

var _m = global.game_minute_total;
var _t_morning   = (_m >= 300 && _m < 720)  ? 1 : 0;
var _t_afternoon = (_m >= 720 && _m < 1080) ? 1 : 0;
var _t_evening   = (_m >= 1080 || _m < 300) ? 1 : 0;

alpha_morning   = lerp(alpha_morning,   _t_morning,   0.05);
alpha_afternoon = lerp(alpha_afternoon, _t_afternoon, 0.05);
alpha_evening   = lerp(alpha_evening,   _t_evening,   0.05);