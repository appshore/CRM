// class pipeline
var Pipeline = Class.create(
{			
	getPipeline: function( refresh) 
	{
		if( (hmpartner_id = $F('partners')) == '' )
			return;
	
		$$('.data').each( function( elt){
			elt.innerHTML = ''; 
		});
		
		$$('a.data').each( function( elt){
			elt.href = '?&op=dailies.base.drilldown&source_id='+hmpartner_id+'&cell='+elt.id; 
		});

		params = {
			method: 'post', 
			postBody: 'sid='+sid
				+'&op=dailies.ajax.getPipeline'
				+'&hmpartner_id='+hmpartner_id
				+'&refresh='+((refresh=='Y')?'Y':'N'),
			onSuccess: function(t)
			{			
				top.growler.ungrowl(gr);
				if( t.responseXML.getElementsByTagName('pipeline').length ) 
				{				
					$$('.data').each( function(elt){
						elt.innerHTML = t.responseXML.getElementsByTagName(elt.id).item(0).firstChild.data; 
					});
				}
			},	 
		};

		gr = top.growler.growl('Processing...',{sticky:true},{backgroundColor:'limegreen',textAlign:'center'});
		new Ajax.Request('raw.php', params);		
	}
});	

var pipe = new Pipeline();

