<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name='month'>	
	<script language="JavaScript" type="text/javascript" src="includes/prototype/scriptaculous/resize.js"/>
	<script language="JavaScript" type="text/javascript" src="activities/js/calendars.js"/>
	<script language="JavaScript" type="text/javascript" src="activities/js/calendars_lib.js"/>
	<script language="JavaScript" type="text/javascript" src="activities/js/month.js"/>
	
	<div class="calendarGrid" style="clear:both;width:100%">
		<table class="calendarGrid" style="width:100%;height:100%" cellspacing="0" cellpadding="0" border="0">
			<tr style="height:24px;width:100%">
				<td>&#160;
				</td>
				<xsl:for-each select="/APPSHORE/APP/week/week_item">
					<td align="center" class="calendarWeekName">
		        		<xsl:value-of select="day_name"/>
					</td>
				</xsl:for-each>
			</tr>
			<xsl:for-each select="/APPSHORE/APP/weeks/weeks_item">
				<tr style="width:100%;height:100%">
					<td class="calendarWeekNumber" style="width:25px;text-align:center">	
		        		<a href="{$baseurl}&amp;op=activities.week.search&amp;period={days/days_item/day_date}">
							<xsl:value-of select="week"/>
						</a>
					</td>
					<xsl:if test = "position() = 1">
						<td colspan="{count(/APPSHORE/APP/week/week_item)}"  valign="top" rowspan="{count(/APPSHORE/APP/weeks/weeks_item)}">
							<xsl:call-template name="month_grid"/>
							<xsl:call-template name="drawMonthActivities"/>
						</td>
					</xsl:if>
				</tr>
			</xsl:for-each>
		</table>
	</div>
	
	<script language="JavaScript">
		Event.observe(window, 'load', loadMonthGrid);
		Event.observe(window, 'resize', resizeMonthGrid);	
	</script>			

</xsl:template>

<xsl:template name="month_grid">
	<table id="grid" cellspacing="0" cellpadding="0" border="0" style="width:100%;height:100%">
		<xsl:for-each select="/APPSHORE/APP/weeks/weeks_item">
			<tr style="width:100%">
				<xsl:for-each select="days/days_item">
					<td id="{day}" class="calendarDay" valign="top" title="{day_local}">
 	    				<div id="title_{day}" class="calendarTime">
	     					<xsl:attribute name="style">text-align:center;line-height:15px;<xsl:if test="not(month = /APPSHORE/APP/grid/month)">background-color:#F1EEBD;</xsl:if><xsl:if test="day = /APPSHORE/APP/grid/today">background-color:#BFF4BF;</xsl:if></xsl:attribute>
		            		<a href="{$baseurl}&amp;op=activities.day.search&amp;period={day_date}">
								<xsl:value-of select="day_nbr"/>
							</a>
							&#160;
						</div>
					</td>
				</xsl:for-each>
			</tr>
		</xsl:for-each>
	</table>
</xsl:template>


<xsl:template name="drawMonthActivities">
	<xsl:for-each select="/APPSHORE/APP/activities/activities_item">
		<div id="{activity_id}" _day="{day}" _startday="{startDay}" _nbrdays="{nbrDays}" _start="{start}" _end="{end}">
			<xsl:attribute name="title"><xsl:value-of select="full_name"/>&#160;@&#160;<xsl:value-of select="activity_time"/>&#160;::&#160;<xsl:value-of select="subject"/></xsl:attribute>
			<xsl:attribute name="class">calendarBox calendarBoxTitle</xsl:attribute>
			<xsl:attribute name="style">position:absolute;overflow:hidden;height:15px</xsl:attribute>
			<xsl:attribute name="onmouseover">this.className='calendarBox calendarBoxTitleSelected';</xsl:attribute>
			<xsl:attribute name="onMouseOut">this.className='calendarBox calendarBoxTitle';</xsl:attribute>			
			<xsl:value-of select="activity_time"/>&#160;<xsl:value-of select="subject"/>
		</div>
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
