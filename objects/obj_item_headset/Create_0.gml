event_inherited(); // Puxa as variáveis do pai
item_name = "Headset";
item_sprite = spr_item_headset;
item_type = "special";

// Trava de persistência (Se já tem ou terminou a quest, some)
if (global.has_headset || global.quest_headset_finished) 
    instance_destroy();