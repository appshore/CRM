<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>
			
<xsl:template match="APP[action/node()[name() = /APPSHORE/APP/recordset/appName]]">
    <table width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
		    <xsl:call-template name="leftPanel"/>
            <td id="right_panel" class="right_panel">
            
				<xsl:choose>
													
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'day'">
				    	<xsl:call-template name="activities_search">
				    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
				    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabel"/>
				    		<xsl:with-param name="period" select="'day'"/>
				    	</xsl:call-template>	
				    	<xsl:call-template name="calendars_tabs"/>		
						<xsl:call-template name="day"/>
					</xsl:when>		
								
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'week'">
				    	<xsl:call-template name="activities_search">
				    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
				    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabel"/>
				    		<xsl:with-param name="period" select="'week'"/>
				    	</xsl:call-template>	
				    	<xsl:call-template name="calendars_tabs"/>		
						<xsl:call-template name="week"/>
					</xsl:when>		
									
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'month'">
				    	<xsl:call-template name="activities_search">
				    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
				    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabel"/>
				    		<xsl:with-param name="period" select="'month'"/>
				    	</xsl:call-template>	
				    	<xsl:call-template name="calendars_tabs"/>		
						<xsl:call-template name="month"/>
					</xsl:when>		
								
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>


<xsl:template name="allDayGridFrm">
	<xsl:param name="height"/>	
	<div class="calendarGrid">
		<div id="allDayGridFrmDiv" class="calendarGrid" style="width:100%" border="0">
			<iframe id="allDayGridFrm" style="width:99.9%;height:{$height}" scrolling="no" src="{$baseurl}&amp;op=activities.{/APPSHORE/APP/recordset/tab_id}.grid&amp;is_allday=true"/>
		</div>
	</div>

	<script language="JavaScript">	
		Event.observe(window, 'resize', resizeAllDayGridFrm);	
	</script>
	
</xsl:template>

<xsl:template name="gridFrm">
	<xsl:param name="scrolling"/>	
	<div class="calendarGrid">
		<div id="gridFrmDiv" class="calendarGrid" style="width:100%" border="0">
			<iframe id="gridFrm" style="width:99.9%;height:100%" scrolling="{$scrolling}" src="{$baseurl}&amp;op=activities.{/APPSHORE/APP/recordset/tab_id}.grid&amp;is_allday=false"/>
		</div>
	</div>

	<script language="JavaScript">	
		Event.observe(window, 'resize', resizeGridFrm);	
	</script>

</xsl:template>

<xsl:template name="calendarNavigation">
	<xsl:param name="thisForm"/>	
<!--	<input type="button" class="formBarButton" id="goto" name="goto" onclick="show_calendar('{$thisForm}.goto');" onfocus="if(!this.value.match('-'))return false;this.disabled;$('period').value=this.value;document.{$thisForm}.submit();">-->
<!--   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Go to this date')"/></xsl:attribute>                    -->
<!--        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Go to')"/></xsl:attribute>                    -->
<!--    </input>&#160;-->
	<input type="submit" class="formBarButton" id="now" name="now" onclick="document.{$thisForm}.keytabs.value='Now'">
   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Now')"/></xsl:attribute>                    
        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Now')"/></xsl:attribute>                    
    </input>&#160;
	<input type="submit" class="formBarButton" style="width:2em;font-weight:bold" id="previous" name="previous" onclick="document.{$thisForm}.keytabs.value='Previous'">
   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Previous')"/></xsl:attribute>                    
        <xsl:attribute name="value">&#8249;</xsl:attribute>
    </input>&#160;
	<input type="submit" class="formBarButton" style="width:2em;font-weight:bold" id="next" name="next" onclick="document.{$thisForm}.keytabs.value='Next'">
   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Next')"/></xsl:attribute>                    
        <xsl:attribute name="value">&#8250;</xsl:attribute>
    </input>&#160;
</xsl:template>


</xsl:stylesheet>
