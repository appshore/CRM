/**
 * $Id: editor_plugin_src.js 201 2007-02-12 15:56:56Z spocke $
 *
 * @author Moxiecode
 * @copyright Copyright © 2004-2008, Moxiecode Systems AB, All rights reserved.
 */

(function() {
	// Load plugin specific language pack
	tinymce.PluginManager.requireLangPack('AppShore');

	tinymce.create('tinymce.plugins.AppShorePlugin', {
	
		/**
		 * Returns information about the plugin as a name/value array.
		 * The current keys are longname, author, authorurl, infourl and version.
		 *
		 * @return {Object} Name/value array containing information about the plugin.
		 */
		getInfo : function() {
			return {
				longname : 'AppShore',
				author : 'Brice Michel - AppShore Inc',
				authorurl : 'http://www.appshore.com',
				infourl : 'http://',
				version : tinyMCE.majorVersion + "." + tinyMCE.minorVersion
			};
		},
	
		/**
		 * Creates control instances based in the incomming name. This method is normally not
		 * needed since the addButton method of the tinymce.Editor class is a more easy way of adding buttons
		 * but you sometimes need to create more complex controls like listboxes, split buttons etc then this
		 * method can be used to create those.
		 *
		 * @param {String} n Name of the control to create.
		 * @param {tinymce.ControlManager} cm Control manager to use inorder to create new control.
		 * @return {tinymce.ui.Control} New control instance or null if no control was created.
		 */
		createControl : function(n, cm) {

			switch (n) 
			{
				case "AppShoreDynamicFields":
					return this._getDynamicFields(cm);
					
				case "AppShoreTemplates":
					return this._getTemplates(cm);
					
				case "AppShoreSignatures":
					return this._getSignatures(cm);
			}
		},
		
		_getDynamicFields : function(cm) {
            var lb = cm.createListBox('dynamicFields', {
                title : 'Dynamic Fields',
                onselect : function(value) {
                	var app = value.split('.');
                	if(app[1])
 						tinyMCE.execCommand('mceInsertContent',false,'{'+app[1]+'}'); 
                	else
 						tinyMCE.execCommand('mceInsertContent',false,'{'+app[0]+'}'); 
               }
            });
			
			params = {
				method: 'post', 
				postBody: 'sid='+tinyMCE.activeEditor.getParam('sid')+'&op=webmail.ajax.getDynamicFields', 
				onComplete: function(t){
					var inc = 0;			
					while( t.responseXML.getElementsByTagName('field_name').item(inc) )
					{
	                    lb.add(
	                    	t.responseXML.getElementsByTagName('field_label').item(inc).firstChild.data, 
	                    	t.responseXML.getElementsByTagName('field_label').item(inc).firstChild.data 
						);
						inc++;
					}
				}
			};

			new Ajax.Request('raw.php', params);
			return lb;
		},

		
		_getTemplates : function(cm) {
            var lb = cm.createListBox('Templates', {
                title : 'Templates',
                onselect : function(value) {
						params = {
						method: 'post', 
						postBody: 'sid='+tinyMCE.activeEditor.getParam('sid')+'&op=webmail.ajax.getTemplate&template_id='+value, 
						onComplete: function(t){
							var body = '';
							var inc = 0;			
							while( t.responseXML.getElementsByTagName('body_html').item(inc) )
							{
								body += t.responseXML.getElementsByTagName('body_html').item(inc++).firstChild.data; 
							}
							
							tinyMCE.execCommand('mceInsertContent',false, body);

							if( $('subject').value.length == 0 )
								$('subject').value = t.responseXML.getElementsByTagName('subject').item(0).firstChild.data;
							}
						};
						
					new Ajax.Request('raw.php', params);
                }
            });
			
			params = {
				method: 'post', 
				postBody: 'sid='+tinyMCE.activeEditor.getParam('sid')+'&op=webmail.ajax.getTemplates', 
				onComplete: function(t){
					var inc = 0;			
					while( t.responseXML.getElementsByTagName('template_id').item(inc) )
					{
	                    lb.add(
	                    	t.responseXML.getElementsByTagName('template_name').item(inc).firstChild.data, 
	                    	t.responseXML.getElementsByTagName('template_id').item(inc).firstChild.data
						);
						inc++;
					}
				}
			};
			new Ajax.Request('raw.php', params);
			return lb;
		},

		
		_getSignatures : function(cm) {
            var lb = cm.createListBox('Signatures', {
                title : 'Signatures',
                onselect : function(value) {
						params = {
						method: 'post', 
						postBody: 'sid='+tinyMCE.activeEditor.getParam('sid')+'&op=webmail.ajax.getSignature&signature_id='+value, 
						onSuccess: function(t){
							tinyMCE.execCommand('mceInsertContent',false,
								t.responseXML.getElementsByTagName('signature_text').item(0).firstChild.data); 
							}
						};
					new Ajax.Request('raw.php', params);
                }
            });
			
			params = {
				method: 'post', 
				postBody: 'sid='+tinyMCE.activeEditor.getParam('sid')+'&op=webmail.ajax.getSignatures', 
				onComplete: function(t){
					var inc = 0;			
					while( t.responseXML.getElementsByTagName('signature_id').item(inc) )
					{
	                    lb.add(
	                    	t.responseXML.getElementsByTagName('signature_name').item(inc).firstChild.data, 
	                    	t.responseXML.getElementsByTagName('signature_id').item(inc).firstChild.data
						);
						inc++;
					}
				}
			};

			new Ajax.Request('raw.php', params);
			return lb;
		}
	});

	// Register plugin
	tinymce.PluginManager.add('AppShore', tinymce.plugins.AppShorePlugin);
})();
