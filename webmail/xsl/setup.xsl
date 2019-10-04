<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="setup_tabs">
	<table cellSpacing="0" cellPadding="0" style="margin-top:1em">
		<!-- MAIN MENU APPS -->
		<tr >
			<xsl:for-each select="tabs/tabs_item">
				<td style="padding-right:2px">
				<xsl:choose>
					<xsl:when test="tab_id = /APPSHORE/APP/recordset/tab_id">
						<div class="row_on" style="padding-bottom:4px">
							<xsl:call-template name="rounded"><xsl:with-param name="row" select="'ton'" /></xsl:call-template>
							<a href="{$baseurl}&amp;op={tab_op}" style="padding-left:4px;padding-right:4px"><xsl:value-of select="tab_name" /></a>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<div  class="row_off" style="padding-bottom:4px">
							<xsl:call-template name="rounded"/>
							<a href="{$baseurl}&amp;op={tab_op}" style="padding-left:4px;padding-right:4px"><xsl:value-of select="tab_name" /></a>
						</div>
					</xsl:otherwise>
				</xsl:choose>
				</td>
			</xsl:for-each>
			<td width="*"></td>
		</tr>
	</table>
	<div class="label" style="height:1.2em"/>   
</xsl:template>

</xsl:stylesheet>
