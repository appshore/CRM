
function toBeDeleted( gridForm, selected)
{
	selected.value = '';
	
	for (var i = 0; i < gridForm.elements.length ; i++)
		if (  gridForm.elements[i].type == 'checkbox' && gridForm.elements[i].id == 'select' 
			&& gridForm.elements[i].checked == true && gridForm.elements[i].value != '0'
			&& gridForm.elements[i].name != 'check_all' )
		{
			if ( i > 0 && selected.value.length )	
				selected.value += ',';
            selected.value += gridForm.elements[i].value;
		}
		
	return selected.value;
}

function getTables(inc) 
{	
	var listSelectTable = $('related_table_'+inc);
	var listSelectId = $('related_id_'+inc);
	var listSelectName = $('related_name_'+inc);
	while( listSelectTable.options.length )
		listSelectTable.remove(listSelectTable.options.length-1);
	while( listSelectId.options.length )
		listSelectId.remove(listSelectId.options.length-1);
	while( listSelectName.options.length )
		listSelectName.remove(listSelectName.options.length-1);
								
	var params = 
	{
		method: 'post', 
		postBody: 'sid='+sid
			+'&op=administration.customization_fields.getTables'
			+'&field_type='+$('field_type_'+inc).value,
		onSuccess: function(t){				
				nodes = t.responseXML.getElementsByTagName('table_name');
				listSelectTable.options[0] = new Option( '', '', false);
	        	for (var i = 1; nodes.length >= i; i++) 
	        	{
	        		selectValue = nodes[i-1].firstChild.data;
					listSelectTable.options[i] = new Option( selectValue, selectValue, (selectValue == $('related_table_'+inc))?true:false);
				}
			}														
	};
	new Ajax.Request('raw.php', params);
};	

function getRelated(inc) 
{	
	var listSelectId = $('related_id_'+inc);
	var listSelectName = $('related_name_'+inc);
	while( listSelectId.options.length )
		listSelectId.remove(listSelectId.options.length-1);
	while( listSelectName.options.length )
		listSelectName.remove(listSelectName.options.length-1);
					
	if( $('related_table_'+inc).length == 0 )
		return;
						
	var params = 
	{
		method: 'post', 
		postBody: 'sid='+sid
			+'&op=administration.customization_fields.getRelated'
			+'&field_type='+$('field_type_'+inc).value
			+'&related_table='+$('related_table_'+inc).value,
		onSuccess: function(t){	
			if( ($('field_type_'+inc).value in {'DD':'','MV':''}) == true )
			{
				nodes = t.responseXML.getElementsByTagName('lookup_id');
        		selectValue = nodes[0].firstChild.data;
				listSelectId.options[0] = new Option( selectValue, selectValue, (selectValue == $('related_id_'+inc))?true:false);
				nodes = t.responseXML.getElementsByTagName('lookup_name');
        		selectValue = nodes[0].firstChild.data;
				listSelectName.options[0] = new Option( selectValue, selectValue, (selectValue == $('related_name_'+inc))?true:false);
			}
			else 
			{			
				nodes = t.responseXML.getElementsByTagName('field_name');
	        	for (var i = 0; nodes.length > i; i++) 
	        	{
	        		selectValue = nodes[i].firstChild.data;
					listSelectId.options[i] = new Option( selectValue, selectValue, (selectValue == $('related_id_'+inc))?true:false);
					listSelectName.options[i] = new Option( selectValue, selectValue, (selectValue == $('related_name_'+inc))?true:false);
				}
			}
		}														
	};
	new Ajax.Request('raw.php', params);
};	

function changeType(inc)
{
	switch( $('field_type_'+inc).value )
	{
		case 'DD':
		case 'DF':
		case 'MV':
		case 'RR':
			$('related_table_'+inc).disabled = $('related_id_'+inc).disabled = $('related_name_'+inc).disabled = false;
			getTables(inc);						
			break;
		default:
			$('related_table_'+inc).disabled = $('related_id_'+inc).disabled = $('related_name_'+inc).disabled = true;						
			break;
	}
};
	
function uniqueness(inc)
{
	is_unique = boxchecked($('checkbox_is_unique_'+inc),$('is_unique_'+inc));		

	Dialog.confirm(
		'<div style="padding:10px">'+getTranslation('common',(is_unique == 'Y')?'Creation of an unique index':'Suppression of an unique index')+'</div>', 
		{
			className: 		'dialog',
			title:			getTranslation('common','Confirm this action'),
			width:			400, 
			cancelLabel: 	getTranslation('common','Cancel'), 
			okLabel: 		getTranslation('common','Ok'), 
			cancel:function(win) 
			{
				return false;
			},
			ok:function(win) 
			{
				var params = 
				{
					method: 'post', 
					postBody: 'sid='+sid
						+'&op=administration.customization_fields.uniqueness'
						+'&app_name='+$('app_name').value
						+'&field_name='+$('field_name_'+inc).value
						+'&is_unique='+is_unique,
					onSuccess: function(t){	
						if(t.responseXML.getElementsByTagName('return')[0].firstChild.data == 'failure')
						{
							top.growler.error(getTranslation('common','Error'));
							$('checkbox_is_unique_'+inc).checked = false;
							$('is_unique_'+inc).value = 'N';
						}
						else
							top.growler.notice(getTranslation('common','Updated'));
						
					}														
				};
				new Ajax.Request('raw.php', params);
				return true;
			}
		}); 		

};	
