// DD MONTH YYYY 

Date.prototype.toFormattedString = function(include_time)
{
	str = this.getDate() + ' ' + Date.months[this.getMonth()].substring(0,3) + ' ' + this.getFullYear();
	if (include_time) 
	{ 
		hour = this.getHours(); 
		str += ' ' + this.getAMPMHour() + ':' + this.getPaddedMinutes() + this.getAMPM();
	}
	return str;
}

