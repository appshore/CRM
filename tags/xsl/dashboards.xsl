<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="dashlet_name[.='tags_cloud']">
	<div id="tags" align="center">
		<xsl:for-each select = "/APPSHORE/APP/dashlet/tags_cloud/tags_cloud_item">
			<a style="padding-left:3px;font-size:{tag_size}px" id="tag_{tag_id}" href="{$baseurl}&amp;op=tags.base.getRecords&amp;tag_id={tag_id}">
		        <xsl:attribute name="title"><xsl:value-of select="tag_count"/>&#160;<xsl:value-of select="php:function('lang','records tagged')"/></xsl:attribute>	            
				<xsl:value-of select="tag_name"/>
			</a>&#160;
		</xsl:for-each>		
	</div>
</xsl:template>

</xsl:stylesheet>
