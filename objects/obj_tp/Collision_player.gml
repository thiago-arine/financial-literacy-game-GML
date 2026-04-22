// Verifica se o jogador está na sala inicial e ainda não definiu a meta
if (room == Room1 && global.meta == 0) {
    // Só cria o diálogo se ele não existir E se não tivermos avisado ainda
    if (!instance_exists(obj_dialog) && !has_warned) {
        create_dialog(global.goal_tp_block);
        has_warned = true;
    }
    exit;
}
// Se a condição acima não for atendida, o teletransporte ocorre normalmente 
room_goto(target_room); 
player.x = target_x; 
player.y = target_y;