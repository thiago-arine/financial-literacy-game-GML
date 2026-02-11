draw_set_font(Font1); 
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var meta_text = "Não Definida";

if (variable_global_exists("meta")) {
	
    var _target_key = string(global.meta);

    if (variable_global_exists("goals")) {

        var _result = global.goals[$ _target_key];
        
        if (!is_undefined(_result)) {
            meta_text = _result;
        }
    }
}

draw_text(10, 10, "Meta Atual: " + string(meta_text));
