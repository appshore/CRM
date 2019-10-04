<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP[action/reports]">
    <table height="100%" width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
			<td width="*%">
			<xsl:choose>
				<xsl:when test="action/reports  = 'reports_graphs1'">
				    	<xsl:call-template name="reports_graphs1"/>
				</xsl:when>
			</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template match="dashlet_name[.='d52']">
	<xsl:call-template name="d52"/>
</xsl:template>
<xsl:template name="d52">
	<xsl:call-template name="headerDashboardBox">
		<xsl:with-param name="appLabel">Creations and updates by application</xsl:with-param>
		<xsl:with-param name="appName">d52</xsl:with-param>		
	</xsl:call-template>

	<div id="d52">
 		<!--<xsl:value-of select="/APPSHORE/APP/d52/reports/fname" /> -->
 		<IFRAME src="{$basepath}/htmldisplay.php&#63;fname={/APPSHORE/APP/d52/reports/fname}" width="100%" height="200" scrolling="auto"  frameborder="no"> 
		</IFRAME>
	</div>
</xsl:template>

<xsl:template match="dashlet_name[.='d53']">
	<xsl:call-template name="d53"/>
</xsl:template>
<xsl:template name="d53">
	<xsl:call-template name="headerDashboardBox">
		<xsl:with-param name="appLabel">(G) Creations and updates by application</xsl:with-param>
		<xsl:with-param name="appName">d53</xsl:with-param>		
	</xsl:call-template>
	<div id="d53">
 		<IFRAME  src="{$basepath}/htmldisplay.php&#63;fname={/APPSHORE/APP/d53/reports/graphs1/fname}" width="100%" height="200" scrolling="auto"  frameborder="no"> 
		</IFRAME>
	</div>
</xsl:template>

<xsl:template match="dashlet_name[.='reports_graphs1']">
	<xsl:call-template name="reports_graphs1"/>
</xsl:template>
<xsl:template name="reports_graphs1">

	<xsl:if test="string-length(/APPSHORE/APP/report/graphs1/fname) != 0">
		<table width="100%" cellpadding="1" cellspacing="1">
			<tr>
<!-- 			<xsl:value-of select="/APPSHORE/APP/report/graphs1/fname" />is filename<br/> -->
			</tr>
			<tr>
				<td align="center" width="90%">
					<img class="image" src="{$basepath}/lib/graphs/imagedisplay.php&#63;fname={/APPSHORE/APP/report/graphs1/fname}" usemap="#{/APPSHORE/APP/report/graphs1/imtab/map/iname}" />	
					<map>
						<xsl:attribute name="name">
							<xsl:value-of select="/APPSHORE/APP/report/graphs1/imtab/map/iname" />
						</xsl:attribute>
						<xsl:for-each select = "/APPSHORE/APP/report/graphs1/imtab/area/area_item">
							<xsl:call-template name="setarea"/>
						</xsl:for-each>
					
					</map>
				</td>
			</tr>
		</table>
	</xsl:if>
</xsl:template>	
</xsl:stylesheet>
