event_inherited(); // Puxa as variáveis do pai
item_id = "kite";
item_display_name = "Pipa";
item_sprite = spr_item_kite;
item_type = "special";

// Trava de persistência (Se já tem ou terminou a quest, some)
if (global.has_kite || global.quest_kite_finished) 
    instance_destroy();