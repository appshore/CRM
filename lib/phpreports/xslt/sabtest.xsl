<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" encoding="utf-8" indent="yes"/>
<xsl:param name="html"/>

<xsl:template match="/test/message">
	<xsl:value-of select="title"/>
	&#160;
	<xsl:value-of select="body"/>
</xsl:template>

</xsl:stylesheet>
