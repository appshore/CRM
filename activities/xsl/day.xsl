<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>


<xsl:template name='day'>	
	<script language="JavaScript" type="text/javascript" src="activities/js/calendars.js"/>
	
	<div class="bgform" style="clear:both;height:12px;width:100%"/>	

	<xsl:call-template name="allDayGridFrm">
		<xsl:with-param name="height" select="'17px'"/>
	</xsl:call-template>

	<xsl:call-template name="gridFrm">
		<xsl:with-param name="scrolling" select="'auto'"/>
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
