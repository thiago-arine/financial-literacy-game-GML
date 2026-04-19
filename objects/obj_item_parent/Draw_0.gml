// Draw_0.gml
var _is_visible = true;
if (item_type == "special") {
    if (item_id == "kite" && !global.quest_kite_started) _is_visible = false;
    if (item_id == "headset" && !global.quest_headset_started) _is_visible = false;
    if (item_id == "key" && !global.quest_key_started) _is_visible = false;
    // ... replicar lógica de visibilidade do Step
}

if (_is_visible) {
    draw_self(); 
    if (can_collect) {
        var _escala = 0.75;
        draw_sprite_ext(spr_spacebar_input, 0, x + 10, y - 6, _escala, _escala, 0, c_white, 1); 
    }
}