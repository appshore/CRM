var Notifications = Class.create(
{
	
	initialize: function(sid)
	{
		getLanguageLib('notifications');
		this.sid = sid;
		this.isStart = true;
		this.getNotifications();
  	},	
		
	getNotifications: function()
	{
		var thisClass = this; // needed for embedded functions
		var params = 
		{
			method: 'post',
			frequency: 10, 
			decay: 1,
			postBody: 'sid='+this.sid
				+'&op=base.notifications_ajax.getNotifications',
			onSuccess: function(t)
			{
		    	for (var i = 0; t.responseXML.getElementsByTagName('subject').length > i; i++)
		    	{
		    		var nId = t.responseXML.getElementsByTagName('notification_id')[i].firstChild.data;
		    		if( !$(nId) )
						top.growler.growl(
							'<div style="height:18px;overflow:hidden"><img src="api/images/alarmclock.png" class="image"/>'
							+' '+t.responseXML.getElementsByTagName('timestamp')[i].firstChild.data
							+' '+t.responseXML.getElementsByTagName('appLabel')[i].firstChild.data
							+' <a id="'+nId+'" href="'+t.responseXML.getElementsByTagName('link')[i].firstChild.data+'">'
//							+' onclick="notifier.stopNotification(\''+nId+'\')"'
							+t.responseXML.getElementsByTagName('subject')[i].firstChild.data
							+'</a></div>'
							, { 
								sticky: true
								,stickyTitle: getTranslation('notifications','Dismiss the reminder')
								,destroyed: function(evt){
								    thisClass.stopNotification($(evt.element()).select('a')[0].id);
								}
							}
						);
				}
			}									
		};
		new Ajax.PeriodicalUpdater('notification', 'raw.php', params);
	},

	stopNotification: function(nId)
	{
		var params = 
		{
			method: 'post',
			postBody: 'sid='+this.sid
				+'&op=base.notifications_ajax.stopNotification'									
				+'&notification_id='+nId						
		};
		new Ajax.Request('raw.php', params);
	}	
});


