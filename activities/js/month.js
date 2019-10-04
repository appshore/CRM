var startGrabDay = 0;

function setMonthBoxParameters( elt) 
{		
	new Draggable( elt, 
	{
		handle: elt, 
		starteffect: function( elt) 
		{
			startGrabDay = parseInt( $$('.calendarDay')[getBoxDay(elt)].id);
			elt.setStyle({width: ($$('.calendarDay')[0].offsetWidth - 8)+'px'});
			return true;
		},
		endeffect: function( elt) 
		{
			updateMonthBox( elt);					
			return true;
		},
		snap: function( x, y, dragelt) 
		{
			return setBoxSnap( x, y, dragelt.element);
		},
		onStart: function(elt) {
	        $$('.calendarBox').invoke( 'stopObserving', 'click');
			return true;
    	},
	    onEnd : function(elt) {
	        setTimeout("$$('.calendarBox').invoke( 'observe', 'click', activityPopup);", "100");
	        return true;
	    }		
	});
}

function sortStackBoxes( elt1, elt2)
{
	var ret = parseInt(elt1.readAttribute('_start')) - parseInt(elt2.readAttribute('_start'));
	return (( ret == 0 ) ? (parseInt(elt2.readAttribute('_end')) - parseInt(elt1.readAttribute('_end'))) : ret);
}			
					
function stackMonthBoxes() 
{				
	if( $$('.calendarBox').length == 0 )
		return;
		
	var stack = new Array();
	stack = $$('.calendarBox');
	stack.sort(sortStackBoxes);


	var grid = new Array($$('.calendarDay').length+1);
	for( var i = 0 ; i < $$('.calendarDay').length+1 ; i++ )
	{
		grid[i] = new Array(stack.length+1); 
		for( var j = 0 ; j < stack.length+1 ; j++ )
			grid[i][j] = -1; 
	}
		
	var maxPos = 1;	
	var pos = 0;    			

	for( var i = 0 ; i < stack.length ; i++ )
	{
		var startDay = parseInt(stack[i].readAttribute('_startday'));
		var jMax = startDay+parseInt(stack[i].readAttribute('_nbrdays'));
		
		if( jMax > $$('.calendarDay').length )
			jMax = $$('.calendarDay').length;

		pos = 0;    			
		while( (pos < stack.length) && ( grid[startDay][pos] != -1 ) )
			pos++;			
			
		if( pos >= maxPos )
			maxPos++;
			
		grid[startDay][pos] = i;
											
		for( var j = (startDay+1); j < jMax ; j++ )
			grid[j][pos] = -2;
	}
	
	for( var i = 0 ; i < $$('.calendarDay').length ; i++ )
	{
		for( var j = 0 ; j < stack.length ; j++ )
		{
			if( grid[i][j] >= 0 )
			{
				nbrdays = parseInt(stack[grid[i][j]].readAttribute('_nbrdays'));
				daypos = i % $$('.calendarWeekName').length;
				
				if( (nbrdays + daypos) > $$('.calendarWeekName').length )
				{
					stack[grid[i][j]].setStyle({
						top:	$$('.calendarDay')[i].cumulativeOffset().top+(2+(16*j))+16+'px', 
						left:	$$('.calendarDay')[i].cumulativeOffset().left+5+'px', 
						width: 	(($$('.calendarDay')[i].offsetWidth * ($$('.calendarWeekName').length-daypos)) - 8)+'px'
						});
				}
				else
				{
					stack[grid[i][j]].setStyle({
						top:	$$('.calendarDay')[i].cumulativeOffset().top+(2+(16*j))+16+'px', 
						left:	$$('.calendarDay')[i].cumulativeOffset().left+5+'px', 
						width: 	(($$('.calendarDay')[i].offsetWidth * nbrdays) - 8)+'px'
						});
				}				
			} 
		}
	}    	
		
}		

function updateMonthBox( elt) 
{
	diffEnd = Math.floor( (elt.cumulativeOffset().left-$('grid').cumulativeOffset().left)/$$('.calendarDay')[0].offsetWidth)+
		(Math.floor( (elt.cumulativeOffset().top-$('grid').cumulativeOffset().top)/$$('.calendarDay')[0].offsetHeight)*$$('.calendarWeekName').length);
	diffEnd *= 86400;
				
	var start =  parseInt($$('.calendarDay')[0].id)+diffEnd+(parseInt(elt.readAttribute('_start'))-parseInt(elt.readAttribute('_day')));
	var end = parseInt($$('.calendarDay')[0].id)+diffEnd+(parseInt(elt.readAttribute('_end'))-parseInt(elt.readAttribute('_day')));;
	
	var params = 
	{
		method: 'post', 
		postBody: 'sid='+sid
			+'&op=activities.calendars_ajax.updateActivity'
			+'&activity_id='+elt.id
			+'&period='+$$('.calendarDay').length
			+'&first='+$$('.calendarDay')[0].id
			+'&last='+$$('.calendarDay')[$$('.calendarDay').length-1].id
			+'&start='+start
			+'&end='+end,
		onSuccess: function(t){
			top.growler.ungrowl(gr);
			if( t.responseXML.getElementsByTagName('return')[0].firstChild.data == 'success')
			{
				elt.writeAttribute( '_day', t.responseXML.getElementsByTagName('day')[0].firstChild.data);
				elt.writeAttribute( '_startday', t.responseXML.getElementsByTagName('startDay')[0].firstChild.data);
				elt.writeAttribute( '_nbrdays', t.responseXML.getElementsByTagName('nbrDays')[0].firstChild.data);
				elt.writeAttribute( '_start', t.responseXML.getElementsByTagName('start')[0].firstChild.data);
				elt.writeAttribute( '_end', t.responseXML.getElementsByTagName('end')[0].firstChild.data);
//				if( t.responseXML.getElementsByTagName('start')[0].firstChild.data < parseInt($$('.calendarDay')[0].id) )
//					$(t.responseXML.getElementsByTagName('activity_id')[0].firstChild.data+'_prefix').innerHTML = '...';
//				else
//					$(t.responseXML.getElementsByTagName('activity_id')[0].firstChild.data+'_prefix').innerHTML = '';
//				if( t.responseXML.getElementsByTagName('end')[0].firstChild.data > (parseInt($$('.calendarDay')[$$('.calendarDay').length-1].id)+84600) )
//					$(t.responseXML.getElementsByTagName('activity_id')[0].firstChild.data+'_suffix').innerHTML = '...';
//				else
//					$(t.responseXML.getElementsByTagName('activity_id')[0].firstChild.data+'_suffix').innerHTML = '';
				stackMonthBoxes();	
				top.growler.notice(getTranslation('common','Updated'));
			}
			else
				top.growler.error(getTranslation('common','Error'));
			},	
		onFailure: function(t){
			top.growler.ungrowl(gr);
			top.growler.error(getTranslation('common','Error'));
			}									
	};
	gr = top.growler.nobox(getTranslation('common','Updating...'));
	new Ajax.Request('raw.php', params);
}

function resizeMonthGrid()
{ 
	resizeMonth();
	$$('.calendarBox').each(setMonthBoxParameters);
	stackMonthBoxes();	
}

function loadMonthGrid()
{ 
	resizeMonthGrid();
	$$('.calendarBox').invoke( 'observe', 'click', activityPopup);			
	$$('.calendarDay').invoke( 'observe', 'dblclick', activityPopup);			
	stackMonthBoxes();	
}

function resizeMonth()
{ 
	var newHeight = 0;
	var newWidth = ($('grid').offsetWidth-40) / $$('.calendarWeekName').length;
	
	$$('.calendarWeekName').each(function(elt) {
		elt.setStyle({width: newWidth+'px'});
		});	

	if ( Prototype.Browser.IE )
	{
		if (document.documentElement && document.documentElement.clientHeight)
            //IE 6+ in 'standards compliant mode'
            newHeight = document.documentElement.clientHeight;
        else if (document.body && document.body.clientHeight)
             //IE 4 compatible
            newHeight = document.body.clientHeight;
 	}
	else
	{
    	newHeight = window.innerHeight;
	}
						
	newHeight -= $('grid').cumulativeOffset().top;
	newHeight /= $$('.calendarWeekNumber').length;

	$$('.calendarWeekNumber').each(function(elt) {
		elt.setStyle({height: newHeight+'px'});
		});		

	$$('.calendarDay').each(function(elt) {
		elt.setStyle({height: newHeight+'px'});
		});		
}

