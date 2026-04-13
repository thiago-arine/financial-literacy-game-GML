if (global.has_headset == true || global.quest_headset_finished == true) {
    instance_destroy(); // O item se auto-destrói antes mesmo de aparecer
}

can_collect = false;