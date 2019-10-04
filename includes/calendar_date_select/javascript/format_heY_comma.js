// DD MONTH YYYY 

Date.prototype.toFormattedString = function(include_time)
{
	str = Date.months[this.getMonth()].substring(0,3) + ' ' + this.getDate() + ', ' + this.getFullYear();
	if (include_time) 
	{ 
		hour = this.getHours(); 
		str += ' ' + this.getAMPMHour() + ':' + this.getPaddedMinutes() + this.getAMPM();
	}
	return str;
}

