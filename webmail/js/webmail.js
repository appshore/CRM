function emailCheckMultiple( thisForm, fieldChecked, fieldDescription)
{
	var alertMsg = '';
	// Regular expression used to check if email is in correct format
	var pattern = '^([_a-z0-9-]+)(\.[_a-z0-9-]+)*@([a-z0-9-]+)(\.[a-z0-9-]+)*(\.[a-z]{2,4})$';
	
	for (var k = 0; k < fieldChecked.length; k++)
	{
		var thisField = thisForm.elements[fieldChecked[k]];

		if( thisField.value.trim() == '' )
			continue;
		
		// separate each email address
		var manyaddresses = thisField.value.toLowerCase().replace(';', ',').replace('\n', ',').split(',');
	
		var ret = false;
		// we are looking for at least one valid email, if not then alert
		for( var i = 0 ; i < manyaddresses.length ; i++ )
		{
			// separate email address from label
			var addresses = manyaddresses[i].replace('<', ' ').replace('>', ' ').split(' ');
			for( var j = 0 ; j < addresses.length ; j++ )
			{
				if( addresses[j].trim().match(pattern) )
					ret = true;
			}
		}

		if( ret == false )
			alertMsg += "<li>" + fieldDescription[k] + "</li>";
		
	}

	if( alertMsg.length )
	{
		Dialog.alert( 
			'<div style="padding:10px;text-align:left">'+getTranslation('form','Email format is not valid')+':<ul>'+
				alertMsg+'</ul></div>', 
			{
				className: 		"dialog", 
				title:			getTranslation('common','Alert'),
				width: 			400, 
				okLabel: 		getTranslation('common','Ok')
			});
		return false;
	}
			
	return true;
} 

function getAttachmentID( thisForm, selected, field_name)
{
	selected.value = '';
	
	for (var i = 0; i < thisForm.elements.length ; i++)
		if ( thisForm.elements[i].type == 'checkbox' && thisForm.elements[i].name == field_name)
		{
			if ( i > 0 && selected.value.length )
				selected.value += ',';
			selected.value += (thisForm.elements[i].checked?'+':'-')+thisForm.elements[i].value;
		}
}	

function webmail_submit( thisForm)
{
	if( formCheck( thisForm, Array('mail_to', 'mail_from', 'subject'), Array('To', 'From', 'Subject')) == false )
		return false;
		
	if( emailCheckMultiple( thisForm, Array('mail_to', 'mail_from', 'mail_cc', 'mail_bcc'), Array('To', 'From', 'Cc', 'Bcc')) == false )
		return false;
		
	getAttachmentID(thisForm,thisForm.selectedDocuments,'document_ids');
	getAttachmentID(thisForm,thisForm.selectedFiles,'file_ids');

	return true;
}
