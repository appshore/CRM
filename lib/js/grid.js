
function gridAllCheckbox( gridForm, state)
{	
	for (var i = 0; i < gridForm.elements.length ; i++)
		if (  gridForm.elements[i].type == 'checkbox' )
		{
			if( state == 'all' || state == $(gridForm.elements[i]).up('tr').className
				|| (state == 'old' && $(gridForm.elements[i]).up('tr').className != 'new') 
				)
			{
				gridForm.elements[i].checked = true;
				gridForm.elements[i].value = gridForm.elements[i].name;
			}
			else
			{
				gridForm.elements[i].checked = false;
				gridForm.elements[i].value = 0;
			}
		}
}

function gridCheckbox( gridField) 
{
	if ( gridField.checked == true )
		gridField.value = gridField.name;
	else
		gridField.value = 0;
}

function gridOrderBy( gridForm, sortColumn)
{
	if( gridForm.orderby.value != sortColumn )
	{
		gridForm.orderby.value = sortColumn;
		gridForm.ascdesc.value = 'ASC';
	}
	else
	{
		if(gridForm.ascdesc.value == 'ASC')
			gridForm.ascdesc.value = 'DESC';
		else 
			gridForm.ascdesc.value = 'ASC';
	}
	
	gridForm.submit();
}

function gridBulkClear( bulkForm)
{
	for (var i = 0; i < bulkForm.elements.length ; i++)
		if (  bulkForm.elements[i].name.match('bulk_') && bulkForm.elements[i].name != 'bulk_id')
		{
			bulkForm.elements[i].value = '';
			if( bulkForm.elements[i].type == 'checkbox' )	
				bulkForm.elements[i].checked = false;
		}
}

function gridBulkSave( bulkForm, selectedForm)
{
	if( $('bulk_id').value == 'Page')
		gridAllCheckbox( selectedForm, 'all');

	gridGetSelected( selectedForm, bulkForm.selected);
	bulkForm.key.value = 'Save';		
}	

function gridBulkKey( bulkForm, selectedForm, keyName, isConfirm, msg)
{
	if( $('bulk_id').value == 'Page')
		gridAllCheckbox( selectedForm, 'all');
	
	gridGetSelected( selectedForm, bulkForm.selected);
	
	if( $('bulk_id').value == 'Selected')
	{
		if( bulkForm.selected.value == '' )
		{
			Dialog.alert( 
				'<div style="padding:10px">'+getTranslation('common','No record selected')+'</div>', 
				{
					className: 		"dialog", 
					title:			getTranslation('common','Alert'),
					width: 			400, 
					okLabel: 		getTranslation('common','Ok')
				});
			return false;
		}
	}

	bulkForm.key.value = keyName;

	if( isConfirm == 'Y' || isConfirm == 'N' )
		confirmAction( bulkForm, isConfirm, msg);  

	return true;
}	

function gridGetSelected( gridForm, selected)
{
	selected.value = '';
	
	for (var i = 0; i < gridForm.elements.length ; i++)
		if (  gridForm.elements[i].type == 'checkbox' && gridForm.elements[i].checked == true && gridForm.elements[i].value != '0')
		{
			if ( i > 0 && selected.value.length )	
				selected.value += ',';
            selected.value += gridForm.elements[i].value;
		}
	return selected.value;
}


function gridRemoveSelected( gridForm, selected)
{
	var selectedRows = selected.value.split(',');
	for (var i = 0; i < selectedRows.length ; i++)
		$(gridForm.id+'_table').deleteRow($(gridForm.id+'_'+selectedRows[i]).rowIndex);
		
	if( $(gridForm.id+'_table').getElementsByTagName('tr').length <= 2 )
		$(gridForm.id+'_div').parentNode.removeChild($(gridForm.id+'_div'));
}
