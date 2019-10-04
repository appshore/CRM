<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>


<xsl:template match="dashlet_name[.='upcoming_activities_narrow']">
	<xsl:call-template name="headerDashboardBox">
		<xsl:with-param name="appLabel">Upcoming Activities</xsl:with-param>
		<xsl:with-param name="appName">upcoming_activities_narrow</xsl:with-param>		
	</xsl:call-template>
	<div id="upcoming_activities_narrow-div">
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr class="label" align="center">
			<td width="5%">
				<xsl:value-of select="php:function('lang','Priority')"/>
			</td>
			<td width="5%">
				<xsl:value-of select="php:function('lang','Type')"/>
			</td>
			<td width="*%">
				<xsl:value-of select="php:function('lang','Subject')"/>
			</td>
		</tr>
		<xsl:for-each select = "/APPSHORE/APP/upcoming_activities_narrow/activities/activities_item">
			<tr class="unselectedtext"  align="center" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
            	<td >
					<xsl:value-of select="priority_name"/>
				</td>
                <td >
					<xsl:value-of select="type_name"/>
				</td>
				<td  align="left">
					<a href="{$baseurl}&amp;op=activities.base.view&amp;activity_id={activity_id}">
						<xsl:value-of select="subject"/>
					</a>
				</td>
			</tr>
		</xsl:for-each>
		</table>
	</div>
</xsl:template>


<xsl:template match="dashlet_name[.='upcoming_activities_wide']">
	<xsl:call-template name="headerDashboardBox">
		<xsl:with-param name="appLabel">Upcoming Activities By Date</xsl:with-param>
		<xsl:with-param name="appName">upcoming_activities_wide</xsl:with-param>		
	</xsl:call-template>
	<div id="upcoming_activities_wide-div">
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr class="label" align="center">
			<td width="5%">
				<xsl:value-of select="php:function('lang','Priority')"/>
			</td>
			<td width="5%">
				<xsl:value-of select="php:function('lang','Type')"/>
			</td>
			<td width="*">
				<xsl:value-of select="php:function('lang','Subject')"/>
			</td>
			<td width="*">
				<xsl:value-of select="php:function('lang','Account')"/>
			</td>			
			<td width="*">
				<xsl:value-of select="php:function('lang','Contact')"/>
			</td>
			<td width="*">
				<xsl:value-of select="php:function('lang','Date and Time')"/>
			</td>	
			<td width="*">
				<xsl:value-of select="php:function('lang','Status')"/>
			</td>										
		</tr>
		<xsl:for-each select = "/APPSHORE/APP/upcoming_activities_wide/activities/activities_item">
			<tr class="unselectedtext"  align="center" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
            	<td >
					<xsl:value-of select="priority_name"/>
				</td>
                <td >
					<xsl:value-of select="type_name"/>
				</td>
				<td  align="left">
					<a href="{$baseurl}&amp;op=activities.base.view&amp;activity_id={activity_id}">
						<xsl:value-of select="subject"/>
					</a>
				</td>
				<td >
					<a href="{$baseurl}&amp;op=accounts.base.view&amp;account_id={account_id}">
						<xsl:value-of select="account_name"/>
					</a>
				</td>
				<td >
					<a href="{$baseurl}&amp;op=contacts.base.view&amp;contact_id={contact_id}">				
						<xsl:value-of select="first_names"/>&#160;<xsl:value-of select="last_name"/>
					</a>
				</td>							
				<td >
			        <xsl:value-of select="activity_start"/>
				</td>
				<td >
					<xsl:value-of select="status_name"/>
				</td>				
			</tr>
		</xsl:for-each>
		</table>
	</div>
</xsl:template>

<xsl:template match="dashlet_name[.='upcoming_activities_wide_priority']">
	<xsl:call-template name="headerDashboardBox">
		<xsl:with-param name="appLabel">Upcoming Activities By Priority</xsl:with-param>
		<xsl:with-param name="appName">upcoming_activities_wide</xsl:with-param>		
	</xsl:call-template>
	<div id="upcoming_activities_wide-div">
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr class="label" align="center">
			<td width="5%">
				<xsl:value-of select="php:function('lang','Priority')"/>
			</td>
			<td width="5%">
				<xsl:value-of select="php:function('lang','Type')"/>
			</td>
			<td width="*">
				<xsl:value-of select="php:function('lang','Subject')"/>
			</td>
			<td width="*">
				<xsl:value-of select="php:function('lang','Account')"/>
			</td>			
			<td width="*">
				<xsl:value-of select="php:function('lang','Contact')"/>
			</td>
			<td width="*">
				<xsl:value-of select="php:function('lang','Date and Time')"/>
			</td>	
			<td width="*">
				<xsl:value-of select="php:function('lang','Status')"/>
			</td>										
		</tr>
		<xsl:for-each select = "/APPSHORE/APP/upcoming_activities_wide_priority/activities/activities_item">
			<tr class="unselectedtext"  align="center" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
            	<td >
					<xsl:value-of select="priority_name"/>
				</td>
                <td >
					<xsl:value-of select="type_name"/>
				</td>
				<td  align="left">
					<a href="{$baseurl}&amp;op=activities.base.view&amp;activity_id={activity_id}">
						<xsl:value-of select="subject"/>
					</a>
				</td>
				<td >
					<a href="{$baseurl}&amp;op=accounts.base.view&amp;account_id={account_id}">
						<xsl:value-of select="account_name"/>
					</a>
				</td>
				<td >
					<a href="{$baseurl}&amp;op=contacts.base.view&amp;contact_id={contact_id}">				
						<xsl:value-of select="first_names"/>&#160;<xsl:value-of select="last_name"/>
					</a>
				</td>							
				<td >
			        <xsl:value-of select="activity_start"/>
				</td>
				<td >
					<xsl:value-of select="status_name"/>
				</td>				
			</tr>
		</xsl:for-each>
		</table>
	</div>
</xsl:template>

</xsl:stylesheet>
