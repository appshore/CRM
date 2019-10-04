<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>
			
<xsl:template match="APP[action/node()[name() = /APPSHORE/APP/recordset/appName]]">
    <table width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
		    <xsl:call-template name="leftPanel"/>
            <td id="right_panel" class="right_panel">
				<xsl:choose>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'search'">
				    	<xsl:call-template name="custom_search">
				    		<xsl:with-param name="appName"><xsl:value-of select="/APPSHORE/APP/recordset/appName"/></xsl:with-param>
				    		<xsl:with-param name="appLabel"><xsl:value-of select="/APPSHORE/APP/recordset/appLabel"/></xsl:with-param>
				    	</xsl:call-template>	
				    	<xsl:call-template name="reports_grid">
				    		<xsl:with-param name="appName"><xsl:value-of select="/APPSHORE/APP/recordset/appName"/></xsl:with-param>
				    		<xsl:with-param name="appLabel"><xsl:value-of select="/APPSHORE/APP/recordset/appLabel"/></xsl:with-param>
				    		<xsl:with-param name="nodeName"><xsl:value-of select="/APPSHORE/APP/recordset/appName"/></xsl:with-param>				    		
				    		<xsl:with-param name="recordId"><xsl:value-of select="/APPSHORE/APP/recordset/appRecordId"/></xsl:with-param>		
				    	</xsl:call-template>
				    	<xsl:call-template name="custom_bulk">
				    		<xsl:with-param name="appName"><xsl:value-of select="/APPSHORE/APP/recordset/appName"/></xsl:with-param>
				    		<xsl:with-param name="nodeName"><xsl:value-of select="/APPSHORE/APP/recordset/appName"/></xsl:with-param>				    		
				    		<xsl:with-param name="selectedForm">reports_grid</xsl:with-param>				    		
				    	</xsl:call-template>
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'view'">
				    	<xsl:call-template name="reports_view">
				    		<xsl:with-param name="appName"><xsl:value-of select="/APPSHORE/APP/recordset/appName"/></xsl:with-param>
				    		<xsl:with-param name="appLabel"><xsl:value-of select="/APPSHORE/APP/recordset/appLabelSingular"/></xsl:with-param>
				    		<xsl:with-param name="nodeName"><xsl:value-of select="/APPSHORE/APP/recordset/appNameSingular"/></xsl:with-param>
				    		<xsl:with-param name="recordId"><xsl:value-of select="/APPSHORE/APP/recordset/appRecordId"/></xsl:with-param>		
				    		<xsl:with-param name="recordName"><xsl:value-of select="/APPSHORE/APP/recordset/appRecordName"/></xsl:with-param>					    		
				    	</xsl:call-template>				    					    	
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'edit'">
				    	<xsl:call-template name="reports_edit">
				    		<xsl:with-param name="appName"><xsl:value-of select="/APPSHORE/APP/recordset/appName"/></xsl:with-param>
				    		<xsl:with-param name="appLabel"><xsl:value-of select="/APPSHORE/APP/recordset/appLabelSingular"/></xsl:with-param>
				    		<xsl:with-param name="nodeName"><xsl:value-of select="/APPSHORE/APP/recordset/appNameSingular"/></xsl:with-param>
				    		<xsl:with-param name="recordId"><xsl:value-of select="/APPSHORE/APP/recordset/appRecordId"/></xsl:with-param>		
				    		<xsl:with-param name="recordName"><xsl:value-of select="/APPSHORE/APP/recordset/appRecordName"/></xsl:with-param>					    		
				    	</xsl:call-template>				    					    	
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'popup_edit'">
				    	<xsl:call-template name="reports_popup_edit">
				    		<xsl:with-param name="appName"><xsl:value-of select="/APPSHORE/APP/recordset/appName"/></xsl:with-param>
				    		<xsl:with-param name="appLabel"><xsl:value-of select="/APPSHORE/APP/recordset/appLabelSingular"/></xsl:with-param>
				    		<xsl:with-param name="nodeName"><xsl:value-of select="/APPSHORE/APP/recordset/appNameSingular"/></xsl:with-param>
				    		<xsl:with-param name="recordId"><xsl:value-of select="/APPSHORE/APP/recordset/appRecordId"/></xsl:with-param>		
				    		<xsl:with-param name="recordName"><xsl:value-of select="/APPSHORE/APP/recordset/appRecordName"/></xsl:with-param>					    		
				    	</xsl:call-template>
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'run'">
				    	<xsl:call-template name="reports_run">
				    		<xsl:with-param name="appName"><xsl:value-of select="/APPSHORE/APP/recordset/appName"/></xsl:with-param>
				    		<xsl:with-param name="appLabel"><xsl:value-of select="/APPSHORE/APP/recordset/appLabelSingular"/></xsl:with-param>
				    		<xsl:with-param name="nodeName"><xsl:value-of select="/APPSHORE/APP/recordset/appNameSingular"/></xsl:with-param>
				    		<xsl:with-param name="recordId"><xsl:value-of select="/APPSHORE/APP/recordset/appRecordId"/></xsl:with-param>		
				    		<xsl:with-param name="recordName"><xsl:value-of select="/APPSHORE/APP/recordset/appRecordName"/></xsl:with-param>					    		
				    	</xsl:call-template>				    					    	
					</xsl:when>
					<xsl:otherwise>
				    	<xsl:call-template name="custom_actions"/>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>


<xsl:template name="reports_grid">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>
	<xsl:param name="nodeName"/>		
	<xsl:param name="recordId"/>	

    <div class="clearboth formTitle">
		<xsl:value-of select="php:function('lang',$appLabel)"/>
	</div>							
	
	<form name="reports_grid" method="post" >
		<input type="hidden" name="op" id="op" value="{$appName}.base.search"/>
		<input type="hidden" name="orderby" id="orberby" value="{/APPSHORE/APP/recordset/orderby}"/>		
		<input type="hidden" name="ascdesc" id="ascdesc" value="{/APPSHORE/APP/recordset/ascdesc}"/>	
		<input type="hidden" name="key" id="key" />	
		<input type="hidden" name="selected" id="selected" />	
		<input type="hidden" name="nbrecords" id="nbrecords" />			

		<table class="formBar" border="0" cellspacing="0" cellpadding="0">
			<tr class="formBarContent">
				<xsl:if test="/APPSHORE/APP/scope > 0"> 								
					<td class="formBarContent start_direction">
					    <xsl:call-template name="gridCheckAllListForm">
						<xsl:with-param name="thisForm" select="'reports_grid'"/>
						</xsl:call-template>				
					</td>
				</xsl:if>
				<td class="formBarContent end_direction">
				    <xsl:call-template name="gridButtons">
						<xsl:with-param name="thisForm" select="'reports_grid'"/>
					</xsl:call-template>        
				</td>
			</tr>					
		</table>						

		<!-- results list -->
		<xsl:variable name="fieldsCount" select="count(/APPSHORE/APP/result_fields/result_fields_item)+3"/>					

		<table class="resizable searchResultsTable" border="0" style="width:100%" cellspacing="0" cellpadding="0">
			<tr class="searchResultsHeader">
			    <td class="searchResultsHeaderIcons"/>				
				<td class="searchResultsHeaderIcons">
					<a href="javascript:gridOrderBy(document.reports_grid,'created');">
			            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Sort by date of creation')"/></xsl:attribute>
	                    <xsl:value-of select="php:function('lang','C')"/>
	                </a>
				</td>
				<td class="searchResultsHeaderIcons">
					<a href="javascript:gridOrderBy(document.reports_grid,'updated');">
			            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Sort by date of last update')"/></xsl:attribute>
	                    <xsl:value-of select="php:function('lang','U')"/>
	                </a>
				</td>				
				<td class="searchResultsHeaderIcons">
					<a href="javascript:gridOrderBy(document.reports_grid,'type_id');">
			            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Sort by report type')"/></xsl:attribute>
	                    <xsl:value-of select="php:function('lang','T')"/>
	                </a>
				</td>				
				<xsl:for-each select = "/APPSHORE/APP/result_fields/result_fields_item[is_visible = 'Y']" >
					<th>
						<xsl:call-template name="gridFieldsHeader">
							<xsl:with-param name="thisForm">reports_grid</xsl:with-param>
						</xsl:call-template>	
					</th>					
				</xsl:for-each>									
			</tr>
			
			<xsl:variable name="items"><xsl:value-of select="$nodeName"/>_item</xsl:variable>					
			<xsl:for-each select = "/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $items]">
				<xsl:variable name="currentRecord" select="current()"/>					
				<xsl:variable name="recordId_value" select="*[name() = $recordId]"/>					
				<xsl:variable name="unselectedtext"><xsl:choose><xsl:when test ="record_date = 'new'">new</xsl:when><xsl:when test ="record_date = 'expired'">expired</xsl:when><xsl:otherwise>unselectedtext</xsl:otherwise></xsl:choose></xsl:variable>											
				<tr onMouseOver="this.className ='searchResultsSelected'" onMouseOut="this.className =''">
					<xsl:if test="/APPSHORE/APP/scope > 0"> 								
						<td class="searchResultsIcons" >		
						    <xsl:call-template name="gridCheckListForm">
								<xsl:with-param name="thisForm">reports_grid</xsl:with-param>				
								<xsl:with-param name="thisId"><xsl:value-of select="$recordId_value"/></xsl:with-param>					
								<xsl:with-param name="scope"><xsl:value-of select="scope"/></xsl:with-param>					
							</xsl:call-template>
						</td>
	         		</xsl:if>
					<td class="searchResultsIcons" >		
						<xsl:choose>
							<xsl:when test="string-length(quickparameter)">
								<img onclick='popupIntra("{$baseurl}&amp;op=reports.{quickparameter}&amp;out=default&amp;report_id={$recordId_value}&amp;report_popup_type=quick&amp;_rd="+Math.random(),"{report_name}")'>
									<xsl:attribute name="src"><xsl:value-of select="$api_image_path" />/run.gif</xsl:attribute>
						            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Run report and display on screen for printing')"/></xsl:attribute>
								</img>
							</xsl:when>
							<xsl:otherwise>
								<img onclick='popupIntra("{$baseurl}&amp;op=reports.listing.predefined&amp;out=default&amp;report_id={$recordId_value}&amp;_rd="+Math.random(),"{report_name}");'>
									<xsl:attribute name="src"><xsl:value-of select="$api_image_path" />/run2.gif</xsl:attribute>
						            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Run report and display on screen for printing')"/></xsl:attribute>
								</img>
							</xsl:otherwise>	
						</xsl:choose>
					</td>	
			
<!--	
					<td class="searchResultsIcons" >		
						<xsl:choose>
							<xsl:when test="string-length(quickparameter)">
								<img title="Run report and export as a PDF file" onclick='popupIntra("{$baseurl}&amp;op=reports.parameter_popup.{quickparameter}&amp;out=pdf&amp;report_id={$recordId_value}&amp;report_popup_type=quick","Report Parameter");'>
									<xsl:attribute name="src"><xsl:value-of select="$api_image_path" />/pdf.gif</xsl:attribute>
								</img>
							</xsl:when>
							<xsl:otherwise>
								<img title="Run report and export as a PDF file" onclick="location.href='{$baseurl}&amp;op=reports.listing.predefined&amp;out=pdf&amp;report_id={$recordId_value}'">
									<xsl:attribute name="src"><xsl:value-of select="$api_image_path" />/pdf.gif</xsl:attribute>
			         			</img>												
							</xsl:otherwise>	
						</xsl:choose>
					</td>									
-->							
					<td class="searchResultsIcons" >		
						<xsl:choose>
							<xsl:when test="string-length(quickparameter)">
								<img onclick='popupIntra("{$baseurl}&amp;op=reports.{quickparameter}&amp;out=csv&amp;report_id={$recordId_value}&amp;report_popup_type=csv_out&amp;_rd="+Math.random(),"Report parameters");'>
									<xsl:attribute name="src"><xsl:value-of select="$api_image_path" />/mime_csv.gif</xsl:attribute>
						            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Run report and export as a CSV file')"/></xsl:attribute>
								</img>
							</xsl:when>
							<xsl:otherwise>
								<img onclick="location.href='{$baseurl}&amp;op=reports.listing.predefined&amp;out=csv&amp;report_id={$recordId_value}&amp;_rd='+Math.random()">
									<xsl:attribute name="src"><xsl:value-of select="$api_image_path" />/mime_csv.gif</xsl:attribute>
						            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Run report and export as a CSV file')"/></xsl:attribute>
				         		</img>												
							</xsl:otherwise>	
						</xsl:choose>
					</td>									
					<td class="searchResultsIcons" >		
						<xsl:if test="scope > 0" >
							<img onclick="location.href='{$baseurl}&amp;op={$appName}.builder.edit&amp;{$recordId}={$recordId_value}&amp;offset={offset}'">
		            	        <xsl:attribute name="src"><xsl:value-of select="$api_image_path" />/run2o.png</xsl:attribute>
					            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Edit a custom report')"/></xsl:attribute>
		         			</img>												
		         		</xsl:if>
					</td>									
					<xsl:for-each select = "/APPSHORE/APP/result_fields/result_fields_item[is_visible = 'Y']" >
						<td class="searchResultsCells">
							<xsl:call-template name="gridFields">
								<xsl:with-param name="appName" select="$appName"/>
								<xsl:with-param name="recordId" select="$recordId"/>
								<xsl:with-param name="recordId_value" select="$recordId_value"/>
								<xsl:with-param name="currentRecord" select="$currentRecord"/>
								<xsl:with-param name="currentField" select="current()"/>
								<xsl:with-param name="unselectedtext" select="$unselectedtext"/>
							</xsl:call-template>	
						</td>	
					</xsl:for-each>																					
				</tr>
			</xsl:for-each>
		</table>

		<table class="formBar" border="0" cellspacing="0" cellpadding="0">
			<tr class="formBarContent">
				<xsl:if test="/APPSHORE/APP/scope > 0"> 								
					<td class="formBarContent start_direction">
					    <xsl:call-template name="gridCheckAllListForm">
						<xsl:with-param name="thisForm" select="'reports_grid'"/>
						</xsl:call-template>				
					</td>
				</xsl:if>
				<td class="formBarContent end_direction">
				    <xsl:call-template name="gridButtons">
						<xsl:with-param name="thisForm" select="'reports_grid'"/>
					</xsl:call-template>        
				</td>
			</tr>					
		</table>						
	</form>
	

</xsl:template>

</xsl:stylesheet>
