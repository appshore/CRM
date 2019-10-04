function serializeFields( items) 
{
	var string = "";
    	for (var i = 0; items.length > i; i++) 
		if( items[i].id )
		{
            if(i)
                string += ',';           
			string += items[i].id;
		}
    return string;   
};	

// class dashboards
var Dashboards = Class.create(
{
		
	addDashlet: function(columnNbr, dashletName) 
	{	
		params = {
			method: 'post', 
			postBody: 'sid='+sid
				+'&op=dashboards.ajax.addDashlet'
				+'&column_nbr='+columnNbr
				+'&dashlet_name='+dashletName,
			onSuccess: function(t)
			{
				if (t.responseXML.getElementsByTagName('return')[0].firstChild.data == 'success' )
				{
					window.location.reload();
				}
			}	 
		};
		new Ajax.Request('raw.php', params);		
	}, 	
	
	moveDashlet: function()
	{
		var fields='';			
 		var items = $$('.dashletColumn');
    	for (var i = 0; items.length > i ; i++)
    	{
       		if( items[i].id )
       		{
            	if(i)
                	fields += ';';           
				fields += items[i].id+':'+serializeFields($(items[i].id).getElementsByClassName('dashlet'));
			}
		}
	
		var params = {
			method: 'post', 
			postBody: 'sid='+sid
				+'&op=dashboards.ajax.moveDashlet'
				+'&data='+fields
		};
		new Ajax.Request('raw.php', params);
	},
		
	removeDashlet: function(item, dashletName) 
	{
		var ancestor = item.parentNode;
	
		while( ancestor.tagName != 'DIV' )
		{
			ancestor = ancestor.parentNode;
		}
		
		params = {
			method: 'post', 
			postBody: 'sid='+sid
				+'&op=dashboards.ajax.removeDashlet'
				+'&dashlet_name='+dashletName,
			onSuccess: function(t)
			{
		    	for (var i = 1; i < 3 ; i++)
		    	{
					var pos = $('dash'+i).options.length;
					$('dash'+i).options[pos] = new Option( $(dashletName+'-label').innerHTML, dashletName, false);
					$('dash'+i).options[pos].className = 'fieldInputSelectOptionIndent';
				}
				ancestor.parentNode.removeChild(ancestor);
			}	 
		};
		new Ajax.Request('raw.php', params);		
	}
});	
