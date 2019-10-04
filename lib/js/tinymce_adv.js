tinyMCE.init({
	mode : "specific_textareas",
	editor_selector : "mceEditor",
	theme : "advanced",
	plugins : "AppShore,table,insertdatetime,preview,searchreplace,print,paste,noneditable,visualchars,nonbreaking,spellchecker,media,fullscreen",
	theme_advanced_buttons1 : "newdocument,separator,cut,copy,paste,pastetext,pasteword,separator,undo,redo,separator,search,replace,separator,print,preview,separator,spellchecker,AppShoreTemplates,AppShoreSignatures,AppShoreDynamicFields,fullscreen",
	theme_advanced_buttons2 : "fontselect,fontsizeselect,bold,italic,underline,strikethrough,sub,sup,separator,justifyleft,justifycenter,justifyright,justifyfull,separator,bullist,numlist,separator,outdent,indent,separator,forecolor,backcolor",
	theme_advanced_buttons3 : "link,unlink,image,media,anchor,separator,removeformat,visualchars,visualaid,cleanup,code,separator,insertdate,inserttime,separator,hr,charmap,nonbreaking,separator,tablecontrols",
	theme_advanced_toolbar_location : "top",
	theme_advanced_toolbar_align : "left",
	//theme_advanced_path_location : "bottom",
	theme_advanced_resize_horizontal : false,
	theme_advanced_resizing : false,
	plugin_insertdate_dateFormat : "%Y-%m-%d",
	plugin_insertdate_timeFormat : "%H:%M:%S",
	nonbreaking_force_tab : true,
	forced_root_block : false,
	force_p_newlines : false,
	remove_linebreaks : false,
	force_br_newlines : true,
	remove_trailing_nbsp : false,
	convert_urls : false,
	spellchecker_rpc_url : basepath+'/includes/tiny_mce/plugins/spellchecker/rpc.php',
	spellchecker_languages : "+English=en,Español=es,Français=fr",
	language : "en",	
	apply_source_formatting : true,
	sid : sid 
});

function stripHTML(oldString) {
	//function to strip all html
	var newString = oldString.replace(/(<([^>]+)>)/ig,"");
	
	//replace carriage returns and line feeds
   	newString = newString.replace(/\n\n/g,"\n");
   	newString = newString.replace(/\r/g,"");
	newString = newString.replace(/&nbsp;/g," ");	 
	
	return newString;
}

