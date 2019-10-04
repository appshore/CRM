getLanguageLib('activities');

function epochToHoursMinutes(epoch) 
{
	var datum = new Date(epoch * 1000);
//	var hh = datum.getHours();
//	hh = ((hh < 10) ? ('0'+hh) : hh);
	var mm = datum.getMinutes();
	mm = ((mm < 10) ? ('0'+mm) : mm);
//	return hh + ':' + mm;
	return datum.getAMPMHour()+':'+mm+datum.getAMPM();
}		

function getBoxDay( elt) 
{
	var dayList = $$('.calendarDay');
	
	for( var i = (dayList.length-1) ; i > 0 ; i-- )
		if( (elt.cumulativeOffset().left > dayList[i-1].cumulativeOffset().left) &&	(elt.cumulativeOffset().left < dayList[i].cumulativeOffset().left) )
			return i-1;
			
	return (dayList.length-1);
}			

function limitsXY(n, lower, upper) 
{
	lower = Math.abs(lower);
	upper = Math.abs(upper);
	if (n > upper) 
		return upper;
	if (n < lower) 
		return lower;
	return n;
}	


function setBoxOpacity(elt, value) 
{
	elt.setStyle({
		opacity: 	value/10,
		filter:		'alpha(opacity='+value*10+')'
		});			
}	
	

function setBoxSnap(x, y, elt) 
{
	return[
		limitsXY( 
			x, $('grid').cumulativeOffset().left, $('grid').cumulativeOffset().left+$('grid').offsetWidth
			), 
		limitsXY( 
			y, $('grid').cumulativeOffset().top, $('grid').cumulativeOffset().top+$('grid').offsetHeight
			)
		];
}	
			
	
function activityPopup(event) 
{
	var elt = event.element();	
	if( elt.tagName == 'TD' )
	{
		var eltId = elt.id;
		popupIntra(baseurl+'&op=activities.popup.edit&activity_start='+eltId+'&is_allday='+((elt.className=='calendarDay')?'Y':'N'),getTranslation('activities','New activity'));
	}
	else if( elt.id )
	{
		var eltId = elt.id.match('_') ? elt.id.split('_')[0] : elt.id;
		popupIntra(baseurl+'&op=activities.popup.edit&activity_id='+eltId,getTranslation('activities','Activity'));
	}
}		


