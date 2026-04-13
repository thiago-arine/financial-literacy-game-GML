if (global.has_kite == true || global.quest_kite_finished == true) {
    instance_destroy(); // O item se auto-destrói antes mesmo de aparecer
}

can_collect = false;