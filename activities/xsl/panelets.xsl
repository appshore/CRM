<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>


<xsl:template match="panelet_name[.='my_upcoming_activities']">
	<xsl:variable name="paneletName" select="'my_upcoming_activities'" />
	<xsl:variable name="panelet" select="/APPSHORE/API/panelets/used/used_item[panelet_name=$paneletName]" />
	<div id="panelet_{$panelet/panelet_sequence}" class="panelet">
		<xsl:call-template name="headerleftPanelBox">
			<xsl:with-param name="appLabel" select="$panelet/panelet_label"/>
			<xsl:with-param name="appName" select="$paneletName"/>
			<xsl:with-param name="isOpen" select="$panelet/is_open"/>
		</xsl:call-template>
		<div class="panelet_body" id="{$paneletName}" style="display:{$panelet/is_open}" >
			<xsl:for-each select = "/APPSHORE/API/panelets/my_upcoming_activities/my_upcoming_activities_item">
				<div class="panelet_bodyline">
					<a>
				    	<xsl:attribute name="href"><xsl:value-of select="$baseurl"/>&amp;op=activities.base.view&amp;activity_id=<xsl:value-of select="activity_id"/></xsl:attribute>
				    	<xsl:attribute name="onmouseover">popupDetails('<xsl:value-of select="$baseurl"/>&amp;op=activities.popup.view&amp;activity_id=<xsl:value-of select="activity_id"/>');</xsl:attribute>
				    	<xsl:attribute name="onmouseout">return nd(1000);</xsl:attribute>
					    <xsl:value-of select="time"/>&#160;<xsl:value-of select="substring(subject,1,11)"/>
					</a>
				</div>	
			</xsl:for-each>		
		</div>
	</div>
</xsl:template>

</xsl:stylesheet>
