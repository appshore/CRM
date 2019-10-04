
function linkedAllCheckbox( MyForm, checked)
{	
	for (var i = 0; i < MyForm.elements.length ; i++)
		if (  MyForm.elements[i].type == 'checkbox' )
		{
			MyForm.elements[i].checked = checked;
			if ( checked == true )
				MyForm.elements[i].value = MyForm.elements[i].name;
			else
				MyForm.elements[i].value = 0;			
		}
}

function linkedCheckbox( Mycheck) 
{
	if ( Mycheck.checked == true )
		Mycheck.value = Mycheck.name;
	else
		Mycheck.value = 0;
}

function getSelected( thisForm)
{
	var selected='';

	for (i = 0; i < thisForm.elements.length ; i++)
		if (  thisForm.elements[i].type == 'checkbox' && thisForm.elements[i].checked == true && thisForm.elements[i].value != '0' )
		{
			if ( i > 0 && selected.length )
				selected += ',';
			selected += thisForm.elements[i].value;
		}
	return selected;
}

function confirmDeleteSelectedRecords( masterForm, thisForm, appName, masterRecordName, masterRecordId, isConfirm, msg)
{
	if( isConfirm == 'N')
		deleteSelectedRecords( masterForm, thisForm, appName, masterRecordName, masterRecordId);
	else	
		Dialog.confirm(
			'<div style="padding:10px">'+getTranslation('common',msg?msg:'Please confirm this action')+'</div>', 
			{
				className: 		'dialog',
				title:			getTranslation('common','Confirm action'),
				width:			400, 
				okLabel: 		getTranslation('common','Ok'), 
				ok:function(win) 
				{
					deleteSelectedRecords( masterForm, thisForm, appName, masterRecordName, masterRecordId);
				}
			}); 		
}

function deleteSelectedRecords( masterForm, thisForm, appName, masterRecordName, masterRecordId)
{
	var params =
	{
		method: 'post',
		postBody: 'sid='+sid
			+'&op='+appName+'.ajax.deleteSelectedRecords'
			+'&selected='+getSelected(thisForm)
			+'&record_name='+masterRecordName
			+'&record_id='+masterRecordId,
		onSuccess: function(t){
			top.growler.ungrowl(gr);
			top.growler.notice(getTranslation('common','Deleted'));
			masterForm.isreload.value = 'true';
			masterForm.submit();
			},
		onFailure: function(t){
			top.growler.ungrowl(gr);
			top.growler.error(getTranslation('common','Error'));
			}
	};
	gr = top.growler.nobox(getTranslation('common','Deleting...'));
	new Ajax.Request('raw.php', params);
}

function unlinkSelectedRecords( masterForm, thisForm, appName, masterTableName, masterRecordId)
{
	var params =
	{
		method: 'post',
		postBody: 'sid='+sid
			+'&op='+appName+'.ajax.unlinkSelectedRecords'
			+'&selected='+getSelected(thisForm)
			+'&table_name='+masterTableName
			+'&record_id='+masterRecordId,
		onSuccess: function(t){
			top.growler.ungrowl(gr);
			top.growler.notice(getTranslation('common','Unlinked'));
			masterForm.isreload.value = 'true';
			masterForm.submit();
			},
		onFailure: function(t){
			top.growler.ungrowl(gr);
			top.growler.error(getTranslation('common','Error'));
			}
	};
	gr = top.growler.nobox(getTranslation('common','Unlinking...'));
	new Ajax.Request('raw.php', params);
}

function linkSearchPopup(appName, appLabel, masterTableName, selectedId)
{
	popupIntra(baseurl+'&op='+appName+'.popup.search&table_name='+masterTableName+'&record_id='+selectedId+'&readonly=W&is_multiple=true',appLabel);
}

function linkAddPopup(appName, appLabel, masterTableName, masterRecordId, masterRecordIdValue, masterRecordNameValue)
{
	popupIntra(baseurl+'&op='+appName+'.popup.edit&linked_appName='+masterTableName+'&linked_recordId='+masterRecordId+'&linked_recordIdValue='+masterRecordIdValue+'&linked_recordNameValue='+masterRecordNameValue,appLabel);
}
