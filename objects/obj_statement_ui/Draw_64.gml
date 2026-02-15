draw_set_color(c_black);
draw_rectangle(100, 50, 700, 550, false);

draw_set_color(c_white);

var start_y = 80;

for (var i = 0; i < array_length(global.statement); i++) {
    
    var entry = global.statement[i];

    var text = entry.date + " | " + entry.from + " | $" + string(entry.values);

    draw_text(120, start_y + i * 24, text);
}
