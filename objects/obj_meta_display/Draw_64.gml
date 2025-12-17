draw_set_font(Font1); // ou sua fonte preferida
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var target_key = string(global.meta);
var meta_text = "Meta não encontrada";

if (variable_struct_exists(goals, target_key)) {
    meta_text = goals[$ target_key];
}
draw_text(10, 10, "Meta: " + string(meta_text));
