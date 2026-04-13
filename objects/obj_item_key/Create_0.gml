if (global.has_key == true || global.quest_key_finished == true) {
    instance_destroy(); // O item se auto-destrói antes mesmo de aparecer
}

can_collect = false;