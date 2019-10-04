// prototype extension

String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
}
String.prototype.ltrim = function() {
	return this.replace(/^\s+/,"");
}
String.prototype.rtrim = function() {
	return this.replace(/\s+$/,"");
}


// form functions

function checkAll( Mycheck, MyForm)
{	
	for (var i = 0; i < MyForm.elements.length ; i++)
		if (  MyForm.elements[i].type == 'checkbox' && MyForm.elements[i].id == 'select')
		{
			MyForm.elements[i].checked = Mycheck.checked;
			if ( Mycheck.checked == true )
				MyForm.elements[i].value = MyForm.elements[i].name;
			else
				MyForm.elements[i].value = 0;			
		}
}

function isAllChecked( Mycheck, MyForm)
{
	for (var j = 0; j < MyForm.elements.length ; j++)
		if (  MyForm.elements[j].type == 'checkbox' && MyForm.elements[j].id == 'select' && MyForm.elements[j].checked != true && MyForm.elements[j].name != 'check_all')
		{
			for (var i = 0; i < MyForm.elements.length ; i++)
				if (  MyForm.elements[i].name == 'check_all' && MyForm.elements[i].id == 'select')
				{
					MyForm.elements[i].checked = false;
					MyForm.elements[i].value = 0;
				}	
			return false;
		}
		
	for (var i = 0; i < MyForm.elements.length ; i++)
		if (  MyForm.elements[i].name == 'check_all' && MyForm.elements[i].id == 'select')
		{
			MyForm.elements[i].checked = true;
			MyForm.elements[i].value = 1;
		}			
	return true;
}

function checkTheBox( Mycheck) 
{
	if ( Mycheck.checked == true )
		Mycheck.value = Mycheck.name;
	else
		Mycheck.value = 0;
}


function is_boxchecked( Mycheck) 
{
	if ( Mycheck.checked == true )
		Mycheck.value = 'Y';
	else
		Mycheck.value = 'N';
}

function boxchecked( check, checkHidden) 
{
	if ( check.checked == true )
		checkHidden.value = 'Y';
	else
		checkHidden.value = 'N';
		
	return checkHidden.value;
}

function confirmAction( thisForm, isConfirm, msg)
{
	if( isConfirm == 'N')
		thisForm.submit();
	else	
		Dialog.confirm(
			'<div style="padding:10px">'+getTranslation('common',msg?msg:'Please confirm this action')+'</div>', 
			{
				className: 		'dialog',
				title:			getTranslation('common','Confirm this action'),
				width:			400, 
				cancelLabel: 	getTranslation('common','Cancel'), 
				okLabel: 		getTranslation('common','Ok'), 
				ok:function(win) 
				{
					top.window.winReload=true;
					thisForm.submit();
				}
			}); 		
}	

// Translation
var Translations = 
{
	'activities': '',
	'common': '',
	'customization': '',
	'form': '',
	'lists': '',
	'notifications': '',
	'searches': '',
	'tags': ''
}

function getTranslation( thisLib, msg)
{
 	return (typeof Translations[thisLib][msg] == 'undefined') ? msg : Translations[thisLib][msg];
}	

function getLanguageLib(thisLib)
{
	$A(document.getElementsByTagName('script')).findAll( function(s) 
		{
    		return (s.src && s.src.indexOf('common.js') != -1 )
		}).each( function(s) 
			{
				// params[0] = path, params[1] = language
				var params = s.src.split('common.js?language=');
				if( ['fr','es','ja'].include(params[1]) == true )
					document.write('<script type="text/javascript" src="'+params[0]+'translations/'+thisLib+'_'+params[1]+'.js"><\/script>');
			}
	);
}

getLanguageLib('common');
	

// general functions

function printWindow(){window.print();}

function mailpage(){mail_str = "mailto:?subject=" + document.title;mail_str += "&body=" + document.title;mail_str += ": " + location.href;location.href = mail_str;}


//Panel
function panelContract(img, cid, imgcontract)
{
	$(img).src = imgcontract;
	$('right_panel').width = top.document.viewport.getWidth();			
	$(cid).style.display = 'none';
	return $(cid).style.display ;
}

function panelExpand(img, cid, imgexpand)
{
	$(img).src = imgexpand;
	$('right_panel').width = top.document.viewport.getWidth()-160;			
	$(cid).style.display = 'block';
	return $(cid).style.display ;
}

function setPanel(img, cid, imgcontract, imgexpand)
{
	Cookie.set( cid, ($(cid).style.display == 'block') ? panelContract( img, cid, imgcontract) : panelExpand( img, cid, imgexpand));
	return true;
}

//boxes
function boxContract(img, cid, imgcontract)
{
	$(img).src = imgcontract;
	$('right_panel').width = top.document.viewport.getWidth();			
	$(cid).style.display = 'none';
	return $(cid).style.display ;
}

function boxExpand(img, cid, imgexpand)
{
	$(img).src = imgexpand;
	$('right_panel').width = top.document.viewport.getWidth()-160;			
	$(cid).style.display = 'block';
	return $(cid).style.display ;
}

function setBox(img, cid, imgcontract, imgexpand)
{
//	Cookie.set( cid, ($(cid).style.display == 'block') ? boxContract( img, cid, imgcontract) : boxExpand( img, cid, imgexpand));
	($(cid).style.display == 'block') ? boxContract( img, cid, imgcontract) : boxExpand( img, cid, imgexpand);
	return true;
}


// screen, windows function

function getStyleBackGroundColor(el) 
{
	if(el.currentStyle)
		return el.currentStyle.backgroundColor;
	if(document.defaultView)
		return document.defaultView.getComputedStyle(el, '').getPropertyValue("background-color");
}

function getStyleColor(el) 
{
	if(el.currentStyle)
		return el.currentStyle.color;
	if(document.defaultView)
		return document.defaultView.getComputedStyle(el, '').getPropertyValue("color");	
}

function rgbConvert(str) {
   str = str.replace(/rgb\(|\)/g, "").split(",");
   str[0] = parseInt(str[0], 10).toString(16).toLowerCase();
   str[1] = parseInt(str[1], 10).toString(16).toLowerCase();
   str[2] = parseInt(str[2], 10).toString(16).toLowerCase();
   str[0] = (str[0].length == 1) ? '0' + str[0] : str[0];
   str[1] = (str[1].length == 1) ? '0' + str[1] : str[1];
   str[2] = (str[2].length == 1) ? '0' + str[2] : str[2];
   return (str.join(""));
}


//overlib and popup related functions


function getBackTuple()
{
	this.fName = new Array();
	this.fId = new Array();
	
	for(var i = 0 ; i < arguments.length; ) 
	{
		this.fName[i] = arguments[i] ;
		this.fId[i] = arguments[i+1] ;
		i += 2;
	}
}

function passBackTuple()
{
	for(var i = 0 ; i < arguments.length; ) 
	{
		this.parent.retrieve.fName[i].value = arguments[i] ;
		this.parent.retrieve.fId[i].value = arguments[i+1] ;
		i += 2;
	}	
	if( typeof(this.parent.retrieve.fId[0].onchange) == 'function')
	{
		this.parent.retrieve.fId[0].onchange();	
		return false;
	}
	return true;	
}


function popupAlert(text1)
{
	Dialog.alert( 
		'<div style="padding:10px">'+text1+'</div>', 
		{
			className: 		"dialog", 
			title:			getTranslation('common','Alert'),
			width: 			400, 
			okLabel: 		getTranslation('common','Ok')
		}
	);
}
		
function contextualMenu( view, label)
{
	edit = view.replace(/.view/, ".edit");
	html = '<table><tr><td><a href="'+view+'" />'+getTranslation('common','View')+' '+label+'</a></td></tr><tr><td><a href="'+edit+'" />'+getTranslation('common','Edit')+' '+label+'</a></td></tr></table>';
	overlib( html, WRAP, DELAY, 100, STICKY, MOUSEOFF, FGCLASS, 'popupcontent', BGCLASS, 'popupborder', TEXTFONTCLASS, 'popuptext', TIMEOUT, 1000);
}

function contextualHelp( label)
{
	html = '<table><tr><td>'+label+'</td></tr></table>';
	overlib( html, WRAP, DELAY, 100, STICKY, MOUSEOFF, RELX, 120, OFFSETY, 0, FGCLASS, 'popupcontent', BGCLASS, 'popupborder', TEXTFONTCLASS, 'popuptext', TIMEOUT, 1000);
}

function popupDetails( url)
{
	overlib('<iframe id="popupfrm" height="0" onLoad="this.height=this.contentWindow.document.body.scrollHeight;" src="'+url+'" width="100%" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" vspace="0" hspace="0"/>', 	DELAY, 1000, WIDTH, 700, STICKY, NOCLOSE, MOUSEOFF, OFFSETY, 10, OFFSETX, 10, HAUTO, VAUTO, FGCLASS, 'popupcontent', BGCLASS, 'popupborder', TEXTFONTCLASS, 'popuptext', TIMEOUT, 10000);
}	

function popupImgDetails( url, title, imagePath, width, height)
{
	overlib( '<iframe id="popupfrm" src="'+url+'" height="'+height+'" width="'+width+'" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" vspace="0" hspace="0" />', CAPTION, title, WIDTH, width, HEIGHT, height, DELAY, 1000, STICKY, NOCLOSE, MOUSEOFF, 750, OFFSETY, 10, OFFSETX, 10, HAUTO, VAUTO, FGCLASS, 'popupcontent', BGCLASS, 'popupborder', TEXTFONTCLASS, 'popuptext', CAPTIONFONTCLASS, 'popuptitle', TIMEOUT, 10000);
}

function popupInter( url1, title1)
{
	parent.cClick();
	top.window.Window.overlayShowEffectOptions = null;
	top.window.Window.overlayHideEffectOptions = null;
	var winWidth = top.document.viewport.getWidth()*0.9;
	var winHeight = top.document.viewport.getHeight()*0.9;	
	
	var win = new top.window.Window({
		height:		winHeight,
		width:		winWidth,
		hideEffect:	Element.hide,
		wiredDrag: 	true,
		title:		title1,
		url:		url1
		}); 
	win.showCenter();
}

function popupIntra( url1, title1)
{
	parent.cClick();
	top.window.Window.overlayShowEffectOptions = null;
	top.window.Window.overlayHideEffectOptions = null;
	var winWidth = top.document.viewport.getWidth()*0.9;
	var winHeight = top.document.viewport.getHeight()*0.9;	
	
	var win = new top.window.Window({
		width:		winWidth,
		hideEffect:	Element.hide,
		wiredDrag: 	true,
		title:		title1,
		url:		url1,
		onload:		function()
			{					
				var popupHeight = top.document.viewport.getHeight()*0.8;	
				var scrollHeight = win.getContent().contentWindow.document.body.scrollHeight;	
				
				popupHeight = (popupHeight > winHeight ) ? winHeight : popupHeight;	
				popupHeight = (popupHeight > scrollHeight && scrollHeight) ? scrollHeight : popupHeight;	
				
				win.setSize(winWidth,popupHeight);
				win.showCenter();
			}
		}); 
	win.showCenter();
}

var winReload = false;
function popupClose()
{
	if( top.window.winReload == true)
	{
		top.location.target = '_top';
		top.location.href = parent.location.href;
		top.window.winReload = false;
	}
	
	top.window.Windows.getFocusedWindow().close();
	return true;
}

function popupClose2(masterform)
{

	if( top.window.winReload == true)
	{
		top.window.winReload = false;
		top.window.$(masterform).isreload.value = 'true';
		top.window.$(masterform).submit();
	}
	
	top.window.Windows.getFocusedWindow().close();
	return true;
}
