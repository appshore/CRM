<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="/APPSHORE/API/Plugins" mode="ViewButtons">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	
</xsl:template>

<xsl:template match="/APPSHORE/API/Plugins" mode="ViewLines">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	
	<xsl:call-template name="viewLines">
		<xsl:with-param name="appName" select="$appName"/>
		<xsl:with-param name="thisForm" select="$thisForm"/>	
	</xsl:call-template>
</xsl:template>

<xsl:template match="/APPSHORE/API/Plugins" mode="EditButtons">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	
</xsl:template>

<xsl:template match="/APPSHORE/API/Plugins" mode="EditLines">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	
	<xsl:call-template name="editLines">
		<xsl:with-param name="appName" select="$appName"/>
		<xsl:with-param name="thisForm" select="$thisForm"/>	
	</xsl:call-template>
</xsl:template>

<xsl:template name="viewLines">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	

	<xsl:for-each select = "/APPSHORE/APP/daily_lines/daily_lines_item">
	    <xsl:sort select="activity/activity_start"/>
		<table border="0" width="100%" cellpadding="1" cellspacing="1" style="line-height:2em">
			<tr class="label">
				<td>
		            <xsl:value-of select="php:function('lang','Time')"/><br/>
		            <xsl:value-of select="php:function('lang','Category')"/>
				</td>
				<td colspan="7">
		            <xsl:value-of select="php:function('lang','Account')"/>&#160;::&#160;<xsl:value-of select="php:function('lang','Contact')"/>
				</td>
				<td colspan="3">
		            <xsl:value-of select="php:function('lang','Purpose')"/>&#160;::&#160;<xsl:value-of select="php:function('lang','Achievement of Activity')"/>
	 			</td>
	 		</tr>
			<tr class="field">
				<td>
		            <xsl:value-of select="activity/activity_start"/>
				</td>
				<td colspan="7">
		            <xsl:value-of select="account/account_name"/>&#160;::&#160;<xsl:value-of select="contact/full_name"/>
				</td>
				<td colspan="3">
		            <xsl:value-of select="activity/subject"/>&#160;::&#160;<xsl:value-of select="activity/status_name"/>
	 			</td>
	 		</tr>
			<tr>
				<td class="field">
				</td>
				<td class="label" colspan="3">
		            <xsl:value-of select="php:function('lang','Opportunity')"/>
				</td>
				<td class="label" colspan="1">
		            <xsl:value-of select="php:function('lang','Probability')"/>
				</td>
				<td class="label" colspan="3">
		            <xsl:value-of select="php:function('lang','Projected')"/>
				</td>
				<td class="label" colspan="3">
		            <xsl:value-of select="php:function('lang','Actual')"/>
	 			</td>
	 		</tr>
			<tr>
				<td class="field">
				</td>
				<td class="label" colspan="3">
				</td>
				<td class="label">
				</td>
				<td class="label">
		            <xsl:value-of select="php:function('lang','Order date')"/>
				</td>
				<td class="label">
		            <xsl:value-of select="php:function('lang','Revenue')"/>
				</td>
				<td class="label">
		            <xsl:value-of select="php:function('lang','Margin')"/>
				</td>
				<td class="label">
		            <xsl:value-of select="php:function('lang','Order date')"/>
				</td>
				<td class="label">
		            <xsl:value-of select="php:function('lang','Revenue')"/>
				</td>
				<td class="label">
		            <xsl:value-of select="php:function('lang','Margin')"/>
				</td>
	 		</tr>
			<tr>
				<td class="field">
				</td>
				<td class="field" colspan="3">
		            <xsl:value-of select="opportunity/opportunity_name"/>
				</td>
				<td class="field" colspan="1">
		            <xsl:value-of select="opportunity/probability"/>
				</td>
				<td class="field">
		            <xsl:value-of select="opportunity/expected_amount"/>
				</td>
				<td class="field">
		            <xsl:value-of select="opportunity/expected_amount"/>
				</td>
				<td class="field">
		            <xsl:value-of select="opportunity/expected_amount"/>
				</td>
				<td class="field">
		            <xsl:value-of select="opportunity/expected_amount"/>
				</td>
				<td class="field">
		            <xsl:value-of select="opportunity/expected_amount"/>
				</td>
				<td class="field">
		            <xsl:value-of select="opportunity/expected_amount"/>
				</td>
	 		</tr>
			<tr>
				<td class="field">
				</td>
				<td class="field" colspan="10">
		            <xsl:value-of select="php:function('lang','Activity detail')"/><br/>
		            <xsl:value-of select="activity/note"/>
				</td>
	 		</tr>
			<tr>
				<td class="field">
				</td>
				<td class="field" colspan="10">
		            <xsl:value-of select="php:functionString('lang','Comment from %s',/APPSHORE/APP/daily/related_supervisor_id)"/>:<br/>
		            <xsl:value-of select="supervisor_note"/>
				</td>
	 		</tr>
			<tr>
				<td class="field">
				</td>
				<td class="field" colspan="10">
		            <xsl:value-of select="php:functionString('lang','Comment from %s',/APPSHORE/APP/daily/related_manager_id)"/>:<br/>
		            <xsl:value-of select="manager_note"/>
				</td>
	 		</tr>
		</table>
	</xsl:for-each>
	<br/>

</xsl:template>

<xsl:template name="editLines">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	

	<xsl:for-each select = "/APPSHORE/APP/daily_lines/daily_lines_item">
	    <xsl:sort select="activity/activity_start"/>
		<table border="0" width="100%" cellpadding="1" cellspacing="1" style="line-height:2em">
			<tr class="label">
				<td>
		            <xsl:value-of select="php:function('lang','Time')"/><br/>
		            <xsl:value-of select="php:function('lang','Category')"/>
				</td>
				<td colspan="7">
		            <xsl:value-of select="php:function('lang','Account')"/>&#160;::&#160;<xsl:value-of select="php:function('lang','Contact')"/>
				</td>
				<td colspan="3">
		            <xsl:value-of select="php:function('lang','Purpose')"/>&#160;::&#160;<xsl:value-of select="php:function('lang','Achievement of Activity')"/>
	 			</td>
	 		</tr>
			<tr class="field">
				<td>
		            <xsl:value-of select="activity/activity_start"/>
				</td>
				<td colspan="7">
		            <xsl:value-of select="account/account_name"/>&#160;::&#160;<xsl:value-of select="contact/full_name"/>
				</td>
				<td colspan="3">
		            <xsl:value-of select="activity/subject"/>&#160;::&#160;<xsl:value-of select="activity/status_name"/>
	 			</td>
	 		</tr>
			<tr>
				<td class="field">
				</td>
				<td class="label" colspan="3">
		            <xsl:value-of select="php:function('lang','Opportunity')"/>
				</td>
				<td class="label" colspan="1">
		            <xsl:value-of select="php:function('lang','Probability')"/>
				</td>
				<td class="label" colspan="3">
		            <xsl:value-of select="php:function('lang','Projected')"/>
				</td>
				<td class="label" colspan="3">
		            <xsl:value-of select="php:function('lang','Actual')"/>
	 			</td>
	 		</tr>
			<tr>
				<td class="field">
				</td>
				<td class="label" colspan="3">
				</td>
				<td class="label">
				</td>
				<td class="label">
		            <xsl:value-of select="php:function('lang','Order date')"/>
				</td>
				<td class="label">
		            <xsl:value-of select="php:function('lang','Revenue')"/>
				</td>
				<td class="label">
		            <xsl:value-of select="php:function('lang','Margin')"/>
				</td>
				<td class="label">
		            <xsl:value-of select="php:function('lang','Order date')"/>
				</td>
				<td class="label">
		            <xsl:value-of select="php:function('lang','Revenue')"/>
				</td>
				<td class="label">
		            <xsl:value-of select="php:function('lang','Margin')"/>
				</td>
	 		</tr>
			<tr>
				<td class="field">
				</td>
				<td class="field" colspan="3">
		            <xsl:value-of select="opportunity/opportunity_name"/>
				</td>
				<td class="field" colspan="1">
		            <xsl:value-of select="opportunity/probability"/>
				</td>
				<td class="field">
		            <xsl:value-of select="opportunity/expected_amount"/>
				</td>
				<td class="field">
		            <xsl:value-of select="opportunity/expected_amount"/>
				</td>
				<td class="field">
		            <xsl:value-of select="opportunity/expected_amount"/>
				</td>
				<td class="field">
		            <xsl:value-of select="opportunity/expected_amount"/>
				</td>
				<td class="field">
		            <xsl:value-of select="opportunity/expected_amount"/>
				</td>
				<td class="field">
		            <xsl:value-of select="opportunity/expected_amount"/>
				</td>
	 		</tr>
			<tr>
				<td class="field">
				</td>
				<td class="field" colspan="10">
		            <xsl:value-of select="php:function('lang','Activity detail')"/><br/>
		            <xsl:value-of select="activity/note"/>
				</td>
	 		</tr>
			<tr>
				<td class="field">
				</td>
				<td class="field" colspan="10">
		            <xsl:value-of select="php:functionString('lang','Comment from %s',/APPSHORE/APP/daily/related_supervisor_id)"/>:<br/>
		            <xsl:value-of select="supervisor_note"/>
					<textarea type="text" name="supervisor_note_{increment}" id="supervisor_note_{increment}" size="10" style="width:90%" value="{supervisor_note}" />
				</td>
	 		</tr>
			<tr>
				<td class="field">
				</td>
				<td class="field" colspan="10">
		            <xsl:value-of select="php:functionString('lang','Comment from %s',/APPSHORE/APP/daily/related_manager_id)"/>:<br/>
					<textarea type="text" name="manager_note_{increment}" id="manager_note_{increment}" size="10" style="width:90%" value="{manager_note}" />
				</td>
	 		</tr>
		</table>
	</xsl:for-each>
	<br/>

</xsl:template>


</xsl:stylesheet>
