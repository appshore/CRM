<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP[action/quicksearch]">
	
	<table width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
			<xsl:call-template name="leftPanel"/>
			<td id="right_panel" class="right_panel">
			    <div class="clearboth linkedFormTitle" style="padding-bottom:10px">
					<xsl:value-of select="php:function('lang','Quick search')"/>
				</div>
				<div class="helpmsg">
					<xsl:choose>
						<xsl:when test="text">
	       				 	<xsl:value-of select="text"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="php:function('lang','The maximum number of lines returned per application is')"/>&#160;<xsl:value-of select="/APPSHORE/API/temp/nbrecords"/>.&#160;
							<xsl:value-of select="php:function('lang','If you do not see all the expected results please narrow your search.')"/>
						</xsl:otherwise>
					</xsl:choose>
				</div>
				<div>
					<xsl:for-each select = "/APPSHORE/APP/apps/apps_item">
						<xsl:call-template name="custom_quicksearch">
							<xsl:with-param name="appName" select="app_name"/>
							<xsl:with-param name="appLabel" select="app_label"/>
							<xsl:with-param name="nodeName" select="app_name"/>
							<xsl:with-param name="recordId" select="field_name"/>
						</xsl:call-template>
					</xsl:for-each>
				</div>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name="custom_quicksearch">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>
	<xsl:param name="nodeName"/>
	<xsl:param name="recordId"/>

    <div class="clearboth formTitle">
		<xsl:value-of select="php:functionString('lang',$appLabel)"/>
	</div>

	<xsl:variable name="recordsCount" select="count(/APPSHORE/APP/node()[name() = $nodeName]/result_fields/result_fields_item)"/>

	<table class="resizable sortable searchResultsTable" border="0" style="width:100%" cellspacing="0" cellpadding="0">
		<tr class="searchResultsHeader">
			<td class="searchResultsHeaderIcons"/>
			<td class="searchResultsHeaderIcons"/>
			<xsl:for-each select = "/APPSHORE/APP/node()[name() = $nodeName]/result_fields/result_fields_item" >
				<th>
		            <xsl:attribute name="class">searchResultsHeaderCells<xsl:if test="field_type = 'DA' or field_type = 'DT' or field_type = 'TS'"><xsl:if test="/APPSHORE/API/current_user/locale_date_id = '%m/%d/%Y'"> date-us</xsl:if></xsl:if>
					</xsl:attribute>
			        <a href="javascript:void(0)"><xsl:value-of select="php:functionString('lang',field_label)"/></a>
				</th>					
			</xsl:for-each>
		</tr>

		<xsl:for-each select = "/APPSHORE/APP/node()[name() = $nodeName]/results/results_item">
			<xsl:variable name="currentRecord" select="current()"/>
			<xsl:variable name="recordId_value" select="*[name() = $recordId]"/>
			<xsl:variable name="unselectedtext" select="record_class"/>
			<tr class="{record_class}" onMouseOver="this.className ='searchResultsSelected'" onMouseOut="this.className ='{record_class}'">
				<xsl:if test="not(record_class = 'unselectedtext')"> 								
		            <xsl:attribute name="title"><xsl:value-of select="php:functionString('lang', concat('record.class.',record_class))"/></xsl:attribute>
		        </xsl:if>
				<xsl:if test="scope > 0"> 								
					<td class="searchResultsIcons" >
						<a href="{$baseurl}&amp;op={$appName}.base.edit&amp;{$recordId}={$recordId_value}">
							<img class="image" src="{$api_image_path}/edit.png"/>
						</a>
					</td>
				</xsl:if>
				<td  class="searchResultsIcons" >
					<a href="{$baseurl}&amp;op={$appName}.base.view&amp;{$recordId}={$recordId_value}" onMouseOver="popupDetails('{$baseurl}&amp;op={$appName}.popup.view&amp;{$recordId}={$recordId_value}','{app_label}','{$api_image_path}','{$appName}');" onMouseOut="return nd();"  >
						<img class="image" src="{$api_image_path}/view.png"/>
					</a>
				</td>
				<xsl:for-each select = "/APPSHORE/APP/node()[name() = $nodeName]/result_fields/result_fields_item" >
					<td class="searchResultsCells">
						<xsl:call-template name="gridFields">
							<xsl:with-param name="appName" select="$appName"/>
							<xsl:with-param name="recordId" select="$recordId"/>
							<xsl:with-param name="recordId_value" select="$recordId_value"/>
							<xsl:with-param name="currentRecord" select="$currentRecord"/>
							<xsl:with-param name="currentField" select="current()"/>
<!--							<xsl:with-param name="unselectedtext" select="$unselectedtext"/>-->
						</xsl:call-template>
					</td>
				</xsl:for-each>
			</tr>
		</xsl:for-each>

		<xsl:variable name="fieldsCount" select="count(/APPSHORE/APP/node()[name() = $nodeName]/result_fields/result_fields_item)+3"/>
		<xsl:if test="$recordsCount = 0">
			<tr style="text-align:center;vertical-align:middle">
				<td colspan="{$fieldsCount}">
   				 	<H2 style="color:lightgrey;line-height:4em"><xsl:value-of select="php:function('lang','No entries')"/></H2>
				</td>
			</tr>
		</xsl:if>
	</table>
	
	<div style="padding-bottom:10px"/>

</xsl:template>


</xsl:stylesheet>
