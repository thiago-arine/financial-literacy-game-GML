state = "HOME"; 
selected_app = 0; 
phone_open = false;
phone_y = display_get_gui_height();
phone_target_y = display_get_gui_height();

// Lista de meses para o App de Calendário
calendar_months = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"];

// Garante que as globais existam para não dar erro de leitura
if (!variable_global_exists("balance")) global.balance = 0;