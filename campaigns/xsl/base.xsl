<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>
			<xsl:template match="/APPSHORE/API/Plugins" mode="ViewButtons">
	<xsl:param name="thisForm"/>
	<xsl:param name="nodeName"/>
	<xsl:param name="appName"/>
	<xsl:param name="recordId"/>	
	<xsl:param name="recordIdValue"/>	
	<input type='submit' class="formBarButton" name="send" onclick="document.{$thisForm}.key.value='Send'">
        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Send email to list')"/></xsl:attribute>
        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Send email')"/></xsl:attribute>
    </input>&#160;        	
</xsl:template>

<xsl:template match="/APPSHORE/API/Plugins" mode="EditButtons"/>

</xsl:stylesheet>
