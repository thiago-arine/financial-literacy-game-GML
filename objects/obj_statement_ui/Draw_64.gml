if (statement_open) {
    draw_set_alpha(1); 

    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    var _w = 680;
    var _h = 470;

    var _center_x = _gui_w / 2;
    var _center_y = _gui_h / 2;

    var _x1 = _center_x - (_w / 2);
    var _y1 = _center_y - (_h / 2);
    var _x2 = _x1 + _w;
    var _y2 = _y1 + _h;

    // 2. Fundo e Borda Tripla
    draw_set_color(c_black);
    draw_rectangle(_x1, _y1, _x2, _y2, false);

    draw_set_color(c_white);
    for (var i = 0; i < 3; i++) {
        draw_rectangle(_x1 - i, _y1 - i, _x2 + i, _y2 + i, true);
    }

    if (!is_array(global.statement)) exit;

    var start_x = _x1 + 30;
    var start_y = _y1 + 30;
    var right_align_x = _x2 - 120;

    for (var i = 0; i < array_length(global.statement); i++) {
        var entry = global.statement[i];
        if (!is_struct(entry)) continue;

        var _yy = start_y + (i * 24);

        draw_set_color(c_white);
        var text_header = string(entry.date) + " | " + string(entry.from) + " |";
        draw_text(start_x, _yy, text_header);

        var value_color = (entry.kind == "gain") ? c_green : c_red;
        draw_set_color(value_color);
        draw_text(right_align_x, _yy, "R$ " + string(entry.values));
    }

    draw_set_color(c_white);
    var y_line = (start_y + (array_length(global.statement) * 24)) + 12;

    draw_line(start_x, y_line, _x2 - 40, y_line);

    draw_text(start_x, y_line + 10, "Saldo:");
    draw_text(right_align_x, y_line + 10, "R$ " + string(global.balance));
}