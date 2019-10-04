	
	getLanguageLib('customization');

    function resizeBlock( elt) 
    {
    	var newHeight=0;
		$$('#'+elt.id+' .custom_box_dotted').each( function(elt) {
			newHeight += elt.getHeight()+2;
		});
		
		elt.setStyle({
			height: ((newHeight>40)?newHeight:40)+'px'
		});
    };	
	
    function serializeFields( items) 
    {
		var string = "";
        	for (var i = 0; items.length > i; i++) 
    		if( items[i].id )
    		{
                if(i)
                    string += ',';           
    			string += items[i].id;
    		}
        return string;   
    };	
		
	function saveForm( thisForm, appName) 
	{
		var fields='';		
		var items = $$('.used');
    	for (var i = 0; items.length > i ; i++)
    	{
       		if( items[i].id )
       		{
            	if(i)
                	fields += ';';           
				fields += items[i].id+':'+serializeFields($(items[i].id).getElementsByClassName('custom_box_dotted'));
			}
		}

		var params = 
		{
			method: 'post', 
			postBody: 'sid='+sid
				+'&op=administration.customization_'+thisForm+'.save'
				+'&app_name='+appName
				+'&fields='+fields,
			onSuccess: function(t){
//				top.growler.ungrowl(gr);
				if( t.responseXML.getElementsByTagName('return')[0].firstChild.data == 'success')
					top.growler.notice(getTranslation('common','Updated'));
				else
					top.growler.error(getTranslation('common','Error'));
			}									
		};

//		gr = top.growler.nobox(getTranslation('common','Updating...'));
		new Ajax.Request('raw.php', params);
	};
	
	function copyForm( thisForm, appName) 
	{
		var params = 
		{
			method: 'post', 
			postBody: 'sid='+sid
				+'&op=administration.customization_'+thisForm+'.copy'
				+'&app_name='+appName,
			onSuccess: function(t){
//				top.growler.ungrowl(gr);
				$(thisForm).submit();
			}									
		};

//		gr = top.growler.nobox(getTranslation('common','Updating...'));
		new Ajax.Request('raw.php', params);
	};		
	
	function restoreForm( thisForm, appName) 
	{
		var params = 
		{
			method: 'post', 
			postBody: 'sid='+sid
				+'&op=administration.customization_'+thisForm+'.restore'
				+'&app_name='+appName,
			onSuccess: function(t){
//				top.growler.ungrowl(gr);
				$(thisForm).submit();
			}									
		};

//		gr = top.growler.nobox(getTranslation('common','Updating...'));
		new Ajax.Request('raw.php', params);
	};

	function newBlock() 
	{
		$('block_id').selectedIndex = 0;
		$('block_name').value = getTranslation('customization','New block');
		$('is_title').checked = false;
		$('columns2').checked = true;
	};	
	
	function saveBlock( thisForm, appName) 
	{
		if( $('block_name').value == '' )
		{
			Dialog.alert( '<div style="padding:10px">' + getTranslation('customization','Block name is required') + '</div>', {className:"dialog", title:getTranslation('common','Alert'), width:400, okLabel:getTranslation('common','Ok')} );			
			return false;
		}
		
		saveForm(thisForm, appName);

		var params = 
		{
			method: 'post', 
			postBody: 'sid='+sid
				+'&op=administration.customization_'+thisForm+'.saveBlock'
				+'&app_name='+appName
				+'&form_name='+thisForm
				+($('block_id').selectedIndex?'&block_id='+$('block_id').value:'')
				+'&block_name='+$('block_name').value
				+'&is_title='+($('is_title').checked?'Y':'N')
				+'&columns='+($('columns1').checked?'1':'2'),
			onSuccess: function(t){
//				top.growler.ungrowl(gr);
				$(thisForm).submit();
			}									
		}

		new Ajax.Request('raw.php', params);
//		gr = top.growler.nobox(getTranslation('common','Updating...'));
	};		
	
	
	function deleteBlock(thisForm, appName) 
	{
		saveForm(thisForm, appName);

		var params = 
		{
			method: 'post', 
			postBody: 'sid='+sid
				+'&op=administration.customization_'+thisForm+'.deleteBlock'
				+'&app_name='+appName
				+'&block_id='+$('block_id').value,
			onSuccess: function(t){
//				top.growler.ungrowl(gr);
				$(thisForm).submit();
			}									
		};

//		gr = top.growler.nobox(getTranslation('common','Updating...'));
		new Ajax.Request('raw.php', params);
	};		
	
	function getBlock(thisForm, appName) 
	{	
		var params = 
		{
			method: 'post', 
			postBody: 'sid='+sid
				+'&op=administration.customization_'+thisForm+'.getBlock'
				+'&app_name='+appName
				+'&block_id='+$('block_id').value,
			onSuccess: function(t){		
					$('block_id').value = t.responseXML.getElementsByTagName('block_id')[0].firstChild.data;
					$('block_name').value = t.responseXML.getElementsByTagName('block_name')[0].firstChild.data;
					$('is_title').checked = (t.responseXML.getElementsByTagName('is_title')[0].firstChild.data == 'Y')?true:false;
					$('columns1').checked = (t.responseXML.getElementsByTagName('columns')[0].firstChild.data == '1')?true:false;
					$('columns2').checked = (t.responseXML.getElementsByTagName('columns')[0].firstChild.data == '2')?true:false;
			}														
		};
		new Ajax.Request('raw.php', params);
	};	

