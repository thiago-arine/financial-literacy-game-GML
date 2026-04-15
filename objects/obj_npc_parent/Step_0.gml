event_inherited();

// 1. TRAVAS DE SEGURANÇA (Impede abrir diálogo sobreposto)
if (instance_exists(obj_dialog)) exit;
if (instance_exists(obj_statement_ui) && obj_statement_ui.statement_open) exit;
if (instance_exists(obj_shop_ui)) {
    if (obj_shop_ui.shop_open) {
        can_talk = false;
        exit; 
    }
}

// 2. VERIFICAÇÃO DE DISTÂNCIA
if (instance_exists(player) && distance_to_object(player) < 12) { // Aumentei um pouco a margem (12)
    can_talk = true;
    
    if (keyboard_check_pressed(input_key)) {
        global.time_is_paused = true;
        
        // LÓGICA ESPECÍFICA DO MENTOR
        if (object_get_name(object_index) == "obj_npc_mentor") {
            // Verifica se a meta 1 está ativa e se tem saldo
            if (global.meta == 1 && global.balance >= 100) {
                create_dialog(global.dialog_mentor_transicao_fase);
                exit; // Interrompe para não abrir o diálogo padrão abaixo
            }
        }
        
        // LÓGICA ESPECÍFICA DO AMIGO (Só roda se este NPC for o Amigo)
        if (object_get_name(object_index) == "obj_npc_amigo") {
            var _has_key = variable_global_exists("has_key") && global.has_key;
            var _finished = variable_global_exists("quest_key_finished") && global.quest_key_finished;

            if (_has_key && !_finished) {
                create_dialog(global.dialog_amigo_completou);
                exit; // Sai para não rodar o create_dialog(dialog) abaixo
            }
        }
        if (object_get_name(object_index) == "obj_npc_influencer") {
            var _has_headset = variable_global_exists("has_headset") && global.has_headset;
            var _finished = variable_global_exists("quest_headset_finished") && global.quest_headset_finished;

            if (_has_headset && !_finished) {
                create_dialog(global.dialog_influencer_completou);
                exit; // Sai para não rodar o create_dialog(dialog) abaixo
            }
        }
        if (object_get_name(object_index) == "obj_npc_shopkeeper") {
            var _has_kite = variable_global_exists("has_kite") && global.has_kite;
            var _finished = variable_global_exists("quest_kite_finished") && global.quest_kite_finished;

            if (_has_kite && !_finished) {
                create_dialog(global.dialog_shopkeeper_completou);
                exit; // Sai para não rodar o create_dialog(dialog) abaixo
            }
        }
        if (object_get_name(object_index) == "obj_npc_shopkeeper") {
            var _has_screwdriver = variable_global_exists("has_screwdriver") && global.has_screwdriver;
            var _finished = variable_global_exists("quest_screwdriver_finished") && global.quest_screwdriver_finished;

            //if (_has_screwdriver && !_finished) {
            //    create_dialog(global.dialog_shopkeeper_completou);
            //    exit; // Sai para não rodar o create_dialog(dialog) abaixo
            //}
            
            ///if (_has_screwdriver && !_finished_screw) {
             //   create_dialog(global.dialog_shopkeeper_com); // Crie um diálogo específico para a chave se quiser
             //   exit;
            ///}
        }
        
        // LÓGICA PARA TODOS OS OUTROS (Mentor, Sorveteiro, etc)
        if (variable_instance_exists(id, "dialog")) {
            create_dialog(dialog);
        } else {
            show_debug_message("ERRO: Este NPC não tem um diálogo definido no Create!");
        }
    }
} else {
    can_talk = false;
}