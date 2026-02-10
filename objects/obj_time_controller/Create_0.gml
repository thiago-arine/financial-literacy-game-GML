// --- Configurações de Tempo ---
var REAL_DAY_DURATION = 60; // 60 segundos reais = 1 dia no jogo (ajuste aqui)
var GAME_MINUTES_PER_DAY = 1440; 
global.REAL_SECONDS_PER_GAME_MINUTE = REAL_DAY_DURATION / GAME_MINUTES_PER_DAY;

global.day = 1;
global.month = 1;
global.day_of_week = 0;
global.game_minute_total = 360; // Começa às 06:00
global.time_is_paused = false;
real_time_accumulator = 0;

// --- Sistema de Background ---
bg_night = spr_bg_night; 
bg_dawn = spr_bg_dawn;  
bg_day = spr_bg_day;   
bg_dusk = spr_bg_dusk;  

// Variáveis de controle de transição
bg_alpha = 1.0; 

// Pegar IDs da Layer (O nome deve ser EXATAMENTE "Background" no Room Editor)
var _lay_id = layer_get_id("Background");
back_id = layer_background_get_id(_lay_id);