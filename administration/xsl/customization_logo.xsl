<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name='customization_logo'>	
	<form name='logo_edit' enctype="multipart/form-data" method='post' >
	<input type='hidden' id="op" name="op" value='administration.customization_logo.edit'/>
	<input type="hidden" id="key" name="key" />

	<div class="formTitleTags start_float">
    	<xsl:value-of select="php:function('lang','Company logo')"/>
	</div>
	
	<div class="helpmsg">
		<xsl:value-of disable-output-escaping="yes" select="php:function('lang','administration.customization.logo.help')"/>
	</div>

	<div class="clearboth fieldLabelContainer" style="padding:10px 0 10px 0">
		<div class="fieldLabel start_float">
			<xsl:value-of select="php:function('lang','File name')"/>
		</div>
		<div class="clearboth fieldText" >
			<input type="hidden" name="filename" value="{logo/filename}"/>
			<input name="userfile" size="60" type="file" onclick="document.logo_edit.filename.value=this.value;"/>
		</div>				
	</div>

	<input type="submit" class="formBarButton" name="Save" onclick="document.logo_edit.key.value='Save'">
        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
    </input>&#160;   
	<input type="submit" class="formBarButton" name="Restore" onclick="document.logo_edit.key.value='Restore'">
		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Restore')"/></xsl:attribute>
        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Restore')"/></xsl:attribute>
    </input>		        	

	</form>
</xsl:template>


</xsl:stylesheet>
