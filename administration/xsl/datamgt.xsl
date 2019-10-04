<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP[action/datamgt]">
    <table width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
			<td class="left_panel" id="left_panel" style="display:{/APPSHORE/API/cookie/left_panel}">
			    <xsl:call-template name="verticalMenus">		    
					<xsl:with-param name="appName">administration</xsl:with-param>
					<xsl:with-param name="appLabel">Administration</xsl:with-param>
				</xsl:call-template>	
			</td>
            <td id="right_panel" class="right_panel">
				<xsl:choose>
					<xsl:when test="action/datamgt = 'import'">
					</xsl:when>
					<xsl:when test="action/datamgt = 'export'">
					</xsl:when>
					<xsl:when test="action/datamgt = 'backup'">
					</xsl:when>
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>

</xsl:stylesheet>
