<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name='setup_folders'>	
	
	<script type="text/javascript" src="{$lib_js_path}/form.js"/>		
	<script type="text/javascript">
		var fieldRequired = new Array();
		var fieldDescription = new Array();
		var	fieldInc = 0;
		fieldRequired[0] = 'folder_name';
		fieldDescription[0] = '<xsl:value-of select="php:function('lang','Name')"/>';
	</script>

	<form name='folders' method='post' onsubmit="return formCheck(this, fieldRequired, fieldDescription);">
		<input type='hidden' id="op" name='op' value='webmail.setup_folders.edit'/>
		<input type='hidden' id="key" name='key' value=''/>

		<br/>
		<div>
			<xsl:value-of select="php:function('lang','Folders list')"/>
		</div>
		<div>
			<select class="fieldInputSelect" name="folder_id" id="folder_id" onchange="folders.submit();">
					<option/>				
				<xsl:for-each select = "Myfolders/Myfolders_item" >
					<option value="{folder_id}">
						<xsl:if test="folder_id = /APPSHORE/APP/folder/folder_id">
							<xsl:attribute name="selected" value="true" />
						</xsl:if>
						<xsl:if test="folder_type = 'archive'">* </xsl:if><xsl:value-of select="folder_name" />
					</option>
				</xsl:for-each>	
			</select>
		</div>
		<br/>
		
		<xsl:call-template name="buttons_setup_folders"/>

		<div class="formTable" style="width:99%">
			<div class="fieldLabelContainer">
				<div class="fieldLabel fieldLabelMandatory">
					<xsl:value-of select="php:function('lang','Name')"/>
				</div>
				<div style="width:50%">
					<input class="fieldInputText" type="text" id="folder_name" name="folder_name" >
						<xsl:attribute name="value"><xsl:value-of select="folder/folder_name" /></xsl:attribute>
					</input>
				</div>
				<div class="fieldLabel fieldLabel">
					<xsl:value-of select="php:function('lang','Archive')"/>
				</div>
				<div>
					<input class="fieldInputCheckbox" type="checkbox" id="is_archive" name="is_archive" value="{folder/is_archive}" onclick="is_boxchecked(this);" >
						<xsl:if test="folder/is_archive = 'Y'">
							<xsl:attribute name="checked"/>
						</xsl:if>
					</input>									
				</div>
			</div>				
		</div>		
		
		<xsl:call-template name="buttons_setup_folders"/>
	</form>
</xsl:template>


<xsl:template name="buttons_setup_folders">	
	<div class="formBar">	
		<input type="submit" class="formBarButton" id="New"  name="New" onclick="document.folders.folder_id.value='';document.folders.key.value=this.name;">
			<xsl:attribute name="value"><xsl:value-of select="php:function('lang','New')"/></xsl:attribute>
		</input>&#160;
		<input type="submit" class="formBarButton"  id="Save" name="Save" onclick="document.folders.key.value=this.name;">
			<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
		</input>&#160;	
		<input type="submit" class="formBarButton" id="Delete" name="Delete" onclick="document.folders.key.value=this.name;">
			<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Delete')"/></xsl:attribute>
		</input>
	</div>
</xsl:template>


</xsl:stylesheet>
