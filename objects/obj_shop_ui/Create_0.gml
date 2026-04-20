global.time_is_paused = true;
shop_open = true
depth = -5000; // Garante que a loja está na frente de TUDO
keyboard_clear(vk_space); // Limpa o buffer para não comprar sem querer ao abrir
keyboard_clear(vk_enter);

menu_mode = 0; // 0 = Comprar, 1 = Vender
sell_items = [];
sell_price_multiplier = 0.5; // Itens são vendidos por 50% do valor 

gui_w = display_get_gui_width();
gui_h = display_get_gui_height();
shop_w = 500;
shop_h = 350;
start_x = (gui_w - shop_w) / 2;
start_y = (gui_h - shop_h) / 2;

shop_items = [
    { id: "screwdriver", price: 8,  object: obj_item_screwdriver }
];

selected = 0;
buy_timer = 0;