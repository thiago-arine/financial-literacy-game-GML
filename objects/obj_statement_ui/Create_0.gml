statement_open = false;

if (!variable_global_exists("statement")) {
    global.statement = []; 
}
if (!variable_global_exists("balance")) {
    global.balance = 0;
}