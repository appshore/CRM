<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="/">
<xsl:value-of disable-output-escaping="yes" select="/APPSHORE/APP" />
</xsl:template> 

</xsl:stylesheet>
