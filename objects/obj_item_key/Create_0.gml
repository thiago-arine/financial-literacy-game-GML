event_inherited(); // Puxa as variáveis do pai
item_name = "Key";
item_sprite = spr_item_key;
item_type = "special";

// Trava de persistência (Se já tem ou terminou a quest, some)
if (global.has_key || global.quest_key_finished) 
    instance_destroy();