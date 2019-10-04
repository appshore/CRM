<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="dashlet_name[.='open_products']">
	<xsl:call-template name="headerDashboardBox">
		<xsl:with-param name="appLabel">Open Products</xsl:with-param>
		<xsl:with-param name="appName">open_products</xsl:with-param>		
	</xsl:call-template>
	<div id="open_products">
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr class="label" align="center">
			<td width="*">
				<xsl:value-of select="php:function('lang','Priority')"/>
			</td>
			<td width="*">
				<xsl:value-of select="php:function('lang','Subject')"/>
			</td>
		</tr>
		<xsl:for-each select = "/APPSHORE/APP/open_products/products/products_item">
			<tr class="unselectedtext"  align="center" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
            	<td >
					<xsl:value-of select="priority_name"/>
				</td>
				<td  align="left">
					<a href="{$baseurl}&amp;op=products.base.view&amp;product_id={product_id}">
						<xsl:value-of select="subject"/>
					</a>
				</td>
			</tr>
		</xsl:for-each>
		</table>
	</div>
</xsl:template>


</xsl:stylesheet>
