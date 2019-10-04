// class panelets
var Panelets = Class.create(
{
		
	addPanelet: function(paneletName) 
	{	
		params = {
			method: 'post', 
			postBody: 'sid='+sid
				+'&op=base.panelets_ajax.addPanelet'
				+'&panelet_name='+paneletName,
			onSuccess: function(t)
			{
				if (t.responseXML.getElementsByTagName('return')[0].firstChild.data == 'success' )
				{
					$('panelets-form').submit();
				}
			}	 
		};
		new Ajax.Request('raw.php', params);		
	}, 	
	
	movePanelet: function()
	{
		var panelets='';			
 		var items = $$('.panelet_body');
    	for (var i = 0; items.length > i ; i++)
    	{
       		if( items[i].id )
       		{
            	if(i)
                	panelets += ';';           
				panelets += items[i].id;
			}
		}
		
		var params = {
			method: 'post', 
			postBody: 'sid='+sid
				+'&op=base.panelets_ajax.movePanelet'
				+'&data='+panelets
		};
		new Ajax.Request('raw.php', params);
	},
	
	openClosePanelet: function(paneletName, isOpen)
	{	
		params = {
			method: 'post', 
			postBody: 'sid='+sid
				+'&op=base.panelets_ajax.openClosePanelet'
				+'&panelet_name='+paneletName
				+'&is_open='+((isOpen=='block')?'N':'Y'),
			onSuccess: function(t)
			{
				setBox(paneletName+'-img',paneletName,api_image_path+'/arr-none.gif',api_image_path+'/arr-block.gif');				
			}	 
		};
		new Ajax.Request('raw.php', params);		
	},
			
	removePanelet: function(item, paneletName) 
	{
		var ancestor = item.parentNode;
	
		while( ancestor.tagName != 'DIV' )
		{
			ancestor = ancestor.parentNode;
		}
		
		params = {
			method: 'post', 
			postBody: 'sid='+sid
				+'&op=base.panelets_ajax.removePanelet'
				+'&panelet_name='+paneletName,
			onSuccess: function(t)
			{
				var pos = $('panelets-select').options.length;
				$('panelets-select').options[pos] = new Option( $(paneletName+'-label').innerHTML, paneletName, false);
				$('panelets-select').options[pos].className = 'fieldInputSelectOptionIndent';
				ancestor.parentNode.removeChild(ancestor);
			}	 
		};
		new Ajax.Request('raw.php', params);		
	}
});	
