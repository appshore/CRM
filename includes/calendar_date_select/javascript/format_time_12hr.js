// hh12:mm ampm

Date.prototype.getAMPMHour = function() 
{ 
	var hour = this.getHours(); 
	hour = ((hour == 0) ? 12 : (hour > 12 ? hour - 12 : hour ));
	if (hour < 10)
		return (" " + hour);
	return hour;
}

Date.prototype.getAMPM = function() 
{ 
	return (this.getHours() < 12) ? " AM" : " PM"; 
}


