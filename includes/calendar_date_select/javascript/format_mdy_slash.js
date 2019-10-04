// MM/DD/YYYY 

Date.prototype.toFormattedString = function(include_time)
{
	str = Date.padded2(this.getMonth()+1) + '/' + Date.padded2(this.getDate()) + '/' + this.getFullYear();
	if (include_time) 
	{ 
		hour = this.getHours(); 
		str += ' ' + this.getAMPMHour() + ':' + this.getPaddedMinutes() + this.getAMPM();
	}
	return str;
}

Date.parseFormattedString = function (string) 
{
	var regexp = "(([0-1]?[0-9])\/[0-3]?[0-9]\/[0-9]{4}) *([0-9]{1,2}:[0-9]{1,2})? *(am|pm)?";
	var d = string.match(new RegExp(regexp, "i"));
	if (d==null)
		return Date.parse(string); // Give javascript a chance to parse it.

	mdy = d[1].split('/');
	hrs = 0;
	mts = 0;
	
	if(d[3] != null) 
	{
		hrs = parseInt(d[3].split(':')[0], 10);
		
		if(d[4] != null && d[4].toLowerCase() == 'pm') 
			hrs += 12; // Add 12 more to hrs

    	mts = d[3].split(':')[1];
	}
  
	return new Date(mdy[2], parseInt(mdy[0], 10)-1, mdy[1], hrs, mts, 0);
}
