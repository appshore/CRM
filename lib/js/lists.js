var Lists = Class.create(
{
	initialize: function(bulkForm,selectedForm)
	{
		getLanguageLib('lists');
		this.bulkForm = bulkForm;
		this.selectedForm = selectedForm;
  	},	
	
	getLists: function(thisSelect, targetClassName)
	{
		while( thisSelect.options.length > 3 )
			thisSelect.remove(thisSelect.options.length-1);

		var params = 
		{
			method: 'post', 
			postBody: 'sid='+sid
				+'&op='+targetClassName+'.getLists',
			onSuccess: function(t)
			{
				nodesId = t.responseXML.getElementsByTagName('list_id');
				nodesName = t.responseXML.getElementsByTagName('list_name');
		    	for (var i = 0; nodesId.length > i; i++)
		    	{
					thisSelect.options[i+3] = new Option( nodesName[i].firstChild.data, nodesId[i].firstChild.data, false);
					thisSelect.options[i+3].style.padding = '0 0 0 2em';
				}
			}									
		};
		new Ajax.Request('raw.php', params);
	},
	
	listSelect: function(thisSelect, appName, targetAppName, targetAppLabel, targetClassName)
	{
		if( thisSelect.selectedIndex == 0)
			return false;
		else if( thisSelect.selectedIndex == 1)
			this.prompter(thisSelect, appName, targetAppName, targetAppLabel, targetClassName);
		else
			this.populateList(thisSelect, appName, targetAppName, targetAppLabel, targetClassName);		
	},	
	
	populateList: function(thisSelect, appName, targetAppName, targetAppLabel, targetClassName)
	{
		if( this.bulkForm != this.selectedForm)
			if( gridBulkKey(this.bulkForm,this.selectedForm, targetAppName) == false )
				return false;
		var params = 
		{
			method: 'post', 
			postBody: 'sid='+sid
				+'&op='+targetClassName+'.populateList'
				+'&app_name='+appName
				+'&list_id='+thisSelect[thisSelect.selectedIndex].value
				+ ( (typeof this.bulkForm.bulk_id == 'undefined') ? '' : '&bulk_id='+this.bulkForm.bulk_id.value )
				+'&selected='+this.bulkForm.selected.value,
			onSuccess: function(t)
			{
				top.growler.ungrowl(gr);
				if (t.responseXML.getElementsByTagName('return')[0].firstChild.data == 'success' )
					top.growler.notice(thisSelect[thisSelect.selectedIndex].text.trim()+': '+getTranslation('lists',targetAppLabel+' updated'));
				else
					top.growler.error(thisSelect[thisSelect.selectedIndex].text.trim()+': '+getTranslation('lists',targetAppLabel+' not updated'));
			}									
		};
		gr = top.growler.nobox(getTranslation('common','Updating...'));
		new Ajax.Request('raw.php', params);
	},
	
	prompter: function(thisSelect, appName, targetAppName, targetAppLabel, targetClassName)
	{
		if( this.bulkForm != this.selectedForm)
			if( gridBulkKey(this.bulkForm,this.selectedForm, targetAppName) == false )
				return false;
		var thisClass = this; // needed for imbracted call from onSuccess
		Dialog.confirm(
			'<div style="padding:10px;text-align:left">'+getTranslation('lists','Enter the name of the new '+targetAppLabel)+'</div>'+
			'<div style="padding:0 10px 10px 10px;text-align:left;"><input id="dialogInput" style="width:370px" type="text"/></div>', 
			{
				className: 		"dialog", 
				title:			getTranslation('lists',targetAppLabel),
				width: 			400, 
				okLabel: 		getTranslation('common','Ok'), 
				cancelLabel: 	getTranslation('common','Cancel'),
				onOk:function(win)
				{
					thisSelect.selectedIndex=0;

					listName = $('dialogInput').value;
					
					if( listName.length == 0 )
						return false;
						
					var params = 
					{
						method: 'post', 
						postBody: 'sid='+sid
							+'&op='+targetClassName+'.createList'
							+'&list_name='+encodeURIComponent(listName),
						onSuccess: function(t)
						{
							top.growler.ungrowl(gr);
							if (t.responseXML.getElementsByTagName('return')[0].firstChild.data == 'success' )
							{
								thisSelect[thisSelect.selectedIndex].value = t.responseXML.getElementsByTagName('list_id')[0].firstChild.data;
								thisClass.populateList(thisSelect, appName, targetAppName, targetAppLabel, targetClassName);
								top.growler.notice(listName+': '+getTranslation('lists',targetAppLabel+' created'));
								thisClass.bulkForm.submit();
							}
							else
								top.growler.error(listName+': '+getTranslation('lists',targetAppLabel+' not created'));
						}									
					};
					gr = top.growler.nobox(getTranslation('common','Updating...'));
					new Ajax.Request('raw.php', params);
					return true;
				}
				
			});
	}
	
});


