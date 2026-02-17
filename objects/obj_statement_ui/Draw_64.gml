draw_set_color(c_black);
draw_rectangle(320, 80, 1000, 550, false);

draw_set_color(c_white);
for (var i = 0; i < 3; i++) {
    draw_rectangle(320 - i, 80 - i, 1000 + i, 550 + i, true);
}


var start_y = 110;
var start_x = 350;

for (var i = 0; i < array_length(global.statement); i++) {
    draw_set_color(c_white)
    var entry = global.statement[i];
	var text = entry.date + " | " + entry.from + " |"
	draw_text(start_x, start_y + i * 24, text);
	
	var value = "R$ " + entry.values
	if (entry.kind == "gain"){
		draw_set_colour(c_green)
	} else {
		draw_set_color(c_red)
	}
	
	draw_text(880,  start_y + i * 24 , value)
}

draw_set_color(c_white);
var y_line =  (start_y + array_length(global.statement) * 24) + 12
draw_line(350, y_line, 960, y_line)

draw_text(350, y_line + 10 , "Saldo:")
draw_text(880, y_line + 10 , "R$ "+ string(global.balance))