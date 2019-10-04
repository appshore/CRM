<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP[action/statistics]">
    <table width="100%" cellSpacing="0" cellPadding="0"  bdata="0" >
		<tr width="100%" valign="top">
			<td class="left_panel" id="left_panel" style="display:{/APPSHORE/API/cookie/left_panel}">
			    <xsl:call-template name="verticalMenus">		    
					<xsl:with-param name="appName">administration</xsl:with-param>
					<xsl:with-param name="appLabel">Administration</xsl:with-param>
				</xsl:call-template>	
			</td>
            <td id="right_panel" class="right_panel">
		    	<xsl:call-template name="statistics_view"/>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name="statistics_view">

	<script language="JavaScript" type="text/javascript" src="{$lib_js_path}/graph.js"/>

	<div class="clearboth" style="width:100%">
		<div class="formTitleTags start_float">
        	<xsl:value-of select="php:function('lang','Usage statistics')"/>
		</div>
		<div class="clearboth">
		 	<xsl:call-template name="statField">
				<xsl:with-param name="field_label" select="'Edition'"/>
				<xsl:with-param name="field_value" select="statistics/edition_name"/>
			</xsl:call-template>
		</div>
		<div class="clearboth" >
			<div class="start_float" style="width:50%">
			 	<xsl:call-template name="statField">
					<xsl:with-param name="field_label" select="'Due date'"/>
					<xsl:with-param name="field_value" select="statistics/due_date"/>
				</xsl:call-template>
			</div>
			<div class="end_float" style="width:50%">
			 	<xsl:call-template name="statField">
					<xsl:with-param name="field_label" select="'Last license check'"/>
					<xsl:with-param name="field_value" select="statistics/license_time_stamp"/>
				</xsl:call-template>
			</div>
		</div>
		<div class="clearboth" >
			<div class="start_float" style="width:50%">
			 	<xsl:call-template name="statField">
					<xsl:with-param name="field_label" select="'Date of registration'"/>
					<xsl:with-param name="field_value" select="statistics/created"/>
				</xsl:call-template>
			</div>
			<div class="end_float" style="width:50%">
			 	<xsl:call-template name="statField">
					<xsl:with-param name="field_label" select="'Last auto update'"/>
					<xsl:with-param name="field_value" select="statistics/appshore_version"/>
				</xsl:call-template>
			</div>
		</div>
		<div class="clearboth">
		 	<xsl:call-template name="statField">
				<xsl:with-param name="field_label" select="'Applications available'"/>
				<xsl:with-param name="field_value" select="statistics/applications"/>
			</xsl:call-template>
		</div>
		
	 	<xsl:call-template name="statHeader">
			<xsl:with-param name="appLabel">Users</xsl:with-param>
		</xsl:call-template>
		<div class="clearboth">
			<div class="start_float" style="width:50%">
			 	<xsl:call-template name="statField">
					<xsl:with-param name="field_label" select="'Users quota'"/>
					<xsl:with-param name="field_value" select="statistics/users_quota"/>
				</xsl:call-template>
			 	<xsl:call-template name="statField">
					<xsl:with-param name="field_label" select="'Users created'"/>
					<xsl:with-param name="field_value" select="statistics/users_count"/>
				</xsl:call-template>
			 	<xsl:call-template name="statField">
					<xsl:with-param name="field_label" select="'Users activated'"/>
					<xsl:with-param name="field_value" select="statistics/users_activated"/>
				</xsl:call-template>
			</div>
			<div class="end_float" style="width:50%">
				<div id="gauge_users" style="padding:10px 0 0 0"/>
			</div>
		</div>

	 	<xsl:call-template name="statHeader">
			<xsl:with-param name="appLabel">Emails</xsl:with-param>
		</xsl:call-template>
		<div class="clearboth">
		 	<xsl:call-template name="statField">
				<xsl:with-param name="field_label" select="'Daily emails quota'"/>
				<xsl:with-param name="field_value" select="format-number(statistics/emails_quota,'###,###,###')"/>
			</xsl:call-template>
			<br/>
		</div>
		
	 	<xsl:call-template name="statHeader">
			<xsl:with-param name="appLabel">Disk space</xsl:with-param>
		</xsl:call-template>
		<div class="clearboth" >
			<div class="start_float" style="width:50%">
			 	<xsl:call-template name="statField">
					<xsl:with-param name="field_label" select="'Documents size'"/>
					<xsl:with-param name="field_value" select="statistics/documents_size"/>
				</xsl:call-template>
			 	<xsl:call-template name="statField">
					<xsl:with-param name="field_label" select="'Quantity'"/>
					<xsl:with-param name="field_value" select="format-number(statistics/documents_count,'###,###,###')"/>
				</xsl:call-template>
			 	<xsl:call-template name="statField">
					<xsl:with-param name="field_label" select="'Attachments size'"/>
					<xsl:with-param name="field_value" select="statistics/attachments_size"/>
				</xsl:call-template>
			 	<xsl:call-template name="statField">
					<xsl:with-param name="field_label" select="'Quantity'"/>
					<xsl:with-param name="field_value" select="format-number(statistics/attachments_count,'###,###,###')"/>
				</xsl:call-template>
			 	<xsl:call-template name="statField">
					<xsl:with-param name="field_label" select="'Disk space quota'"/>
					<xsl:with-param name="field_value" select="statistics/disk_quota"/>
				</xsl:call-template>
			 	<xsl:call-template name="statField">
					<xsl:with-param name="field_label" select="'Disk space used'"/>
					<xsl:with-param name="field_value" select="concat(statistics/disk_used,' (',statistics/disk_used_percentage,'%)')"/>
				</xsl:call-template>
			 	<xsl:call-template name="statField">
					<xsl:with-param name="field_label" select="'Database records quota'"/>
					<xsl:with-param name="field_value" select="format-number(statistics/records_quota,'###,###,###')"/>
				</xsl:call-template>
			 	<xsl:call-template name="statField">
					<xsl:with-param name="field_label" select="'Records created'"/>
					<xsl:with-param name="field_value" select="concat(format-number(statistics/db_records,'###,###,###'),' (',statistics/db_records_percentage,'%)')"/>
				</xsl:call-template>
			</div>			
			<div class="end_float" style="width:50%">
				<div id="gauge_disk" style="padding:10px 0 0 0"/>
				<div id="gauge_records" style="padding:10px 0 0 0"/>
			</div>
		</div>
		
		<script type="text/javascript" src="http://www.google.com/jsapi"/>
		<script type="text/javascript">
			google.load('visualization', '1', {packages: ['gauge']});
		</script>
		<script type="text/javascript">
			function drawGauge( container,label, value, maxValue) 
			{
				var data = new google.visualization.DataTable();
				data.addColumn('string', 'Label');
				data.addColumn('number', 'Value');
				data.addRows(4);
				data.setValue(0, 0, label);
				data.setValue(0, 1, value);

				var chart = new google.visualization.Gauge(document.getElementById(container));
				var options = {height: 150, max: maxValue, redFrom: maxValue*0.9, redTo: maxValue, yellowFrom:maxValue*0.7, yellowTo: maxValue*0.9};
				chart.draw(data, options);
			};

			function loadGauges() 
			{
				drawGauge('gauge_users','<xsl:value-of select="php:functionString('lang','Users')"/>', <xsl:value-of select="statistics/users_count"/>, <xsl:value-of select="statistics/users_quota"/>);
				drawGauge('gauge_disk','<xsl:value-of select="php:functionString('lang','Space')"/>', <xsl:value-of select="statistics/disk_used_percentage"/>, 100);
				drawGauge('gauge_records','<xsl:value-of select="php:functionString('lang','Records')"/>', <xsl:value-of select="statistics/db_records_percentage"/>, 100);
			};

			google.setOnLoadCallback(loadGauges);
	 	</script>			
	</div>
 </xsl:template>

<xsl:template name="statField">
	<xsl:param name="field_label"/>
	<xsl:param name="field_value"/>	
	<div class="clearboth fieldLabelContainer" style="padding-top:10px">
		<div class="fieldLabel start_float">
			<xsl:attribute name="title"><xsl:value-of select="php:functionString('lang',$field_label)"/></xsl:attribute>
			<xsl:value-of select="php:functionString('lang',$field_label)"/>
		</div>
		<div class="clearboth fieldText" >
			<xsl:value-of select="$field_value"/>
		</div>
	</div>
</xsl:template>

<xsl:template name="statHeader">
	<xsl:param name="appLabel"/>
	<div class="clearboth formBlockTitle" style="padding-top:10px">
		<xsl:value-of select="php:functionString('lang',$appLabel)"/>
	</div>
</xsl:template>

</xsl:stylesheet>
