<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP">
<!--    <table width="100%" cellSpacing="0" cellPadding="0"  border="0" >-->
<!--		<tr width="100%" valign="top">-->
<!--			<td class="left_panel" id="left_panel" style="display:{/APPSHORE/API/cookie/left_panel}">-->
<!--			    <xsl:call-template name="verticalMenus">		    -->
<!--					<xsl:with-param name="appName">www</xsl:with-param>-->
<!--					<xsl:with-param name="appLabel">www.appshore.com</xsl:with-param>-->
<!--				</xsl:call-template>	-->
<!--			</td>-->
<!--            <td id="right_panel" class="right_panel">-->
			    <xsl:call-template name="www_start"/>
<!--			</td>-->
<!--		</tr>-->
<!--	</table>-->
</xsl:template> 

<xsl:template name="www_start">
	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">www.appshore.com</xsl:with-param>
	</xsl:call-template>	
    <div>
		<xsl:value-of disable-output-escaping="yes" select="php:function('lang','www.base.start')"/>
	</div>
</xsl:template>


</xsl:stylesheet>
