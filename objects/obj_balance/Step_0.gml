
if (global.day == 1 and global.month != last_payment_month){
	global.balance += 100.00	
	last_payment_month = global.month
}