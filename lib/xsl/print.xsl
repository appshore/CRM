<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="custom_print">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>	
	<xsl:param name="nodeName"/>	
	<xsl:param name="recordId"/>	
	<xsl:param name="recordName"/>	
	
	<a>
		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Print')"/></xsl:attribute>
		<img SRC="api/images/print.gif" onclick="javascript:this.src='api/images/invisible.gif';print();"/>
	</a>
	
    <div class="boxtitle">
        <xsl:value-of select="php:functionString('lang',$appLabel)"/>:&#160;
		<xsl:value-of select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $recordName]"/>
	</div>		

</xsl:template>

</xsl:stylesheet>
