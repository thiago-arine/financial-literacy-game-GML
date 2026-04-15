// DEFINA AQUI A RESOLUÇÃO DA SUA VIEW (O TAMANHO DA SUA ARTE)
var _w = 320; 
var _h = 180;

// Configura a GUI para ter o mesmo tamanho da arte
display_set_gui_size(_w, _h);

// Garante que o GameMaker não tente "suavizar" os pixels
gpu_set_texfilter(false); 

// Força a GUI a manter a proporção 1:1 com a tela definida acima
display_set_gui_maximize(1, 1, 0, 0);

global.has_headset = false;
global.has_key = false;
global.has_kite = false;
global.has_screwdriver = false;
global.reputation = 0;
global.balance = 0; // Saldo inicial

global.has_key = false;
global.has_headset = false;
global.has_kite = false;
global.has_screwdriver = false

global.quest_key_finished = false;
global.quest_headset_finished = false;
global.quest_kite_finished = false;
global.quest_screwdriver_finished = false