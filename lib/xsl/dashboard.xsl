<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>


<xsl:template name="customDashboard">
	<xsl:param name="appName"/>
	<xsl:param name="dashletName"/>

	<table class="resizable sortable searchResultsTable" border="0" style="width:100%" cellspacing="0" cellpadding="0">
		<tr class="searchResultsHeader">
		    <td class="searchResultsHeaderIcons"/>				
			<xsl:for-each select = "/APPSHORE/APP/dashlet/node()[name() = $dashletName]/dashboard_fields/dashboard_fields_item" >
				<th>
		            <xsl:attribute name="class">searchResultsHeaderCells<xsl:if test="field_type = 'DA' or field_type = 'DT' or field_type = 'TS'"><xsl:if test="/APPSHORE/API/current_user/locale_date_id = '%m/%d/%Y'"> date-us</xsl:if></xsl:if>
					</xsl:attribute>
			        <a href="javascript:void(0)"><xsl:value-of select="php:functionString('lang',field_label)"/></a>
				</th>					
			</xsl:for-each>									
		</tr>
		
		<xsl:for-each select = "/APPSHORE/APP/dashlet/node()[name() = $dashletName]/results/results_item">
			<xsl:variable name="currentRecord" select="current()"/>					
			<xsl:variable name="recordId" select="/APPSHORE/APP/dashlet/node()[name() = $dashletName]/record_id"/>					
			<xsl:variable name="recordId_value" select="*[name() = $recordId]"/>					
			<xsl:variable name="unselectedtext"><xsl:choose><xsl:when test ="record_date = 'new'">new</xsl:when><xsl:when test ="record_date = 'expired'">expired</xsl:when><xsl:otherwise>unselectedtext</xsl:otherwise></xsl:choose></xsl:variable>											
			<tr class="{$unselectedtext}" style="line-height:2em" onMouseOver="this.className ='selectedtext'" onMouseOut="this.className ='{$unselectedtext}'">
				<td align="center" style="width:1em">		
					<xsl:if test="scope > 0"> 								
						<a href="{$baseurl}&amp;op={$appName}.base.edit&amp;{$recordId}={$recordId_value}&amp;offset={offset}">
	            	        <img class="image" src="{$api_image_path}/edit.png"/>
	         			</a>												
	         		</xsl:if>
				</td>									
				<xsl:for-each select = "/APPSHORE/APP/dashlet/node()[name() = $dashletName]/dashboard_fields/dashboard_fields_item" >
					<td class="{result_class}">
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

</xsl:template>


</xsl:stylesheet>
