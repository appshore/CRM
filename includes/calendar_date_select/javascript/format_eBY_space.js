// DD MONTH YYYY 

Date.prototype.toFormattedString = function(include_time)
{
	str = this.getDate() + ' ' + Date.months[this.getMonth()] + ' ' + this.getFullYear();
	if (include_time) 
	{ 
		hour = this.getHours(); 
		str += ' ' + this.getAMPMHour() + ':' + this.getPaddedMinutes() + this.getAMPM();
	}
	return str;
}
