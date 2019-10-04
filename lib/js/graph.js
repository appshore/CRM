

// generate the url to access Google Chart API
function googleChart( thisImg, cht, chtt, chs, chco, chl, chd)
{
	var source = '';

	if( thisImg.width != 1 )
		return false;
	
	source += 'http://chart.apis.google.com/chart?';
	//source += '&chf=bg,s,ffffff';				// background color
	source += '&cht='+cht;						// chart type
	source += '&chs='+chs;						// size WxH
	source += chco?'&chco='+chco:'';			// colors set
	source += chtt?'&chtt='+chtt:'';			// title
	source += '&chl='+chl;						// data labels
	source += '&chd=t:'+chd;					// data set
	
	thisImg.src = source;
	
	return true;
}
