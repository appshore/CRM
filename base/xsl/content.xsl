<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="/">
		
	<!-- MAIN -->
	<xsl:choose>
		<!-- Normal APP output -->
		<xsl:when test="/APPSHORE/APP">
			<xsl:apply-templates select="/APPSHORE/APP" />
		</xsl:when>
		<!-- HTML output -->
		<xsl:when test="/APPSHORE/APPHTML">
			<xsl:value-of disable-output-escaping="yes" select="/APPSHORE/APPHTML" />
		</xsl:when>
	</xsl:choose>	

	<xsl:if test = "not(/APPSHORE/API/no_window_footer)">
		<xsl:call-template name="main_window_footer"/>
	</xsl:if>
</xsl:template> 

</xsl:stylesheet>
