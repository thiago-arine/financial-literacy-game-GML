draw_set_font(Font1); 
draw_set_color(c_white);
draw_set_halign(fa_left);

var _txt = "Não Definida";

// 1. Verificamos se a variável global existe e se não é 0
if (variable_global_exists("meta")) {
    var _valor = global.meta;
    
    if (_valor > 0) {
        // 2. Convertemos o número para string para usar como chave na struct
        var _chave = string(_valor);
        
        // 3. Verificamos se a struct de metas existe
        if (variable_global_exists("goals")) {
            // Usamos o acessor $ para buscar o texto (Ex: global.goals[$ "3"])
            var _busca = global.goals[$ _chave];
            
            if (!is_undefined(_busca)) {
                _txt = _busca;
            }
        }
    }
}

draw_text(10, 10, "Meta Atual: " + _txt);