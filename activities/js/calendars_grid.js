function setBoxParameters(elt) 
{			
	elt.setStyle({
		left: 		($(elt.readAttribute('_day')).cumulativeOffset().left + 5)+'px',
		top:		(Math.abs(parseInt(elt.readAttribute('_start'))-parseInt(elt.readAttribute('_day'))) / 60)+'px',
		width: 		($$('.calendarDay')[0].offsetWidth - 8)+'px', 
		height: 	(Math.abs(parseInt(elt.readAttribute('_end'))-parseInt(elt.readAttribute('_start'))) / 60)+'px'
		});				

	setBoxOpacity( elt, 8);
	swapBoxContent( elt);
	stackBoxes( getBoxDay(elt));
	
	new Draggable( elt, 
	{
		handle: elt.id+'_header',		
		starteffect: function( elt) 
		{
			elt.setStyle({
				width: 	($$('.calendarDay')[0].offsetWidth - 8)+'px', 
				zIndex: 10000
				});			
			return true;
		},				
		endeffect: function( elt) 
		{
			var startDay = elt.readAttribute('_day');
			updateBox( elt);			
			if( startDay != elt.readAttribute('_day') )	
				stackBoxes( Math.floor(Math.abs(parseInt(startDay)-parseInt($$('.calendarDay')[0].id))/86400));
			stackBoxes( getBoxDay(elt));
			return true;
		},
		snap: function( x, y, dragelt) 
		{
			var elt = dragelt.element;
			$(elt.id+'_time').innerHTML = epochToHoursMinutes(parseInt(elt.readAttribute('_day'))+(Math.floor(elt.cumulativeOffset().top/5)*300));							
			$(elt.id).title = $(elt.id).title.split('@')[0]+'@'+$(elt.id+'_time').innerHTML+' ::'+$(elt.id).title.split('::')[1];							
			return setBoxSnap( x, y, elt);
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
	
	new Resizeable( elt, 
	{
		right:0,left:0,top:0,minWidth:100,minHeight:14,
		resize:function(elt)
		{
			swapBoxContent( elt);					
			stackBoxes( getBoxDay(elt));
			updateBox( elt);
			return true;
		}
	});
}
					
function swapBoxContent( elt) 
{
	boxHeight = elt.offsetHeight;
	subject = $((elt.id+'_subject'));
	content = $((elt.id+'_content'));
	if( (boxHeight < 28) && content.innerHTML.length )
	{
		subject.innerHTML = content.innerHTML;
		content.innerHTML = '';							
	}
	else if( (boxHeight >= 28) && subject.innerHTML.length )
	{
		content.innerHTML = subject.innerHTML;
		subject.innerHTML = '';							
	}
}

function sortBoxes( elt1, elt2)
{
	return (elt1.cumulativeOffset().top - elt2.cumulativeOffset().top);
}

function stackBoxes( thisDay) 
{
	var stack = new Array();
	stack = $$('.calendarBox').findAll( function( elt){
		return ( getBoxDay(elt) == parseInt(thisDay) );
		});
		
	if( stack.length == 0 )
		return;
		
	stack.sort(sortBoxes);	
	
	var dayStackZero = getBoxDay(stack[0]);	
	var dayStackZeroLeft = $$('.calendarDay')[dayStackZero].cumulativeOffset().left;	
	var dayStackZeroWidth = $$('.calendarDay')[dayStackZero].offsetWidth;	

	stack[0].setStyle({
		zIndex: 1000,			
		left:	(dayStackZeroLeft + 5)+'px',
		width: 	(dayStackZeroWidth - 8)+'px' 
		});
	
	for( i = 1 ; i < stack.length ; i++ )
	{
		var stacked = false;
		
		for ( j = i-1 ; j >= 0 ; j-- )
		{
			if( stack[i].cumulativeOffset().top < (stack[j].cumulativeOffset().top+stack[j].offsetHeight) )
			{
				slide = Math.floor(dayStackZeroWidth * 0.20);
				stack[i].setStyle({
					zIndex: 1000 + i,			
					left:	(stack[j].cumulativeOffset().left + slide)+'px',
					width:	(stack[j].offsetWidth - slide)+'px' 
					});
				stacked = true;
				j = -1;
			}
		}
		
		if( stacked == false )
		{
			stack[i].setStyle({
				zIndex: 1000 + i,			
				left:	(dayStackZeroLeft + 5)+'px',
				width: 	(dayStackZeroWidth - 8)+'px' 
				});
		}
	}
				
}

function updateBox( elt) 
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
			+'&start='+elt.readAttribute('_start')
			+'&end='+elt.readAttribute('_end'),
		onSuccess: function(t){
			top.growler.ungrowl(gr);
			if( t.responseXML.getElementsByTagName('return')[0].firstChild.data == 'success')
				top.growler.notice(getTranslation('common','Updated'));
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

function resizeGrid()
{ 
	$$('.calendarBox').each(setBoxParameters);
}

function loadGrid()
{ 
	resizeGrid();
	$$('.calendarBox').invoke( 'observe', 'click', activityPopup);
	$$('.calendarPeriod').invoke( 'observe', 'dblclick', activityPopup);
	parent.window.resizeGridFrm();
}



