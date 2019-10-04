var Tags = Class.create(
{
	initialize: function()
	{
		getLanguageLib('tags');
  	},
  	
	confirmDeleteTag: function(tagId, isConfirm)
	{
		if( isConfirm == 'N')
			this.deleteTag(tagId);
		else
		{
			var thisClass = this; // needed for imbracted call from onSuccess
			Dialog.confirm(
				'<div style="padding:10px">'+getTranslation('common','Please confirm this action')+'</div>', 
				{
					className: 		'dialog',
					title:			getTranslation('common','Confirm this action'),
					width:			400, 
					cancelLabel: 	getTranslation('common','Cancel'), 
					okLabel: 		getTranslation('common','Ok'), 
					ok:function(win) 
					{
						thisClass.deleteTag(tagId);
						return true;
					}
				});
		}
	},  	
  	
	deleteTag: function(tagId)
	{
		var params = 
		{
			method: 'post', 
			postBody: 'sid='+sid
				+'&op=tags.ajax.deleteTag'
				+'&tag_id='+tagId,
			onSuccess: function(t)
			{
				top.growler.ungrowl(gr);			
				if (t.responseXML.getElementsByTagName('return')[0].firstChild.data == 'success' )
				{
					$('tag_'+tagId).parentNode.removeChild($('tag_'+tagId));
					$('tag_'+tagId+'_div').parentNode.removeChild($('tag_'+tagId+'_div'));
					top.growler.notice(getTranslation('tags','Tag deleted'));
				}
				else
					top.growler.error(getTranslation('tags','This tag can not be deleted'));
			}									
		};
		gr = top.growler.nobox(getTranslation('common','Deleting...'));
		new Ajax.Request('raw.php', params);
	},

	renameTag: function(tagId)
	{
		Dialog.confirm(
			'<div style="padding:10px;text-align:left">'+getTranslation('tags','Enter the new name of the tag')+'</div>'+
			'<div style="padding:0 10px 10px 10px;text-align:left;"><input id="dialogInput" style="width:370px"/></div>', 
			{
				className: 		"dialog", 
				title:			getTranslation('tags','Tag'),
				width: 			400, 
				okLabel: 		getTranslation('common','Ok'), 
				cancelLabel: 	getTranslation('common','Cancel'),
				onOk:function(win)
				{
					tagName = $('dialogInput').value;
					
					if( tagName.length == 0 )
						return false;
						
					var params = 
					{
						method: 'post', 
						postBody: 'sid='+sid
							+'&op=tags.ajax.renameTag'
							+'&tag_id='+tagId
							+'&tag_name='+tagName,
						onSuccess: function(t)
						{
							top.growler.ungrowl(gr);			
							if (t.responseXML.getElementsByTagName('return')[0].firstChild.data == 'success' )
							{
								$('tagName').innerHTML = tagName;
								$('tag_'+tagId).innerHTML = tagName;
								top.growler.notice(getTranslation('tags','Tag renamed'));
							}
							else
								top.growler.error(getTranslation('tags','This tag can not be renamed'));
						}									
					};
					gr = top.growler.nobox(getTranslation('common','Updating...'));
					new Ajax.Request('raw.php', params);
					return true;
				},
				onShow: function(win)
				{
					$('dialogInput').value = $('tagName').innerHTML;
				}
					
				
			});
	},

	removeSelected: function(thisForm,tagId,selected)
	{
		if( thisForm != null)
			selected = gridGetSelected( thisForm, thisForm.selected);

		var params = 
		{
			method: 'post', 
			postBody: 'sid='+sid
				+'&op=tags.ajax.removeTag'
				+'&tag_id='+tagId
				+'&selected='+selected,
			onSuccess: function(t)
			{
				top.growler.ungrowl(gr);			
				if (t.responseXML.getElementsByTagName('return')[0].firstChild.data == 'success' )
				{
					if( thisForm != null)
						gridRemoveSelected( thisForm, thisForm.selected);
					else
						$('record_tag_'+tagId).parentNode.removeChild($('record_tag_'+tagId));
					if( thisForm != null)
						top.growler.notice(getTranslation('tags','Tag removed from the selected records'));
					else
						top.growler.notice(getTranslation('tags','Tag removed from this record'));
				}
				else
				{
					if( thisForm != null)
						top.growler.error(getTranslation('tags','This tag can not be removed from the selected records'));
					else
						top.growler.error(getTranslation('tags','This tag can not be removed from this record'));
				}
			}									
		};
		gr = top.growler.nobox(getTranslation('common','Updating...'));
		new Ajax.Request('raw.php', params);
	}
});

