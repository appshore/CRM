<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP[action/node()[name() = /APPSHORE/APP/recordset/appName]]">
	<script language="JavaScript" type="text/javascript" src="includes/prototype/scriptaculous/resize.js"/>
	<script language="JavaScript" type="text/javascript" src="activities/js/calendars_lib.js"/>
	<script language="JavaScript" type="text/javascript" src="activities/js/calendars_alldaygrid.js"/>
	<xsl:choose>
		<xsl:when test = "/APPSHORE/API/current_user/locale_time_id = '%H:%M'">
			<script src="includes/calendar_date_select/javascript/format_time_24hr.js" type="text/javascript"/>
		</xsl:when>
		<xsl:otherwise>
			<script src="includes/calendar_date_select/javascript/format_time_12hr.js" type="text/javascript"/>
		</xsl:otherwise>
	</xsl:choose>

	<xsl:choose>
		<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'day'">
		   	<xsl:call-template name="allDayGrid"/>		
		   	<xsl:call-template name="drawAllDayActivities"/>		
		</xsl:when>					
		<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'week'">
		   	<xsl:call-template name="allDayGrid"/>		
		   	<xsl:call-template name="drawAllDayActivities"/>		
		</xsl:when>	
	</xsl:choose>
	
	<script language="JavaScript" >
		Event.observe(window, 'load', loadAllDayGrid);
		Event.observe(window, 'resize', resizeAllDayGrid);	
	</script>		

</xsl:template>


<xsl:template name="allDayGrid">
	<table id="grid" style="width:100%;" cellspacing="0" cellpadding="0">
		<tr style="width:100%;height:20px">
			<td class="calendarTime" style="width:35px;">&#160;</td>
			<xsl:for-each select="/APPSHORE/APP/week/week_item">
				<td id="{day}" class="calendarDay">
					<xsl:attribute name="style"><xsl:if test="day = /APPSHORE/APP/grid/today">background-color:#CBFCCB;</xsl:if></xsl:attribute>
					&#160;
				</td>
			</xsl:for-each>
			<td class="calendarTime" style="width:15px;height:100%">&#160;</td>
		</tr>
	</table>
</xsl:template>


<xsl:template name="drawAllDayActivities">

	<xsl:for-each select="/APPSHORE/APP/activities/activities_item">
		<div id="{activity_id}" class="calendarBox calendarBoxTitle" _day="{day}" _startday="{startDay}" _nbrdays="{nbrDays}" _start="{start}" _end="{end}">
			<xsl:attribute name="title"><xsl:value-of select="full_name"/>&#160;@&#160;<xsl:value-of select="activity_time"/>&#160;::&#160;<xsl:value-of select="subject"/></xsl:attribute>
			<xsl:attribute name="style">height:15px;overflow:hidden;position:absolute</xsl:attribute>
			<xsl:attribute name="onmouseover">this.className='calendarBox calendarBoxTitleSelected';</xsl:attribute>
			<xsl:attribute name="onMouseOut">this.className='calendarBox calendarBoxTitle';</xsl:attribute>			
			<div id="{activity_id}_prefix start_float"></div>
			<div id="{activity_id}_header" class="calendarBoxTitle start_float" style="padding-right:5px"><xsl:value-of select="activity_time"/></div>
			<div id="{activity_id}_content" class="calendarBoxTitle start_float"><xsl:value-of select="subject"/></div>
			<div id="{activity_id}_suffix" align="right"></div>
		</div>
	</xsl:for-each>	

</xsl:template>


</xsl:stylesheet>
