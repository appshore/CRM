<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="no"/>

<xsl:template match="dashlet_name[.='rss']">
	<div id="rss" valign="middle">
		<table width="100%" cellSpacing="0" cellPadding="0"  border="0" >
			<xsl:for-each select = "/APPSHORE/APP/dashlet/rss/rss_item">
				<tr width="100%" valign="top">		    
					<td>
						<a href="javascript:;" onclick='popupOpen( "popuplevel1", "{link}", 750, 550, "");' style="font-weight:bold"><xsl:value-of select="title" /></a>				
						<ul style="padding-bottom:0px;">
						<xsl:for-each select = "items/items_item">
							<li style="padding:0px;" onMouseOver="popupHTMLDetails('','','{$api_image_path}');" onMouseOut="return nd(1000);"  onContextMenu="return false;">
								<a href="javascript:;" onclick='popupOpen( "popuplevel1", "{link}", 750, 550, "");'><xsl:value-of select="title" /></a>
							</li>
							<div onclick="{link}">
								<xsl:value-of disable-output-escaping="yes" select="description" />
							</div>
						</xsl:for-each>
						</ul>
					</td>
				</tr>
			</xsl:for-each>
		</table>	
	</div>
</xsl:template>

<xsl:template match="dashlet_name[.='appshore_blog']">
	<div id="appshore_blog" style="margin:10px">
		<xsl:for-each select = "/APPSHORE/APP/dashlet/appshore_blog/items/items_item">
			<div style="margin:10px 0 10px 0">
				<span>
					<a href="javascript:;" onclick='popupInter( "{link}", "AppShore Blog");'><xsl:value-of select="title" /></a>
				</span> -
				<span style="color:grey">
					<xsl:value-of select="date" />
				</span>
				<xsl:if test="position() = 0">
					<div style="margin:10px">
						<xsl:value-of disable-output-escaping="yes" select="description" />
					</div>
				</xsl:if>
			</div>
		</xsl:for-each>
	</div>
</xsl:template>

<xsl:template match="dashlet_name[.='appshore_twitter']">
	<div id="appshore_twitter" style="margin:10px">
		<div class="end_direction">
		<a href="http://twitter.com/AppShore" target="_new">twitter.com/AppShore</a>
		</div>
		<xsl:for-each select = "/APPSHORE/APP/dashlet/appshore_twitter/items/items_item">
			<div style="margin:10px 0 10px 0">
				<span><xsl:value-of select="title" /></span> - <span style="color:grey"><xsl:value-of select="datetime" /></span>
			</div>
		</xsl:for-each>
	</div>
</xsl:template>


</xsl:stylesheet>
