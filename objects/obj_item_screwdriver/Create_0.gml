if (global.has_screwdriver == true || global.quest_screwdriver_finished == true) {
    instance_destroy(); // O item se auto-destrói antes mesmo de aparecer
}

can_collect = false;