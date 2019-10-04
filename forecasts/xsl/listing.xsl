<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>
<xsl:template name="forecasts_listing">

	<form name="forecast_listing" method="post" >
		<input type="hidden" name="op" value="forecasts.base.search"/>

	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Forecasts</xsl:with-param>
	</xsl:call-template>

	<table border="0" width="100%" cellpadding="1" cellspacing="1" style="line-height:2em">
		<tr class="label" align="center">
			<td>
                    <xsl:value-of select="php:function('lang','Forecast')"/>
			</td>
			<td>
                    <xsl:value-of select="php:function('lang','Contact')"/>
			</td>			
			<td >
                    <xsl:value-of select="php:function('lang','Owner')"/>
			</td>
			<td>
                    <xsl:value-of select="php:function('lang','Source')"/>
			</td>						
			<td>
                    <xsl:value-of select="php:function('lang','Type')"/>
			</td>
			<td>
                    <xsl:value-of select="php:function('lang','Rating')"/>
			</td>
			<td>
                    <xsl:value-of select="php:function('lang','Last Update')"/>
			</td>
		</tr>
		<xsl:for-each select = "forecasts/forecasts_item">
			<tr class="unselectedtext" align="center" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
			
				<td width="*%" align="left">
					<a href="{$baseurl}&amp;op=forecasts.base.view&amp;forecast_id={forecast_id}">
						<xsl:value-of select="account_name"/>
					</a>
				</td>
				<td width="*%">
					<xsl:value-of select="last_name"/>, <xsl:value-of select="first_names"/>
				</td>
				<td width="*%">
					<xsl:value-of select="user_name"/>
				</td>
				<td width="*%">
					<xsl:value-of select="source_name"/>
				</td>
				<td width="*%">
					<xsl:value-of select="status_name"/>
				</td>
				<td width="*%">
					<xsl:value-of select="rating_name"/>
				</td>
				<td width="*%">
					<xsl:value-of select="updated"/>
				</td>
						
			</tr>	
		</xsl:for-each>
	</table>

	</form>
</xsl:template>

</xsl:stylesheet>
