state = "HOME"; 
selected_app = 0; 
phone_open = false;
phone_y = display_get_gui_height();
phone_target_y = display_get_gui_height();

// Variável para o menu de skip (0 = Pular dia, 1 = Cancelar)
skip_option_selected = 0;
// Variável para o menu de sair (0 = Sair, 1 = Cancelar)
exit_option_selected = 0;

// Lista de meses para o App de Calendário
calendar_months = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"];

if (!variable_global_exists("balance")) global.balance = 0;