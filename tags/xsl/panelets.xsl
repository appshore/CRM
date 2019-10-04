<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="panelet_name[.='tags']">
	<xsl:variable name="paneletName" select="'tags'" />
	<xsl:variable name="panelet" select="/APPSHORE/API/panelets/used/used_item[panelet_name=$paneletName]" />
	<div id="panelet_{$panelet/panelet_sequence}" class="panelet">
		<xsl:call-template name="headerleftPanelBox">
			<xsl:with-param name="appLabel" select="$panelet/panelet_label"/>
			<xsl:with-param name="appName" select="$paneletName"/>
			<xsl:with-param name="isOpen" select="$panelet/is_open"/>
		</xsl:call-template>
		<div class="panelet_body" id="{$paneletName}" style="display:{$panelet/is_open}" >
			<xsl:for-each select = "/APPSHORE/API/panelets/tags/tags_item">
				<div class="panelet_bodyline">
					<a id="tag_{tag_id}" href="{$baseurl}&amp;op=tags.base.getRecords&amp;tag_id={tag_id}">
					    <xsl:attribute name="title"><xsl:value-of select="php:function('lang','List all records with this tag')"/></xsl:attribute>	            
						<xsl:value-of select="substring(tag_name,1,20)"/>
					</a>
				</div>	
			</xsl:for-each>		
		</div>
	</div>
</xsl:template>


<xsl:template match="panelet_name[.='tags_cloud']">
	<xsl:variable name="paneletName" select="'tags_cloud'" />
	<xsl:variable name="panelet" select="/APPSHORE/API/panelets/used/used_item[panelet_name=$paneletName]" />
	<div id="panelet_{$panelet/panelet_sequence}" class="panelet">
		<xsl:call-template name="headerleftPanelBox">
			<xsl:with-param name="appLabel" select="$panelet/panelet_label"/>
			<xsl:with-param name="appName" select="$paneletName"/>
			<xsl:with-param name="isOpen" select="$panelet/is_open"/>
		</xsl:call-template>
		<div class="panelet_body" id="{$paneletName}" style="text-align:center;display:{$panelet/is_open}" >
			<xsl:for-each select = "/APPSHORE/API/panelets/tags_cloud/tags_cloud_item">
				<a style="font-size:{tag_size}px" href="{$baseurl}&amp;op=tags.base.getRecords&amp;tag_id={tag_id}">
				    <xsl:attribute name="title"><xsl:value-of select="tag_count"/>&#160;<xsl:value-of select="php:function('lang','records tagged')"/></xsl:attribute>	            
					<xsl:value-of select="tag_name"/>
				</a>&#160;
			</xsl:for-each>		
		</div>
	</div>
</xsl:template>


</xsl:stylesheet>
