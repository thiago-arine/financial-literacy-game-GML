if(!global.time_is_paused){
    real_time_accumulator += delta_time / 1000000;
    
    // 1. LÓGICA DO RELÓGIO (Sempre dentro do acumulador)
    if (real_time_accumulator >= global.REAL_SECONDS_PER_GAME_MINUTE) {
        global.game_minute_total += 1;
        real_time_accumulator -= global.REAL_SECONDS_PER_GAME_MINUTE;
        
        // Dispara o fade apenas na meia-noite
        if (global.game_minute_total >= 1440) {
            if (!is_fading) {
                is_fading = true;
                var inst = instance_create_depth(0, 0, -9999, obj_fade_transition);
                inst.fade_state = 1; 
            }
        }
    }
}

// 2. LÓGICA DO FADE (Deve ficar fora do if do acumulador para ser suave)
if (is_fading) {
    var fade_inst = instance_find(obj_fade_transition, 0);
    
    // Duração de fade
    if (instance_exists(fade_inst)) {
        if (fade_inst.fade_state == 1) { // Estado 1: Escurecendo
            fade_inst.fade_alpha += (delta_time / 1000000) / 3.0; 
                   
            if (fade_inst.fade_alpha >= 1) {
                fade_inst.fade_alpha = 1;
                
                // Mudança de data no ápice da transição
                global.game_minute_total = 360; 
                global.month += 1;
                if (global.month > 12) global.month = 1;
                    
                banner_alpha = 2.0;
                fade_inst.fade_state = 2; 
            }
        }
    }
}

// 3. CLAREAR A TELA
var fade_inst = instance_find(obj_fade_transition, 0);

// Lógica do Banner (Mover para fora do if do fade_inst)
if (banner_alpha > 0) {
    // Reduz o alpha independente do objeto de fade existir ou não
    banner_alpha -= (delta_time / 1000000) / 2.0; 
}

// Lógica do Objeto de Fade
if (instance_exists(fade_inst) && fade_inst.fade_state == 2) {
    fade_inst.fade_alpha -= (delta_time / 1000000) / 3.0;
    
    if (fade_inst.fade_alpha <= 0) {
        fade_inst.fade_alpha = 0;
        
        // SÓ mude is_fading para false quando o fade sumir E o banner também
        // Isso garante que a UI só destrave quando tudo sumir
        if (banner_alpha <= 0) {
            is_fading = false;
            global.time_is_paused = false; 
            instance_destroy(fade_inst);
        }
    }
} else if (!instance_exists(fade_inst) && banner_alpha <= 0) {
    // Segurança extra: se por algum motivo o fade sumir, garanta que destrava
    is_fading = false;
}

// 4. ATUALIZAÇÃO DOS ÍCONES (Manhã, Tarde, Noite)
var _m = global.game_minute_total;
var _t_morning   = (_m >= 0 && _m < 480)  ? 1 : 0;
var _t_afternoon = (_m >= 480 && _m < 960) ? 1 : 0;
var _t_evening   = (_m >= 960 && _m < 1440) ? 1 : 0;

alpha_morning   = lerp(alpha_morning,   _t_morning,   0.05);
alpha_afternoon = lerp(alpha_afternoon, _t_afternoon, 0.05);
alpha_evening   = lerp(alpha_evening,   _t_evening,   0.05);