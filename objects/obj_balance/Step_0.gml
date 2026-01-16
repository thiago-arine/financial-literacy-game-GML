
if (global.day == 1 and global.month != last_payment_month){
	global.balance += 30.00	
	last_payment_month = global.month
}