state = "HOME"; 
selected_app = 0; 
phone_open = false;
phone_y = display_get_gui_height();
phone_target_y = display_get_gui_height();

if (!variable_global_exists("balance")) global.balance = 0;