<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="APP[action/node()[name() = /APPSHORE/APP/recordset/appName]]">
	<script language="JavaScript" type="text/javascript" src="includes/prototype/scriptaculous/resize.js"/>
	<script language="JavaScript" type="text/javascript" src="activities/js/calendars_lib.js"/>
	<script language="JavaScript" type="text/javascript" src="activities/js/calendars_grid.js"/>
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
		   	<xsl:call-template name="grid"/>	
		   	<xsl:call-template name="drawActivities"/>			   		
		</xsl:when>					
		<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'week'">
		   	<xsl:call-template name="grid"/>	
	   	   	<xsl:call-template name="drawActivities"/>		
		</xsl:when>	
	</xsl:choose>
</xsl:template>

<xsl:template name="grid">
	<table id="grid" style="width:100%" cellspacing="0" cellpadding="0">
		<xsl:for-each select="/APPSHORE/APP/grid/hours/hours_item">
			<xsl:variable name="hour"><xsl:value-of select="hour"/></xsl:variable>
			<xsl:variable name="hour_name"><xsl:value-of select="hour_name"/></xsl:variable>
			<xsl:for-each select="/APPSHORE/APP/grid/minutes/minutes_item">
				<tr style="height:{/APPSHORE/APP/grid/inc_hour div 60}px;width:100%">
					<xsl:variable name="minute"><xsl:value-of select="minute"/></xsl:variable>
					<td id="{$hour+$minute}" class="calendarTime">
						<xsl:attribute name="title"><xsl:value-of select="$hour_name"/></xsl:attribute>
						<xsl:if test = '$minute = 0'>
							<xsl:attribute name="style">vertical-align:top;text-align:center;border-top:lightgrey 1px solid;width:35px;</xsl:attribute>
							<div style="height:{/APPSHORE/APP/grid/inc_hour div 60}px;overflow:hidden">
								<xsl:value-of select="$hour_name"/>
							</div>
						</xsl:if>
					</td>
					<xsl:for-each select="/APPSHORE/APP/week/week_item">
						<td id="{day+$hour+$minute}">
							<xsl:attribute name="title"><xsl:value-of select="day_local"/>,&#160;<xsl:value-of select="$hour_name"/></xsl:attribute>
							<xsl:attribute name="class"><xsl:choose><xsl:when test='($hour+$minute) = 0'>calendarDay</xsl:when><xsl:otherwise>calendarPeriod</xsl:otherwise></xsl:choose></xsl:attribute>
							<xsl:attribute name="style"><xsl:if test= 'day = /APPSHORE/APP/grid/today'>background-color:#BFF4BF;</xsl:if><xsl:if test = 'not($minute = 0)'>border-top-style:dotted;</xsl:if></xsl:attribute>
							&#160;
						</td>
					</xsl:for-each>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
	</table>
	<script language="JavaScript">
		$('<xsl:value-of select="/APPSHORE/APP/grid/start_hour"/>').scrollTo();
	</script>	
</xsl:template>

<xsl:template name="drawActivities">
	<xsl:for-each select="/APPSHORE/APP/activities/activities_item">
		<div id="{activity_id}" class="calendarBox" _day="{day}" _start="{start}" _end="{end}">
			<xsl:attribute name="title"><xsl:value-of select="full_name"/>&#160;@&#160;<xsl:value-of select="activity_time"/>&#160;::&#160;<xsl:value-of select="subject"/></xsl:attribute>
			<xsl:attribute name="onmouseover">this.className='calendarBox calendarBoxSelected';</xsl:attribute>
			<xsl:attribute name="onMouseOut">this.className='calendarBox';</xsl:attribute>
			<xsl:attribute name="style">overflow:hidden;position:absolute</xsl:attribute>
			<div id="{activity_id}_header" class="calendarBoxTitle">
				<xsl:attribute name="onmouseover">this.className='calendarBoxTitle calendarBoxTitleSelected';</xsl:attribute>
				<xsl:attribute name="onMouseOut">this.className='calendarBoxTitle';</xsl:attribute>
				<div id="{activity_id}_time" class="calendarBoxTitle start_float" style="padding-right:5px">
					<xsl:attribute name="onmouseover">this.className='calendarBoxTitle calendarBoxTitleSelected start_float';</xsl:attribute>
					<xsl:attribute name="onMouseOut">this.className='calendarBoxTitle start_float';</xsl:attribute>
					<xsl:value-of select="activity_time"/>
				</div>
				<div id="{activity_id}_subject" class="calendarBoxTitle">
					<xsl:attribute name="onmouseover">this.className='calendarBoxTitle calendarBoxTitleSelected';</xsl:attribute>
					<xsl:attribute name="onMouseOut">this.className='calendarBoxTitle';</xsl:attribute>
				</div>&#160;
			</div>
			<div id="{activity_id}_content" class="calendarBoxContent" style="clear:both">
				<xsl:value-of select="subject"/>
			</div>
		</div>
	</xsl:for-each>
	<script language="JavaScript" >
		Event.observe(window, 'load', loadGrid);
		Event.observe(window, 'resize', resizeGrid);	
	</script>		
	
</xsl:template>

</xsl:stylesheet>
