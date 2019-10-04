<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name='week'>
	<script language="JavaScript" type="text/javascript" src="activities/js/calendars.js"/>

	<div class="calendarGrid" style="clear:both;width:100%">
		<table id="grid" cellspacing="0" cellpadding="0" class="calendarGrid" style="width:100%">
			<tr style="height:20px;width:100%">
				<td style="width:37px">&#160;	
				</td>
				<xsl:for-each select="/APPSHORE/APP/week/week_item">
					<td align="center" class="calendarWeekName">
						<a href="{$baseurl}&amp;op=activities.day.search&amp;period={day_date}" title="{day_local}">
							<xsl:value-of select="day_local"/>
						</a>
					</td>
				</xsl:for-each>
				<td style="width:27px">&#160;	
				</td>
			</tr>
		</table>
	
		<script language="JavaScript">	
			Event.observe(window, 'resize', resizeWeek);	
			Event.observe(window, 'load', resizeWeek);
		</script>			
	</div>
	
	<xsl:call-template name="allDayGridFrm">
		<xsl:with-param name="height" select="'17px'"/>
	</xsl:call-template>
	
	<xsl:call-template name="gridFrm">
		<xsl:with-param name="scrolling" select="'auto'"/>
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
