var Embedded = Class.create(
{
	initialize: function(sid, mail_id)
	{
		this.sid = sid;
		this.mail_id = mail_id;
		this.retrieveImages();
  	},
  	
	retrieveImages: function()
	{
		var thisClass = this; // needed for embedded functions
		$$('img').each(function(elt) {
			if( elt.src.indexOf('cid:') != -1 )
				thisClass.retrieveImage(elt);
			});			
	},  	
  	
	retrieveImage: function(elt)
	{
		var params = 
		{
			method: 'post', 
			postBody: 'sid='+this.sid
				+'&op=webmail.ajax.embedded'
				+'&mail_id='+this.mail_id
				+'&img_alt='+elt.alt
				+'&img_id='+elt.id
				+'&img_name='+elt.name
				+'&img_src='+elt.src,
			onSuccess: function(t)
			{
				if (t.responseXML.getElementsByTagName('return')[0].firstChild.data == 'success' )
				{
//					top.growler.notice(t.responseXML.getElementsByTagName('attachment_id')[0].firstChild.data);
					elt.src = 'lib/attachment.php?attachment_id='+t.responseXML.getElementsByTagName('attachment_id')[0].firstChild.data;
				}
			}									
		};
		new Ajax.Request('raw.php', params);
	}
	
});

