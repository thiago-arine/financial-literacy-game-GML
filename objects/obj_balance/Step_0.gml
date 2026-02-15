
if (global.day == 1 and global.month != last_payment_month){
	global.balance += 30.00	
	var new_entry = {
	    date: "01/"+ string_format(global.month, 2, 0) + "/2026",
	    from: "Pais",
	    values: "+30"
	};

	array_push(global.statement, new_entry);

	last_payment_month = global.month
}