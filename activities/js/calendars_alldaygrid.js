var startGrabDay = 0;

function setAllDayBoxParameters( elt) 
{
	stackAllDayBoxes();
	
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
			updateAllDayBox( elt);			
			stackAllDayBoxes();
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
					
function stackAllDayBoxes() 
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
		var nbrDays = parseInt(stack[i].readAttribute('_nbrdays'));
		
		pos = 0;    			
		while( (pos < stack.length) && ( grid[startDay][pos] != -1 ) )
			pos++;
			
		if( pos >= maxPos )
			maxPos++;
			
		grid[startDay][pos] = i;									
		for( var j = (startDay+1); j < (startDay+nbrDays) ; j++ )
			grid[j][pos] = -2;
	}
	
	$('grid').setStyle({height:(++maxPos*17)+'px'});	
	parent.resizeAllDayGridFrm(maxPos*17);
	parent.resizeGridFrm();
	
	for( var i = 0 ; i < $$('.calendarDay').length ; i++ )
	{
		for( var j = 0 ; j < stack.length ; j++ )
		{
			if( grid[i][j] >= 0 )
			{
				stack[grid[i][j]].setStyle({
					top:	(2+(16*j))+'px', 
					left: 	($(stack[grid[i][j]].readAttribute('_day')).cumulativeOffset().left + 5)+'px',
					width: 	(($$('.calendarDay')[i].offsetWidth * parseInt(stack[grid[i][j]].readAttribute('_nbrdays'))) - 8)+'px'
				});
			} 
		}
	}     	
		
}		

function updateAllDayBox( elt) 
{
	elt.writeAttribute( '_day', $$('.calendarDay')[getBoxDay(elt)].id);
	elt.writeAttribute( '_start', parseInt(elt.readAttribute('_day')) + (Math.floor(elt.cumulativeOffset().top / 5) * 300));
	elt.writeAttribute( '_end', parseInt(elt.readAttribute('_start')) + (Math.round(elt.offsetHeight / 5) * 300));
	
	var params = 
	{
		method: 'post', 
		postBody: 'sid='+sid
			+'&op=activities.calendars_ajax.updateActivity'
			+'&activity_id='+elt.id
			+'&period='+$$('.calendarDay').length
			+'&first='+$$('.calendarDay')[0].id
			+'&last='+$$('.calendarDay')[$$('.calendarDay').length-1].id
			+'&start='+elt.readAttribute('_start')
			+'&end='+elt.readAttribute('_end'),
		onSuccess: function(t){
			top.growler.ungrowl(gr);
			if( t.responseXML.getElementsByTagName('return')[0].firstChild.data == 'success')
			{
				elt.writeAttribute( '_startday', t.responseXML.getElementsByTagName('startDay')[0].firstChild.data);
				elt.writeAttribute( '_nbrdays', t.responseXML.getElementsByTagName('nbrDays')[0].firstChild.data);
//				if( t.responseXML.getElementsByTagName('start')[0].firstChild.data < parseInt($$('.calendarDay')[0].id) )
//					$(t.responseXML.getElementsByTagName('activity_id')[0].firstChild.data+'_prefix').innerHTML = '...';
//				else
//					$(t.responseXML.getElementsByTagName('activity_id')[0].firstChild.data+'_prefix').innerHTML = '';
//				if( t.responseXML.getElementsByTagName('end')[0].firstChild.data > (parseInt($$('.calendarDay')[$$('.calendarDay').length-1].id)+84600) )
//					$(t.responseXML.getElementsByTagName('activity_id')[0].firstChild.data+'_suffix').innerHTML = '...';
//				else
//					$(t.responseXML.getElementsByTagName('activity_id')[0].firstChild.data+'_suffix').innerHTML = '';
				resizeAllDayGrid();	
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

function resizeAllDayGrid()
{ 
	$$('.calendarBox').each(setAllDayBoxParameters);
	stackAllDayBoxes();	
}

function loadAllDayGrid()
{ 
	resizeAllDayGrid();
	$$('.calendarBox').invoke( 'observe', 'click', activityPopup);			
	$$('.calendarDay').invoke( 'observe', 'dblclick', activityPopup);			
	parent.window.resizeAllDayGridFrm();
}
