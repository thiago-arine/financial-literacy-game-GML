event_inherited();

// 1. TRAVAS DE SEGURANÇA (Impede abrir diálogo sobreposto)
if (instance_exists(obj_dialog)) exit;
if (instance_exists(obj_statement_ui) && obj_statement_ui.statement_open) exit;

// 2. VERIFICAÇÃO DE DISTÂNCIA
if (instance_exists(player) && distance_to_object(player) < 12) { // Aumentei um pouco a margem (12)
    can_talk = true;
    
    if (keyboard_check_pressed(input_key)) {
        global.time_is_paused = true;
        
        // LÓGICA ESPECÍFICA DO AMIGO (Só roda se este NPC for o Amigo)
        if (object_get_name(object_index) == "obj_npc_amigo") {
            var _has_key = variable_global_exists("has_key") && global.has_key;
            var _finished = variable_global_exists("quest_key_finished") && global.quest_key_finished;

            if (_has_key && !_finished) {
                create_dialog(global.dialog_amigo_completou);
                exit; // Sai para não rodar o create_dialog(dialog) abaixo
            }
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