depth = -5000; // Garante que a loja está na frente de TUDO
keyboard_clear(vk_space); // Limpa o buffer para não comprar sem querer ao abrir
keyboard_clear(vk_enter);

gui_w = display_get_gui_width();
gui_h = display_get_gui_height();
shop_w = 500;
shop_h = 350;
start_x = (gui_w - shop_w) / 2;
start_y = (gui_h - shop_h) / 2;

shop_items = [
    { name: "Pipa de Papel",    price: 15,  desc: "Frágil, mas voa alto." },
    { name: "Linha de Nylon",   price: 10,  desc: "Resistente a ventos fortes." },
    { name: "Rabiola Longa",    price: 5,   desc: "Dá estabilidade à pipa." }
];

selected = 0;
buy_timer = 0;