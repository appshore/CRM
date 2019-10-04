/**
 * *************************************************************************\
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by MF MICHEL <mfmichel@appshore.com>                   *
 * Copyright (C) 2004 - 2007 MF MICHEL                                      *
 * portions by Brice MICHEL <bmichel@appshore.com>                          *
 * Copyright (C) 2004 - 2007 Brice MICHEL                                   *
 * -------------------------------------------------------------------------*
 * This program is free software; you can redistribute it and/or modify it  *
 * under the terms of the GNU General Public License as published by the    *
 * Free Software Foundation; either version 2 of the License, or (at your   *
 * option) any later version.                                               *
 * \*************************************************************************
 */

var notsaved = false;


function builder_submit( thisForm)
{
	if( formCheck( thisForm, Array('report_name', 'field_name'), Array('Report Name', 'Fields') ) == true )
	{
		buildGroupby();
		buildFilter();
		return true;
	}
	return false;
}



function changeTable()
{
	var fieldsAvailable = $('fields_available');
	while( fieldsAvailable.options.length )
		fieldsAvailable.remove(fieldsAvailable.options.length-1);
	var fieldsUsed = $('fields_selected');
	while( fieldsUsed.options.length )
		fieldsUsed.remove(fieldsUsed.options.length-1);
								
	var params = 
	{
		method: 'post', 
		postBody: 'sid='
			+sid
			+'&op=reports.ajax.getTableFields'
			+'&table_name='+$F('table_name'),
		onSuccess: function(t){
				// get field type
				// retrieve select value and label	
				names = t.responseXML.getElementsByTagName('field_name');
				labels = t.responseXML.getElementsByTagName('field_label');
	        	for (var i = 0; names.length > i; i++) 
	        	{
					fieldsAvailable.options[i] = new Option( labels[i].firstChild.data,	names[i].firstChild.data);
				}
			},
		onFailure: function(t){
			top.growler.error(getTranslation('common','Error'));
			}														
	};
	new Ajax.Request('raw.php', params);
}	
	
// reset all operator when a field changes	
function setGroupby(inc) 
{	
	$('groupby'+inc).checked = false ;
	$('count'+inc).checked = false ;
	$('sum'+inc).checked = false ;
	$('average'+inc).checked = false ;
	$('minimum'+inc).checked = false ;
	$('maximum'+inc).checked = false ;
}	

// reset all operator when a field changes	
function setFilter(inc) 
{	
	params = {
		parameters: 'sid='
			+sid
			+'&op=reports.ajax.getLookUp'
			+'&table_name='+$F('table_name')
			+'&field_name='+$F('filter'+inc),//$('filter'+inc).options[$('filter'+inc).selectedIndex].value,
		paramName: 'field_value', 
		minChars: 1
		};
	new Ajax.Autocompleter('criteria'+inc,'criteria'+inc+'_auto_complete','raw.php',params);
}

// retrieve list of available filter operators according field type	
function getFilterOperators(inc) 
{	
	var listSelectOperation = $('operator'+inc);
	// reset the operators list first
	while( listSelectOperation.options.length )
		listSelectOperation.remove(listSelectOperation.options.length-1);
								
	var params = 
	{
		method: 'post', 
		postBody: 'sid='
			+sid
			+'&op=reports.ajax.getFilterOperators'
			+'&table_name='+$F('table_name')
			+'&field_name='+$F('filter'+inc),
		onSuccess: function(t){
				// get field type
				// retrieve select value and label	
				name_nodes = t.responseXML.getElementsByTagName('operator_id');
				label_nodes = t.responseXML.getElementsByTagName('operator_label');
	        	for (var i = 0; name_nodes.length > i; i++) 
	        	{
					listSelectOperation.options[i] = new Option( 
						label_nodes[i].firstChild.data,	name_nodes[i].firstChild.data, 
						(name_nodes[i].firstChild.data == $('operator'+inc))?true:false);
				}
				$('field_type'+inc).value = t.responseXML.getElementsByTagName('field_type')[0].firstChild.data;
		       	showopdiv(inc);
				$('criteria'+inc).value = '' ;
				$('period'+inc).value = '' ;
			},
		onFailure: function(t){
			top.growler.error(getTranslation('common','Error'));
			}														
	};
	new Ajax.Request('raw.php', params);
}	
		
function buildGroupby() 
{ 
	var line;
	
	$('groupbyfields').value = '';
	
    for ( i = 1 ; i <= $('groupbylines').value ; i++) 
	{
		line = '';

		// group field must be unique
		for( j = 1 ; j < i ; j++ )
			if ($('field'+i).value == $('field'+j).value )
				$('field'+i).value = '';
		
		if ($('field'+i).value.length )
		{ 		
			if ( $('groupby'+i).checked )
				line += '+grp';
			
			if ( $('count'+i).checked )
				line += '+cnt';
				
			if ( $('sum'+i).checked )
				line += '+sum';
				
			if ( $('average'+i).checked )
				line += '+avg';
				
			if ( $('minimum'+i).checked )
				line += '+min';
				
			if ( $('maximum'+i).checked )
				line += '+max';
				
			if( line.length )
			{
				line = $('field'+i).value+':'+line.substr(1);
				
				if ( $('groupbyfields').value.length )
					$('groupbyfields').value += '/'+line;
				else
					$('groupbyfields').value = line;
			}
		}
	}
}

function buildFilter() 
{ 
	var line;
	
	$('filtercriterias').value = '';

    for ( i = 1 ; i <= $('filterlines').value ; i++) 
	{
		line = '';
	
		if ( $('filter'+i).value.length && $('operator'+i).value.length )
		{ 
			switch( $('operator'+i).value )
			{
				case 'checked':
					line = 'Y';
					break;
				case 'notchecked':
					line = 'N';
					break;
				case 'period':
					line = $('period'+i).value;
					break;
				default:
					line = $('criteria'+i).value;
					break;	
			}
				
			if( line.length )
			{
				line = $('filter'+i).value+':'+$('operator'+i).value+':'+line;
				
				if ( $('filtercriterias').value.length )
					$('filtercriterias').value += '/'+line;
				else
					$('filtercriterias').value = line;
			}
		}
	}
}

function hidediv( prefix, inc) 
{
	$(prefix+inc).style.display = 'none';
}

function showdiv(prefix,inc) 
{
	$(prefix+inc).style.display = 'inline';
}

function showopdiv(inc) 
{
	switch ($('field_type'+inc).value)
	{
		case 'DA' :// Date: period or calendar
		case 'DT' :
		case 'TS' :
			hidediv('divl',inc);
			if ( $('operator'+inc).value == 'period' )
			{
				hidediv('divd',inc);
				hidediv('divc',inc); 
				showdiv('divp',inc);
			}
			else 
			{
				hidediv('divp',inc);
				showdiv('divc',inc);
				showdiv('divd',inc);
			}
			break;
		case 'L' :/* lookups */ 
		case 'V' :/* text value */ 
		default : 
			hidediv('divd',inc);
			hidediv('divp',inc);
			showdiv('divl',inc);
			showdiv('divc',inc); 
			break;
	}
}

function rebuildList( list) 
{ 
	$('selectedfields').value = '';						
    for ( var i=0 ; i < list.length ; i++) 
	{
		if ( i > 0 )	
			$('selectedfields').value += '/';				
		$('selectedfields').value += list.options[i].value;			
	}
	
	$$('.fieldSelectGroupby').each(	
		function(element)
		{
			var selec = $$('select#'+element.id+' option').find(function(ele){return !!ele.selected}).value;
;
			while( element.options.length )
				element.remove(element.options.length-1);

			var i=1;	
			$$('select#fields_selected option').each( 
				function( elt)
				{
					element.options[i] = new Option( elt.text, elt.value);
					if( elt.value == selec )
						element.options[i].selected = true;
					i++;
				}
			);
		}
	);
}


function moveAll( list1, list2) 
{
    list1len = list1.length ;
    for ( i=0; i<list1len ; i++)
	{
		list2len = list2.length;
		already = false;
		
		for ( j=0; j<list2len ; j++)
			if (list2.options[j].text == list1.options[i].text )
				already = true;
				
		if (already == false)
            list2.options[list2len]= new Option(list1.options[i].text, list1.options[i].value);
    }

	rebuildList(list2);
}

function moveSelected( list1, list2) 
{
    list1len = list1.length ;
    for ( i=0; i<list1len ; i++)
    {
        if (list1.options[i].selected == true ) 
		{
            list2len = list2.length;
			already = false;
			for ( j=0; j<list2len ; j++)
				if (list2.options[j].text == list1.options[i].text )
					already = true;
			if (already == false)
	            list2.options[list2len]= new Option(list1.options[i].text, list1.options[i].value);
        }
    }
	rebuildList(list2);
}

function removeSelected(list) 
{
    for ( i=(list.length-1); i>=0; i--) 
       if (list.options[i].selected == true ) 
          list.options[i] = null;
	rebuildList(list);     
}

function removeAll(list) 
{
    for ( i=(list.length-1); i>=0; i--) 
	    list.options[i] = null;
	rebuildList(list);     
}

function moveUp(list) 
{
	listlen = list.length ;
    for ( i=1; i<listlen ; i++) 
    	if (list.options[i].selected == true && list.options[i-1].selected == false)
		{ 
			swaptext = list.options[i-1].text ;
			swapvalue = list.options[i-1].value ;
			list.options[i-1].text = list.options[i].text;
			list.options[i-1].value = list.options[i].value;
			list.options[i].text = swaptext;
			list.options[i].value = swapvalue;
			list.options[i-1].selected = true;
			list.options[i].selected = false;
		}
	rebuildList(list);     
}

function moveDown(list) 
{
	listlen = list.length ;
    for ( i=listlen-2; i>=0 ; i--) 
    	if (list.options[i].selected == true && list.options[i+1].selected == false)
		{ 
			swaptext = list.options[i].text ;
			swapvalue = list.options[i].value ;
			list.options[i].text = list.options[i+1].text;
			list.options[i].value = list.options[i+1].value;
			list.options[i+1].text = swaptext;
			list.options[i+1].value = swapvalue;
			list.options[i+1].selected = true;
			list.options[i].selected = false;
		}
	rebuildList(list);     
}

function moveTop(list) 
{
	listlen = list.length ;
    for ( i=1; i<listlen ; i++)
		{ 
	    	if (list.options[i].selected == true )
			{
				j=0;
				while ( j < listlen)
				{ 
					if (list.options[j].selected == false )
					{
						swaptext = list.options[i].text ;
						swapvalue = list.options[i].value ;
						for ( k = i-1 ; k >= j ; k-- )
						{
							list.options[k+1].text = list.options[k].text;
							list.options[k+1].value = list.options[k].value;
						}
						list.options[j].text = swaptext;
						list.options[j].value = swapvalue;
						list.options[j].selected = true;
						list.options[i].selected = false;
						break;
					}
					else
						j++;
				}
			}
		}
	rebuildList(list);	
}

function moveBottom(list) 
{
	listlen = list.length ;
    for ( i=listlen-2; i>=0 ; i--)
		{ 
	    	if (list.options[i].selected == true )
			{
				j= listlen-1;
				while ( j >= 0)
				{ 
					if (list.options[j].selected == false )
					{
						swaptext = list.options[i].text ;
						swapvalue = list.options[i].value ;
						for ( k = i+1 ; k <= j ; k++ )
						{
							list.options[k-1].text = list.options[k].text;
							list.options[k-1].value = list.options[k].value;
						}
						list.options[j].text = swaptext;
						list.options[j].value = swapvalue;
						list.options[j].selected = true;
						list.options[i].selected = false;
						break;
					}
					else
						j--;
				}
			}
		}
	rebuildList(list);
}

