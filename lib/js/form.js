getLanguageLib('form');

function formCheck(thisForm, fieldRequired, fieldDescription )
{
	var alertMsg = "";
	var nbr = 0;

	if( (thisForm.key.value in {'Save':'','Send':'','Convert':''}) == false )
		return true;
	
	for (var i = 0; i < fieldRequired.length; i++)
	{
		var thisField = thisForm.elements[fieldRequired[i]];
		if (thisField){
			switch(thisField.type)
			{
				case "select-one":
					// to handle special case when select is populated without any option selected
					if (thisField.options.length )
					{
						if( thisField.options[0].text != "" && thisField.selectedIndex == -1)
							thisField.selectedIndex = 0;
					}
					
					if (thisField.selectedIndex == -1 || thisField.options[thisField.selectedIndex].text == "")
					{
						alertMsg += "<li>" + fieldDescription[i] + "</li>";
						nbr++;
					}
					break;
				case "select-multiple":
					// to handle special case when select is populated without any option selected
					if (thisField.options.length )
					{
						if( thisField.options[0].text != "" && thisField.selectedIndex == -1)
							thisField.selectedIndex = 0;
					}

					if (thisField.selectedIndex == -1)
					{
						alertMsg += "<li>" + fieldDescription[i] + "</li>";
						nbr++;
					}
					break;
				case "text":
				case "textarea":
					if (thisField.value == "" || thisField.value == null)
					{
						alertMsg += "<li>" + fieldDescription[i] + "</li>";
						nbr++;
					}
					break;
				default:
					break;
			}
			
			if (thisField.type == undefined)
			{
				var blnchecked = false;
				for (var j = 0; j < thisField.length; j++)
				{
					if (thisField[j].checked)
					{
						blnchecked = true;
					}
				}
				if (!blnchecked)
				{
					alertMsg += "<li>" + fieldDescription[i] + "</li>";
					nbr++;
				}
			}
		}
	}

	if ( nbr == 0 )
		return true;
		
	Dialog.alert( 
		'<div style="padding:10px;text-align:left">'+getTranslation('form','The following fields are mandatory')+':<ul>'+
			alertMsg+'</ul></div>', 
		{
			className: 		"dialog", 
			title:			getTranslation('common','Alert'),
			width: 			400, 
			okLabel: 		getTranslation('common','Ok')
		});
	return false;
}


function dateCheck(thisField)
{
	// Regular expression used to check if date is in correct format
	var pattern = '19|20[0-9]{2}-0|1[0-9]-[0-3][0-9]';
	var alertmsg = false;
	
	if( thisField.value == '' )
    	alertmsg = false;
	else if( thisField.value.match(pattern) == null )
	    alertmsg = true;
	else
	{
	    var date_array = thisField.value.split('-');
	    source_date = new Date(date_array[0],date_array[1]-1,date_array[2]);

	    if(date_array[0] != source_date.getFullYear())
	        alertmsg = true;
	    else if((date_array[1]-1) != source_date.getMonth())
	        alertmsg = true;
	    else if(date_array[2] != source_date.getDate())
	        alertmsg = true;
	}
	if( alertmsg )
	{
		Dialog.alert( 
			'<div style="padding:10px">'+getTranslation('form','Date format is not valid')+'</div>', 
			{
				className: 		"dialog", 
				title:			getTranslation('common','Alert'),
				width: 			400, 
				okLabel: 		getTranslation('common','Ok')
			});
		thisField.focus();
	    return false;
	}
	return true;
}

function emailCheck(thisField)
{
	// Regular expression used to check if email is in correct format
	var pattern = '^([_a-z0-9-]+)(\.[_a-z0-9-]+)*@([a-z0-9-]+)(\.[a-z0-9-]+)*(\.[a-z]{2,4})$';

	if( thisField.value.match(pattern) )
		return true;

	thisField.focus();
		
	Dialog.alert( 
		'<div style="padding:10px">'+getTranslation('form','Email format is not valid')+'</div>', 
		{
			className: 		"dialog", 
			title:			getTranslation('common','Alert'),
			width: 			400, 
			okLabel: 		getTranslation('common','Ok')
		});
	return false;
}


function timeCheck(thisField)
{
	// Regular expression used to check if time is in correct format
	var pattern = '[0-2]*[0-9]:[0-5]*[0-9]';
	var alertmsg = false;
	
	if( thisField.value == '' )
    	alertmsg = false;
	else if( thisField.value.match(pattern) == null )
	    alertmsg = true;
	else
	{
	    var time_array = thisField.value.split(':');
	    source_time = new Date(1970,1,1,time_array[0],time_array[1]);

	    if(time_array[0] != source_time.getHours())
	        alertmsg = true;
	    else if(time_array[1] != source_time.getMinutes())
	        alertmsg = true;
	}
	if( alertmsg )
	{
		Dialog.alert( 
			'<div style="padding:10px">'+getTranslation('form','Time format is not valid')+'</div>', 
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

	
function setCaretPosition(ctrl, pos)
{

	if(ctrl.setSelectionRange)
	{
		ctrl.focus();
		ctrl.setSelectionRange(pos,pos);
	}
	else if (ctrl.createTextRange) {
		var range = ctrl.createTextRange();
		range.collapse(true);
		range.moveEnd('character', pos);
		range.moveStart('character', pos);
		range.select();
	}
}

function insertTimeStamp( ctrl, fullName, top)
{

	var now = new Date();
	
	if ( now.getYear() >= 2000 )
		year = now.getYear();
	else
		year = 1900+now.getYear();
	
	var newText = '*** '+fullName+' *** '+year+'-'+(1+now.getMonth('mm'))+'-'+now.getDate()+' '+now.getHours()+':'+now.getMinutes()+':'+now.getSeconds();

	if( top == true )
	{
		ctrl.value = newText+'\n \n\n'+ctrl.value;
		setCaretPosition( ctrl, newText.length+1);
	}	
	else
	{
		ctrl.value += '\n\n'+newText+' \n';
		setCaretPosition( ctrl, ctrl.value.length);
	}	
}

function extractFilename(what) 
{
    if (what.indexOf('/') > -1)
        answer = what.substring(what.lastIndexOf('/')+1,what.length);
    else
        answer = what.substring(what.lastIndexOf('\\')+1,what.length);
    return answer;
}

function checkReminder(nbr, period, field_type)
{
	if( nbr.value == '' )
		period.value = '';
	else if( field_type == 'RM' && period.value == '' )
		period.value = 'M';
	else if( field_type == 'RD' )
	{
		if( nbr.value == '0' || period.value == '' )
			period.value = 'D';
	}
	
	return nbr.value+'.'+period.value;
}
		
function checkPassword(pwd1, pwd2)
{
	var ret = pwd1;
	
	if( pwd1 != pwd2 )
	{
		ret_msg = getTranslation('form','Please enter twice the same new password'); 
		ret = false;
	}
	else if( calcPwdStrength(pwd1) < 2 )
	{
		ret_msg = getTranslation('form','New password is too weak'); 
		ret = false;
	}
	
	if( ret == false )
		Dialog.alert('<div style="padding:10px">'+ret_msg+'</div>',{className:"dialog",title:getTranslation('common','Alert'),width:400,okLabel:getTranslation('common','Ok')});
		
	return ret;
}	

function calcPwdStrength(pwd)
{
	var score = Math.round(pwd.length/3);

	if(/\w/.test(pwd) && /\d/.test(pwd))
		score++;

	if( pwd.toUpperCase() != pwd && pwd.toLowerCase() != pwd)
		score++;
	
	return score;
}	

// confirmation of bulk assignment
function checkAssignAll(thisField)
{
	if( thisField.checked == true )
		Dialog.confirm(
			'<div style="padding:10px">'+getTranslation('common','Please confirm this action')+'</div>', 
			{
				className: 		'dialog',
				title:			getTranslation('common','Assign all related records'),
				width:			400, 
				cancelLabel: 	getTranslation('common','Cancel'), 
				cancel:function(win) 
				{
					thisField.checked = false;
					thisField.value = 'N';
					return false;
				},
				okLabel: 		getTranslation('common','Ok'), 
				ok:function(win) 
				{
					thisField.checked = true;
					thisField.value = 'Y';
					return true;
				}
			}); 		
}	

var	fieldInc = 0;


