// --- Configurações de Tempo ---
var REAL_DAY_DURATION = 90; 
var GAME_MINUTES_PER_DAY = 1440; 
global.REAL_SECONDS_PER_GAME_MINUTE = REAL_DAY_DURATION / GAME_MINUTES_PER_DAY;

global.day = 1;
global.month = 1;
global.day_of_week = 0;
global.game_minute_total = 360; 
global.time_is_paused = false;
real_time_accumulator = 0;

icon_morning   = spr_timer_morning;
icon_afternoon = spr_timer_afternoon;
icon_evening   = spr_timer_evening;

alpha_morning   = 0;
alpha_afternoon = 0;
alpha_evening   = 0;

is_fading = false; // transição de dia
banner_alpha = 0; //Título pós transição