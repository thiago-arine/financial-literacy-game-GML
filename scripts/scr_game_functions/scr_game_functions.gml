function update_statement(_from, _value, _kind){
	if (global.month < 10){
		if (global.day < 10) {
			new_entry = {
			    date: "0" + string(global.day) + "/0"+ string(global.month) + "/2026", 
			    from: _from,
			    values: _value,
				kind: _kind}
		} else {
			new_entry = {
			    date: string(global.day) + "/0"+ string(global.month) + "/2026", 
			    from: _from,
			    values: _value,
				kind: _kind}
		};
	} else {
		if (global.day < 10) {
			new_entry = {
			    date: "0" + string(global.day) + "/"+ string(global.month) + "/2026", 
			    from: _from,
			    values: _value,
				kind: _kind}
		} else {
			new_entry = {
			    date: string(global.day) + "/"+ string(global.month) + "/2026",
			    from: _from,
			    values: _value,
				kind: _kind
		}};
	}
	array_push(global.statement, new_entry)
}