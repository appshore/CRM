/**
 * $Id: editor_plugin_src.js 201 2007-02-12 15:56:56Z spocke $
 *
 * @author Moxiecode
 * @copyright Copyright © 2004-2008, Moxiecode Systems AB, All rights reserved.
 */

(function() {
	// Load plugin specific language pack
	tinymce.PluginManager.requireLangPack('dynamicFields');

	tinymce.create('tinymce.plugins.dynamicFieldsPlugin', {
		/**
		 * Initializes the plugin, this will be executed after the plugin has been created.
		 * This call is done before the editor instance has finished it's initialization so use the onInit event
		 * of the editor instance to intercept that event.
		 *
		 * @param {tinymce.Editor} ed Editor instance that the plugin is initialized in.
		 * @param {string} url Absolute URL to where the plugin is located.
		 */
		init : function(ed, url) {
			// Register the command so that it can be invoked by using tinyMCE.activeEditor.execCommand('mcedynamicFields');
			ed.addCommand('mcedynamicFields', function() {
				ed.windowManager.open({
					file : url + '/dialog.htm',
					width : 320 + parseInt(ed.getLang('dynamicFields.delta_width', 0)),
					height : 120 + parseInt(ed.getLang('dynamicFields.delta_height', 0)),
					inline : 1
				}, {
					plugin_url : url, // Plugin absolute URL
					some_custom_arg : 'custom arg' // Custom argument
				});
			});

			// Register dynamicFields button
			ed.addButton('dynamicFields', {
				title : 'dynamicFields.desc',
				cmd : 'mcedynamicFields',
				image : url + '/img/dynamicFields.gif'
			});

			// Add a node change handler, selects the button in the UI when a image is selected
			ed.onNodeChange.add(function(ed, cm, n) {
				cm.setActive('dynamicFields', n.nodeName == 'IMG');
			});
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
			switch (cn) {
				case "dynamicsFields":
					var fontHTML = '<select id="{$editor_id}_fontNameSelect" name="{$editor_id}_fontNameSelect" onfocus="tinyMCE.addSelectAccessibility(event, this, window);" onchange="tinyMCE.execInstanceCommand(\'{$editor_id}\',\'FontName\',false,this.options[this.selectedIndex].value);" class="mceSelectList"><option value="">{$lang_theme_fontdefault}</option>';
					var iFonts = 'Arial=arial,helvetica,sans-serif;Courier New=courier new,courier,monospace;Georgia=georgia,times new roman,times,serif;Tahoma=tahoma,arial,helvetica,sans-serif;Times New Roman=times new roman,times,serif;Verdana=verdana,arial,helvetica,sans-serif;Impact=impact;WingDings=wingdings';
					var nFonts = 'Andale Mono=andale mono,times;Arial=arial,helvetica,sans-serif;Arial Black=arial black,avant garde;Book Antiqua=book antiqua,palatino;Comic Sans MS=comic sans ms,sand;Courier New=courier new,courier;Georgia=georgia,palatino;Helvetica=helvetica;Impact=impact,chicago;Symbol=symbol;Tahoma=tahoma,arial,helvetica,sans-serif;Terminal=terminal,monaco;Times New Roman=times new roman,times;Trebuchet MS=trebuchet ms,geneva;Verdana=verdana,geneva;Webdings=webdings;Wingdings=wingdings,zapf dingbats';
					var fonts = tinyMCE.getParam("theme_advanced_fonts", nFonts).split(';');
					for (i=0; i<fonts.length; i++) {
						if (fonts[i] != '') {
							var parts = fonts[i].split('=');
							fontHTML += '<option value="' + parts[1] + '">' + parts[0] + '</option>';
						}
					}

					fontHTML += '</select>';
					return fontHTML;
			}

			return "";
		},

		/**
		 * Returns information about the plugin as a name/value array.
		 * The current keys are longname, author, authorurl, infourl and version.
		 *
		 * @return {Object} Name/value array containing information about the plugin.
		 */
		getInfo : function() {
			return {
				longname : 'dynamicFields',
				author : 'Brice Michel - AppShore Inc',
				authorurl : 'http://www.appshore.com',
				infourl : 'http://',
				version : tinyMCE.majorVersion + "." + tinyMCE.minorVersion
			};
		}
	});

	// Register plugin
	tinymce.PluginManager.add('dynamicFields', tinymce.plugins.dynamicFieldsPlugin);
})();
