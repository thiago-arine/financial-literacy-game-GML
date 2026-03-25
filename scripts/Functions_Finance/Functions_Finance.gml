function update_statement(_from, _value, _kind) {
    if (!variable_global_exists("statement")) global.statement = [];
    
    var _date = string(global.day) + "/" + string(global.month);
    
    var _new_entry = {
        date: _date,
        from: _from,
        values: _value,
        kind: _kind
    };
    
    array_push(global.statement, _new_entry);
}