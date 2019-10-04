<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP">
	<xsl:choose>		
		<xsl:when test="action/ajax = 'emailaddresses'">
			<ul>
				<xsl:for-each select = "webmail/webmail_item">
					<li><xsl:value-of select="full_name"/></li>	
				</xsl:for-each>
			</ul>		
		</xsl:when>					
		<xsl:otherwise>
			<xsl:for-each select = "webmail/webmail_item/node()">	
				<xsl:if test="name()">	
					<xsl:value-of select="name()"/>&#160;<xsl:value-of select="node()"/>\n
				</xsl:if>
			</xsl:for-each>	
		</xsl:otherwise>						
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>

