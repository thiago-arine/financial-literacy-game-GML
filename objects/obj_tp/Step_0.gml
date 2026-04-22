// Se o diálogo não existe mais e o player se moveu um pouco para longe (ex: 5 pixels)
if (!instance_exists(obj_dialog)) {
    if (distance_to_object(player) > 5) {
        has_warned = false;
    }
}