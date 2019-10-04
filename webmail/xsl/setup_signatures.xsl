<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="setup_signatures">	

	<script type="text/javascript" src="includes/tiny_mce/tiny_mce.js"/>
	<script type="text/javascript" src="lib/js/tinymce.js"/>
	<script type="text/javascript" src="{$lib_js_path}/form.js"/>		
	<script type="text/javascript">
		var fieldRequired = new Array();
		var fieldDescription = new Array();
		var	fieldInc = 0;
		fieldRequired[0] = 'signature_name';
		fieldDescription[0] = '<xsl:value-of select="php:function('lang','Name')"/>';
	</script>
		
	<form name='signatures' method='post' onsubmit="return formCheck(this, fieldRequired, fieldDescription);">
		<input type='hidden' id="op" name='op' value='webmail.setup_signatures.edit'/>
		<input type='hidden' id="key" name='key' value=''/>

		<br/>
		<div>
			<xsl:value-of select="php:function('lang','Signatures list')"/>
		</div>
		<div>
			<select class="fieldInputSelect" name="signature_id" id="signature_id" onchange="signatures.submit();">
					<option/>				
				<xsl:for-each select = "signatures/signatures_item" >
					<option value="{signature_id}">
						<xsl:if test="signature_id = /APPSHORE/APP/signature/signature_id">
							<xsl:attribute name="selected" select="'true'" />
						</xsl:if>
						<xsl:value-of select="signature_name" />
					</option>
				</xsl:for-each>	
			</select>
		</div>
		<br/>
		
		<xsl:call-template name="buttons_setup_signatures"/>

		<div class="formTable" style="width:99%">
			<div class="fieldLabelContainer">
				<div class="fieldLabel fieldLabelMandatory">
					<xsl:value-of select="php:function('lang','Name')"/>
				</div>
				<div style="width:50%">
					<input class="fieldInputText" type="text" id="signature_name" name="signature_name" >
						<xsl:attribute name="value"><xsl:value-of select="signature/signature_name" /></xsl:attribute>
					</input>
				</div>
			</div>				
			<div class="fieldLabelContainer">
				<div class="fieldLabel">
					<xsl:value-of select="php:function('lang','Text')"/>
				</div>
				<div class="fieldInputEditor">
					<textarea name="signature_text" id="signature_text" class="mceEditor" style="width:100%;height:25em">
						<xsl:value-of select="signature/signature_text"/>
					</textarea>
				</div>
			</div>
		</div>		
		
		<xsl:call-template name="buttons_setup_signatures"/>
	</form>
</xsl:template>

<xsl:template name="buttons_setup_signatures">	
	<div class="formBar">	
		<input type="submit" class="formBarButton" id="New"  name="New" onclick="document.signatures.signature_id.value='';document.signatures.key.value=this.name;">
			<xsl:attribute name="value"><xsl:value-of select="php:function('lang','New')"/></xsl:attribute>
		</input>&#160;
		<input type="submit" class="formBarButton"  id="Save" name="Save" onclick="document.signatures.key.value=this.name;">
			<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
		</input>&#160;	
		<input type="submit" class="formBarButton" id="Delete" name="Delete" onclick="document.signatures.key.value=this.name;">
			<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Delete')"/></xsl:attribute>
		</input>
	</div>
</xsl:template>


</xsl:stylesheet>
