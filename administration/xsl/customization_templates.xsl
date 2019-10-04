<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="customization_templates">	

	<script type="text/javascript" src="{$lib_js_path}/form.js"/>		
	<script language="JavaScript" type="text/javascript" src="includes/tiny_mce/tiny_mce.js"/>

	<script language="Javascript" type="text/javascript">
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
			spellchecker_rpc_url : '<xsl:value-of select="$basepath" />/includes/tiny_mce/plugins/spellchecker/rpc.php',		
			spellchecker_languages : "+English=en",		
			apply_source_formatting : true,
			sid : sid 
		});
	</script>	
	<script language="Javascript" type="text/javascript">
		<![CDATA[	
		function stripHTML(oldString) {
			//function to strip all html
			var newString = oldString.replace(/(<([^>]+)>)/ig,"");
			
			//replace carriage returns and line feeds
		   	newString = newString.replace(/\n\n/g,"\n");
		   	newString = newString.replace(/\r/g,"");
			newString = newString.replace(/&nbsp;/g," ");	 
			
			return newString;
		}		
		]]>
	</script>		

		
	<form name="templates" method="post">
		<input type="hidden" name="op"  id="op" value="administration.customization_templates.edit"/>
		<input type="hidden" name="key" id="key" />

	<div class="formTitleTags start_float">
    	<xsl:value-of select="php:function('lang','Templates')"/>
	</div>
	
	<div class="helpmsg">
		<xsl:value-of disable-output-escaping="yes" select="php:function('lang','administration.customization.templates.help')"/>
	</div>
	
	<xsl:call-template name="templatesButtons">
			<xsl:with-param name="thisForm">templates</xsl:with-param>
			<xsl:with-param name="isTop">true</xsl:with-param>
	</xsl:call-template> 			

	<div class="clearboth fieldLabelContainer" style="padding:10px 0 0 0">
		<div class="fieldLabel start_float">
			<xsl:value-of select="php:function('lang','Select or create an email template')"/>
		</div>
		<div class="clearboth fieldText" >
			<select name="template_id" id="template_id" onchange="templates.submit();return true;">
				<option/>				
				<xsl:for-each select = "templates/templates_item" >
					<option value="{template_id}">
						<xsl:if test="template_id = /APPSHORE/APP/template/template_id">
					         <xsl:attribute name="selected" value="true"/>
					    </xsl:if>
				         <xsl:value-of select="template_name"/>
					</option>
				</xsl:for-each>	
			</select>
		</div>				
	</div>
	
	<div class="clearboth fieldLabelContainer" style="padding:10px 0 0 0">
		<div class="fieldLabel start_float">
			<xsl:value-of select="php:function('lang','Template name')"/>
		</div>
		<div class="clearboth fieldText" >
			<input type="text" size="40" name="template_name" id="template_name" value="{template/template_name}" />
		</div>				
	</div>
	<div class="clearboth fieldLabelContainer" style="padding:10px 0 0 0">
		<div class="fieldLabel start_float">
			<xsl:value-of select="php:function('lang','Subject')"/>
		</div>
		<div class="clearboth fieldText" >
			<input type="text" style="width:99%" name="subject" id="subject" value="{template/subject}" />
		</div>				
	</div>
	
	<div class="clearboth fieldLabelContainer" style="padding:10px 0 0 0">
		<div class="fieldLabel start_float">
			<xsl:value-of select="php:function('lang','HTML template')"/>
		</div>
		<div class="clearboth fieldText" >
			<textarea name="body_html" id="body_html" class="mceEditor" style="border:0;width:99%;height:30em">
				<xsl:value-of select="template/body_html"/>
			</textarea>
		</div>				
	</div>
		
	<div class="clearboth fieldLabelContainer" style="padding:10px 0 0 0">
		<div class="fieldLabel start_float">
			<xsl:value-of select="php:function('lang','Text template')"/>
		</div>
		<div class="end_float">
			<a class="fieldAssociatedLink" onclick="document.templates.body_text.value = stripHTML(tinyMCE.activeEditor.getContent());">
				<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Copy from HTML')"/></xsl:attribute>
				<xsl:value-of select="php:function('lang','Copy from HTML')"/>
		    </a>&#160;&#160;&#160;
		</div>
		<div class="clearboth fieldText" >
			<textarea name="body_text" id="body_text" class="formtextarea" style="width:99%;height:30em" nowrap="true">
				<xsl:value-of select="template/body_text" />
			</textarea>
		</div>				
	</div>

	<div class="clearboth fieldLabelContainer" style="padding:10px 0 0 0">
		<div class="fieldLabel start_float">
			<xsl:value-of select="php:function('lang','Note')"/>
		</div>
		<div class="end_float">
			<a class="fieldAssociatedLink" onclick="insertTimeStamp( document.templates.note,'{/APPSHORE/API/current_user/full_name}', true);">
				<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Insert a time stamp in the field')"/></xsl:attribute>
				<img border="0" src="{$api_image_path}/clock.jpg"/>
   			</a>&#160;
			<a class="fieldAssociatedLink" onclick="if($('note').getHeight()&#60;1000)$('note').style.height = ($('note').getHeight()+200)+'px';">
				<xsl:attribute name="title"><xsl:value-of select="php:function('lang','More lines')"/></xsl:attribute>
				<img border="0" src="{$api_image_path}/plus.jpg"/>
   			</a>&#160;
			<a class="fieldAssociatedLink" onclick="if($('note').getHeight()&#62;250)$('note').style.height = ($('note').getHeight()-200)+'px';">
				<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Less lines')"/></xsl:attribute>
				<img border="0" src="{$api_image_path}/minus.jpg"/>
   			</a>&#160;&#160;&#160;
		</div>
		<div class="clearboth fieldText" >
			<textarea class="formtextarea" style="width:99%" rows="10" name="note" id="note">
				<xsl:value-of select="template/note" />
			</textarea>
		</div>				
	</div>

	<xsl:call-template name="templatesButtons">
			<xsl:with-param name="thisForm">templates</xsl:with-param>
	</xsl:call-template> 		

	</form>
</xsl:template>


<xsl:template name="templatesButtons">	
	<xsl:param name="thisForm"/>
	<xsl:param name="isTop"/>

	<div class="clearboth">
		<input type="submit" class="formBarButton" name="Save" onclick="document.{$thisForm}.key.value=this.name">
            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
        </input>&#160;
		<input type="submit" class="formBarButton" name="Delete" onclick="document.{$thisForm}.key.value='Delete'">
        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Delete')"/></xsl:attribute>
        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Delete')"/></xsl:attribute>
        </input>
	</div>	        	
</xsl:template>


</xsl:stylesheet>
