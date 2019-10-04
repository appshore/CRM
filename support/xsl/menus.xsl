<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="supportMenus">
	<xsl:call-template name="headerleftPanelBox">
		<xsl:with-param name="appLabel">Support</xsl:with-param>
		<xsl:with-param name="appName">Support</xsl:with-param>		
	</xsl:call-template>
	
	<div id="Support" valign="middle">
		<xsl:variable name="currentOP" select="/APPSHORE/API/op/opname"/>
		<xsl:if test="count(/APPSHORE/API/apps/apps_item) >= 0 and /APPSHORE/API/op/appname = 'support'">
			<xsl:for-each select="/APPSHORE/API/appmenus/appmenus_item[title = 'Support']">
				<xsl:for-each select="links/links_item">			
					<div style="margin-bottom:0.2em"> 
						<xsl:variable name="currentTitle" select="title"/>	
						<a href="{$baseurl}&amp;op={op}" class="unselectedmenu">
							<xsl:if test="op = $currentOP">
				                <xsl:attribute name="style">font-weight:bold</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="php:functionString('lang',title)"/>
						</a>
						<xsl:for-each select="/APPSHORE/API/appmenus/appmenus_item[title = $currentTitle]">
							<xsl:for-each select="links/links_item">							
								<div style="margin-left:1.5em;margin-top:0.2em;margin-bottom:0.2em"> 
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
				
    <xsl:call-template name="panelets"/>

</xsl:template> 

</xsl:stylesheet>
