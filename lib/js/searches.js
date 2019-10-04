var Searches = Class.create(
{

	initialize: function(searchForm, appName, appLabel)
	{
		getLanguageLib('searches');
		this.searchForm = searchForm;
		this.appName = appName;
		this.appLabel = appLabel;
  	},	
	
	getSearches: function(mySelect)
	{
    	for (var i = mySelect.options.length-1; i > 0; i--)
			if( mySelect[i].value )
				mySelect.remove(i);

		var params = 
		{
			method: 'post', 
			postBody: 'sid='+sid
				+'&op=base.searches_ajax.getSearches'
				+'&app_name='+this.appName,
			onSuccess: function(t)
			{
				nodesId = t.responseXML.getElementsByTagName('search_id');
				nodesName = t.responseXML.getElementsByTagName('search_name');
				nodesDefault = t.responseXML.getElementsByTagName('is_default');
				offset = mySelect.options.length;
		    	for (var i = 0; nodesId.length > i; i++)
		    	{
					mySelect.options[i+offset] = new Option(nodesName[i].firstChild.data+(nodesDefault[i].firstChild.data=='Y'?' *':''), nodesId[i].firstChild.data, false);
					mySelect.options[i+offset].style.padding = '0 0 0 2em';
				}
			}									
		};
		new Ajax.Request('raw.php', params);
	},
	
	menuSelect: function(mySelect)
	{
		if( mySelect.selectedIndex == 0)
			return false;
		else if( mySelect.selectedIndex == 1)
			this.savePopup(mySelect);
		else if( mySelect.selectedIndex == 2)
			 window.location = "?&op=preferences.searches_base.start";
		else
			this.loadSearch(mySelect);
	},	
	
	loadSearch: function(mySelect)
	{
		var thisClass = this; // needed for embedded functions
		var params = 
		{
			method: 'post', 
			postBody: 'sid='+sid
				+'&op=base.searches_ajax.loadSearch'
				+'&app_name='+this.appName
				+'&search_id='+mySelect[mySelect.selectedIndex].value,
			onSuccess: function(t)
			{
				thisClass.runSearch( t.responseXML.getElementsByTagName('search_filter')[0].firstChild.data.evalJSON());
			}									
		};
		gr = top.growler.nobox(getTranslation('common','Loading...'));
		new Ajax.Request('raw.php', params);
	},	
	
	runSearch: function ( data)
	{
		var uri;
		
		uri = _(data).chain().map( function(val, key) {
			if( val != "" && ['op','search','clear'].indexOf(key) == -1 )
			{
				if( key.match(/\[\]/) == '[]' )
				{
					var Arr = val.toString().split(',');
					var flat = "";
					
					for( var i = 0 ; i < Arr.length ; i++ )
						flat += "&"+key+"="+Arr[i];
				
					return flat;
				}

				return "&"+key+"="+val;
			}
		}).value();

		window.location = "?&op="+data.op+"&key=LoadSearch"+uri.join("");
	},
	
	saveSearch: function(savedName, isDefault, mySelect, isNew)
	{
		var thisClass = this; // needed for embedded functions
		
		var params = 
		{
			method: 'post', 
			postBody: 'sid='+sid
				+'&op=base.searches_ajax.saveSearch'
				+'&app_name='+this.appName
				+'&search_id='+mySelect[mySelect.selectedIndex].value
				+'&search_name='+savedName
				+'&is_default='+isDefault
				+'&search_filter='+$H($(this.searchForm).serialize(true)).toJSON(),
			onSuccess: function(t)
			{
				top.growler.ungrowl(gr);
				if (t.responseXML.getElementsByTagName('return')[0].firstChild.data == 'success' )
				{
					top.growler.notice(getTranslation('searches','Search filter created'));
					if( isNew == true )
						thisClass.getSearches(mySelect);
				}
				else
					top.growler.error(getTranslation('searches','Search filter not created'));
			}									
		};

		gr = top.growler.nobox(getTranslation('common','Updating...'));
		new Ajax.Request('raw.php', params);
	},
	
	savePopup: function(mySelect)
	{
		var thisClass = this; // needed for embedded functions
		Dialog.confirm(
			'<div style="padding:10px;text-align:left">'+getTranslation('searches','Enter the name of this new search')+'</div>'+
			'<div style="padding:0 10px 10px 10px;text-align:left;"><input id="dialogName" style="width:370px" type="text"/></div>'+ 
			'<div style="padding:10px;text-align:left">'+getTranslation('searches','Default search')+'</div>'+
			'<div style="padding:0 10px 10px 10px;text-align:left;"><input id="dialogDefault" type="checkbox"/></div>', 
			{
				className: 		"dialog", 
				title:			getTranslation('searches',this.appLabel),
				width: 			400, 
				okLabel: 		getTranslation('common','Ok'), 
				cancelLabel: 	getTranslation('common','Cancel'),
				onCancel:function(win)
				{
					mySelect.selectedIndex=0;
					return true;
				},
				onOk:function(win)
				{
					mySelect.selectedIndex=0;

					if( $('dialogName').value.length == 0 )
						return false;
						
					thisClass.saveSearch($('dialogName').value,$('dialogDefault').checked?'Y':'N',mySelect,true);

					return true;
				}
				
			});
	}
});


