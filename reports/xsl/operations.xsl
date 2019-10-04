<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="operations_filter">
<!--<script language="JavaScript" type="text/javascript" src="lib/popup.js"/>
<script language="JavaScript" type="text/javascript" src="reports/js/operations.js"/>-->
<!-- ******************************************************************************************* -->
<!--<form name="report_edit" method="post">	-->

	<table  cellSpacing="1" cellPadding="1" border="0" width="100%" valign="top">
		<input type="hidden" name="op" value="reports.base.edit"/>
		<input type="hidden" name="submenu_id" value="operation"/>
		<input type="hidden" name="report_id" >
			<xsl:attribute name="value"><xsl:value-of select="report/report_id" /></xsl:attribute>
		</input>
		<input type="hidden" name="report_name" >
			<xsl:attribute name="value"><xsl:value-of select="report/report_name" /></xsl:attribute>
		</input>
		<input type="hidden" name="table_name" >
			<xsl:attribute name="value"><xsl:value-of select="report/table_name" /></xsl:attribute>
		</input>
		<input type="hidden" name="selectedcolumns" >
			<xsl:attribute name="value"><xsl:value-of select="report/selectedcolumns" /></xsl:attribute>
		</input>
		<input type="hidden" name="groupbylines" >
			<xsl:attribute name="value"><xsl:value-of select="report/groupbylines" /></xsl:attribute>
		</input>
		<input type="hidden" name="groupbycolumns" >
			<xsl:attribute name="value"><xsl:value-of select="report/groupbycolumns" /></xsl:attribute>
		</input>
		<input type="hidden" name="filterlines" >
			<xsl:attribute name="value"><xsl:value-of select="report/filterlines" /></xsl:attribute>
		</input>
		<input type="hidden" name="filtercriterias" >
			<xsl:attribute name="value"><xsl:value-of select="report/filtercriterias" /></xsl:attribute>
		</input>
		<input type="hidden" name="allgroupbys" >
			<xsl:attribute name="value"><xsl:value-of select="allgroupbysStr" /></xsl:attribute>
		</input>
		<input type="hidden" name="allfilters" >
			<xsl:attribute name="value"><xsl:value-of select="allfiltersStr" /></xsl:attribute>
		</input>
		<input type="hidden" name="rank" >
			<xsl:attribute name="value"></xsl:attribute>
		</input>
		<input type="hidden" name="updown" >
			<xsl:attribute name="value"></xsl:attribute>
		</input>
		<input type="hidden" name="subst_key" >
			<xsl:attribute name="value"></xsl:attribute>
		</input>
		<xsl:choose>
				<xsl:when test="report/report_id and report/selectedcolumns">
					<tr >				
						<td class="label" align="right" width="10%" >
						</td>
						<td class="field" align="left" width="56%" colspan="3" valign="top">
							<table border="0" width="100%" cellpadding="1" cellspacing="1" >
								<tr align="center">	
									<td class="label" ><xsl:value-of select="php:function('lang','Name')"/></td>
									<td class="label" width="8%"><xsl:value-of select="php:function('lang','GroupBy')"/></td>
									<td class="label" width="7%"><xsl:value-of select="php:function('lang','Count')"/></td>
									<td class="label" width="7%"><xsl:value-of select="php:function('lang','Sum')"/></td>
									<td class="label" width="9%"><xsl:value-of select="php:function('lang','Average')"/></td>
									<td class="label" width="9%"><xsl:value-of select="php:function('lang','Minimum')"/></td>
									<td class="label" width="9%"><xsl:value-of select="php:function('lang','Maximum')"/></td>
									<td class="label" width="15%"></td>
									<td class="label" width="13%"></td>
								</tr>															
								<xsl:call-template name="loop_groupby">
									<xsl:with-param name="i">1</xsl:with-param>
									<xsl:with-param name="count" >5</xsl:with-param>
								</xsl:call-template>
							</table>
						</td>
					</tr>
					<tr>
						<td class="label" align="right" width="10%" >
						</td>	
						<td class="field" align="left" width="56%" colspan="3" valign="top">
							<table border="0" width="100%" cellpadding="1" cellspacing="1" >
								<tr align="center">	
									<td class="label" width="15%"><xsl:value-of select="php:function('lang','Column')"/></td>
									<td class="label" width="20%"><xsl:value-of select="php:function('lang','Operation')"/></td>
									<td class="label" width="30%"><xsl:value-of select="php:function('lang','Criteria')"/></td>
									<td class="label" width="15%"></td>
									<td class="label" width="10%"></td>
								</tr>	
								<xsl:call-template name="loop_filter">
									<xsl:with-param name="i">1</xsl:with-param>
									<xsl:with-param name="count" >5</xsl:with-param>
								</xsl:call-template>														
							</table>
						</td>				
					</tr>				
				</xsl:when>
				<xsl:otherwise>
				<td colspan="5"><xsl:value-of select="php:function('lang','Please check your data and save your Report first!')"/></td>
				</xsl:otherwise>
		</xsl:choose>
	</table>
	<!--<table border="0" width="100%" cellpadding="0" cellspacing="0">				
		<tr >
			<xsl:choose>
				<xsl:when test=" report/scope=1 ">
					<td >
						<xsl:choose>
						<xsl:when test="report/report_id and report/selectedcolumns ">
							<input type="submit" class="formBarButton" name="key" value="Save" onclick="buildGroupbycolumn();buildFiltercriteria();"/>&#160;
							<input type="submit" class="formBarButton" name="key" value="Copy" />&#160;
							<input class="formBarButton" type="button" value="Delete"  onclick="javascript:confirmDelete('{$baseurl}&amp;op=reports.base.edit&amp;report_id={/APPSHORE/APP/report/report_id}&amp;key=Delete')"/>&#160;
							<input type="button"  onclick ="popupIntra('{$baseurl}&amp;op=reports.listing.runtab&amp;report_id='+document.report_edit.report_id.value,'popup Reports');">
								<xsl:attribute name="value">Run Report</xsl:attribute>
							</input>&#160;
							<input type="submit" class="formBarButton" name="key" value="Cancel" />
						</xsl:when>
						<xsl:otherwise>
						</xsl:otherwise>
						</xsl:choose>
					</td>
					<td>
						<input type="submit" class="formBarButton" name="key" value="Previous" onclick="buildGroupbycolumn();buildFiltercriteria();"/>&#160; 
						<input type="submit" class="formBarButton" name="key" value="Next"  onclick="buildGroupbycolumn();buildFiltercriteria();"/>&#160; 
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td >
						<br/>
						<xsl:choose>
							<xsl:when test="report/report_id and report/selectedcolumns ">
								<input type="button"  onclick ="popupIntra('{$baseurl}&amp;op=reports.listing.runtab&amp;report_id='+document.report_edit.report_id.value,'popup Reports');">
									<xsl:attribute name="value">Run Report</xsl:attribute>
								</input>&#160;
							</xsl:when>
							<xsl:otherwise>
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</xsl:otherwise>
		</xsl:choose>
		</tr>
	</table>-->
<!-- </form>	 -->
</xsl:template>


</xsl:stylesheet>
