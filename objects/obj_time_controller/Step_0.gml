//delta_time é em nanosegundos
real_time_accumulator += delta_time / 1000000;

if (real_time_accumulator >= global.REAL_SECONDS_PER_GAME_MINUTE) {

    global.game_minute_total += 1;
    real_time_accumulator -= global.REAL_SECONDS_PER_GAME_MINUTE;

    if (global.game_minute_total >= 1440) {
        
        global.day += 1;
        global.day_of_week = (global.day_of_week + 1) mod 7;
        
        if (global.day > 30) {
            global.day = 1;
            global.month += 1;
            
            if (global.month > 12) {
                global.month = 1;
            }
        }

        global.game_minute_total = 360; 
    }
}