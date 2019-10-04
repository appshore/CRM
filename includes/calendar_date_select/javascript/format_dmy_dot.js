// DD.MM.YYYY 

Date.prototype.toFormattedString = function(include_time)
{
	str = Date.padded2(this.getDate()) + '.' + Date.padded2(this.getMonth()+1) + '.' + this.getFullYear();
	if (include_time) 
	{ 
		hour = this.getHours(); 
		str += ' ' + this.getAMPMHour() + ':' + this.getPaddedMinutes() + this.getAMPM();
	}
	return str;
}

Date.parseFormattedString = function (string) 
{
	var regexp = "(([0-3]?[0-9])\.[0-1]?[0-9]\.[0-9]{4}) *([0-9]{1,2}:[0-9]{1,2})? *(am|pm)?";
	var d = string.match(new RegExp(regexp, "i"));
	if (d==null)
		return Date.parse(string); // Give javascript a chance to parse it.

	dmy = d[1].split('.');
	hrs = 0;
	mts = 0;
	
	if(d[3] != null) 
	{
		hrs = parseInt(d[3].split(':')[0], 10);
		
		if(d[4] != null && d[4].toLowerCase() == 'pm') 
			hrs += 12; // Add 12 more to hrs

    	mts = d[3].split(':')[1];
	}
  
	return new Date(dmy[2], parseInt(dmy[1], 10)-1, dmy[0], hrs, mts, 0);
}
