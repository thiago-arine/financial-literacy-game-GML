var REAL_DAY_DURATION = 1;

var GAME_MINUTES_PER_DAY = 1080;

global.REAL_SECONDS_PER_GAME_MINUTE = REAL_DAY_DURATION / GAME_MINUTES_PER_DAY;

global.day = 1;
global.month = 1;
global.day_of_week = 0;

global.game_minute_total = 360; 

global.time_is_paused = false;

real_time_accumulator = 0;