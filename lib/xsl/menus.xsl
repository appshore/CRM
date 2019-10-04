<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="submenus_chooser">
	<table cellSpacing="0" cellPadding="0" style="margin-top:1em">
		<!-- MAIN MENU APPS -->
		<tr valign="top">
			<xsl:for-each select="submenus/submenus_item">
				<xsl:choose>
					<xsl:when test="submenu_id = /APPSHORE/APP/recordset/submenu_id">
						<td class="row_on" style="padding-bottom:4px">
							<xsl:call-template name="rounded"><xsl:with-param name="row" select="'ton'" /></xsl:call-template>
							<a href="{$baseurl}&amp;op={/APPSHORE/API/op/appname}.base.{submenu_id}" style="padding-left:4px;padding-right:4px">
								<xsl:value-of select="php:functionString('lang',submenu_name)"/>
							</a>
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="row_off" style="padding-bottom:4px">
							<xsl:call-template name="rounded"/>
							<a href="{$baseurl}&amp;op={/APPSHORE/API/op/appname}.base.{submenu_id}" style="padding-left:4px;padding-right:4px">
								<xsl:value-of select="php:functionString('lang',submenu_name)"/>
							</a>
						</td>
					</xsl:otherwise>
				</xsl:choose>
				<td width="2px"></td>
			</xsl:for-each>
		</tr>
	</table>
	<div class="label" width="100%" style="height:1.2em"/>   
</xsl:template>


<xsl:template name="submenus">
	<table cellSpacing="0" cellPadding="0" style="margin-top:1em">
		<!-- MAIN MENU APPS -->
		<tr valign="top">
			<xsl:for-each select="/APPSHORE/API/submenus/submenus_item">
				<xsl:choose>
					<xsl:when test="id = /APPSHORE/API/context/submenu_id">
						<td class="row_on" style="padding-bottom:4px">
							<xsl:call-template name="rounded"><xsl:with-param name="row" select="'ton'" /></xsl:call-template>
							<a href="{$baseurl}&amp;op={op}" style="padding-left:4px;padding-right:4px">
								<xsl:value-of select="php:functionString('lang',title)"/>
							</a>
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="row_off" style="padding-bottom:4px">
							<xsl:call-template name="rounded"/>
							<a href="{$baseurl}&amp;op={op}" style="padding-left:4px;padding-right:4px">
								<xsl:value-of select="php:functionString('lang',title)"/>
							</a>
						</td>
					</xsl:otherwise>
				</xsl:choose>
				<td width="2px"></td>
			</xsl:for-each>
		</tr>
	</table>
	<div class="label" width="100%" style="height:1.2em"/>   
</xsl:template>

<xsl:template name="verticalMenus">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>

	<div class="verticalMenusBoxContainer">
		<div class="verticalMenusBoxBody" id="{$appName}">
			<xsl:variable name="currentOP" select="/APPSHORE/API/op/opname"/>
			<xsl:if test="count(/APPSHORE/API/apps/apps_item) >= 0 and /APPSHORE/API/op/appname = $appName">
				<xsl:for-each select="/APPSHORE/API/appmenus/appmenus_item[title = $appLabel]">
					<xsl:for-each select="links/links_item">			
						<div class="verticalMenusBoxBodyLine">
							<xsl:variable name="currentTitle" select="title"/>	
							<a href="{$baseurl}&amp;op={op}" class="unselectedmenu">
								<xsl:if test="op = $currentOP">
					                <xsl:attribute name="style">font-weight:bold</xsl:attribute>
								</xsl:if>
								<xsl:value-of select="php:functionString('lang',title)"/>
							</a>
							<xsl:for-each select="/APPSHORE/API/appmenus/appmenus_item[title = $currentTitle]">
								<xsl:for-each select="links/links_item">							
									<div class="verticalMenusBoxBodySubLine">
										<a href="{$baseurl}&amp;op={op}" class="unselectedmenu">
											<xsl:if test="op = $currentOP">
								                <xsl:attribute name="style">font-weight:bold</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="php:functionString('lang',title)"/>
										</a>
									</div>
								</xsl:for-each>
							</xsl:for-each>
						</div>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:if>
		</div>
	</div>
				
    <xsl:call-template name="panelets"/>
	
</xsl:template> 

</xsl:stylesheet>
