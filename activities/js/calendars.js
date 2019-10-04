function resizeAllDayGridFrm( newHeight)
{ 
	if( typeof(newHeight) == 'object' )
		var newHeight = 0;
		
	if ( Prototype.Browser.IE )
	{
		if (document.documentElement && document.documentElement.scrollHeight)
            //IE 6+ in 'standards compliant mode'
            ieHeight = $('allDayGridFrm').contentWindow.document.documentElement.scrollHeight;
         else if (document.body && document.body.scrollHeight)
             //IE 4 compatible
            ieHeight = $('allDayGridFrm').contentWindow.document.body.scrollHeight;

		$('allDayGridFrm').setStyle({
			height: (newHeight ? newHeight : ieHeight)+'px',
			border: '0px white inset'
			});
	}			
	else
	{
		$('allDayGridFrm').setStyle({
			height: (newHeight ? newHeight : $('allDayGridFrm').contentDocument.height)+'px', 
			border: '1px white inset'
			});
	}
}

function resizeGridFrm()
{ 	
//	document.body.scrollTo(0);

	if ( Prototype.Browser.IE )
	{
		if (document.documentElement && document.documentElement.clientHeight)
            //IE 6+ in 'standards compliant mode'
            ieHeight = document.documentElement.clientHeight;
         else if (document.body && document.body.clientHeight)
             //IE 4 compatible
            ieHeight = document.body.clientHeight;
 	
		$('gridFrmDiv').setStyle({
			height: (ieHeight-($('gridFrmDiv').cumulativeOffset().top+3))+'px',
			border: '0px white inset'
			});
	}
	else
	{
//		if( document.body.clientHeight > window.innerHeight )
//			gridHeight = document.body.clientHeight;
//		else
			gridHeight = window.innerHeight;
		$('gridFrmDiv').setStyle({
			height: (gridHeight-($('gridFrmDiv').cumulativeOffset().top+5))+'px',
			width: ''
			});
		$('gridFrm').setStyle({
			border: '1px white inset'
			});
	}
}

function resizeWeek()
{ 
	var newWidth = ($('grid').offsetWidth-(36+13))/$$('.calendarWeekName').length;
	
	$$('.calendarWeekName').each(function(elt) {
		elt.setStyle({width: newWidth+'px'});
		});				
}

