<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="report_edit">
	<script language="JavaScript" type="text/javascript" src="{$lib_js_path}/popup.js"/>
	<script language="JavaScript" type="text/javascript" src="reports/js/operations.js"/>
	<script LANGUAGE="JavaScript" >
	<![CDATA[

	function changedTable()
	{
		document.report_edit.selectedcolumns.value='';
		this.document.report_edit.column_name.options.selectedIndex=0;
		this.document.report_edit.column_name.options.length =0;
	}

	function confirmDelete(href) 
	{
		if (confirm('Do you really want to delete this report?')) {
			window.location.replace(href);
		} 
	}
	]]>
	</script>

<!-- ******************************************************************************************* -->
	<form name="report_edit" method="post">
		<input type="hidden" name="op" value="reports.base.edit"/>
		<input type="hidden" name="report_id" >
			<xsl:attribute name="value"><xsl:value-of select="report/report_id" /></xsl:attribute>
		</input>
		<xsl:call-template name="headerEditForm">
			<xsl:with-param name="testParam"><xsl:value-of select="report/report_id" /></xsl:with-param>
			<xsl:with-param name="labelParam"><xsl:value-of select="report/report_name" /></xsl:with-param>
			<xsl:with-param name="appLabel">Report</xsl:with-param>
			<xsl:with-param name="appName">reports</xsl:with-param>
		</xsl:call-template>
		<table border="0" width="100%" cellpadding="1" cellspacing="1" >
			<tr valign="top">
			<td align="right" class="mandatory_label" width="10%" ><xsl:value-of select="php:function('lang','Report Name')"/>:</td>
			<td  class="field" align="left" width="23%">
				<input type="text" size="27" name="report_name" >
					<xsl:attribute name="value">
						<xsl:value-of select="report/report_name" />
						
					</xsl:attribute>
				</input>
				<xsl:if test="/APPSHORE/APP/error/report_name">
					<span class="failure">
						<br/><xsl:value-of select="/APPSHORE/APP/error/report_name" />
					</span>
				</xsl:if>
			</td>
			<td  class="field" align="left" width="76%" rowspan="6" >
<!--operations start-->
				<table  cellSpacing="1" cellPadding="1" border="0" width="100%" valign="top" >
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
						<xsl:when test="string(/APPSHORE/APP/report/report_id) and string(report/selectedcolumns)">
							<tr>
								<td>
									<table class="boxtitle" cellSpacing="0" cellPadding="0" width="100%" border="0" >
										<tr >
											<td align="left" width="100%" ><xsl:value-of select="php:function('lang','With column groups ')"/>:</td>
										</tr>	
									</table>
								</td>
							</tr>
							<tr >				
								<td class="field" align="left" width="55%" valign="top">
									<table border="0" width="100%" cellpadding="1" cellspacing="1" >
										<tr align="center">	
											<td class="label" width="28%" >Name</td>
											<td class="label" width="12%"><xsl:value-of select="php:function('lang','GroupBy')"/></td>
											<td class="label" width="12%"><xsl:value-of select="php:function('lang','Count')"/></td>
											<td class="label" width="12%"><xsl:value-of select="php:function('lang','Sum')"/></td>
											<td class="label" width="12%"><xsl:value-of select="php:function('lang','Average')"/></td>
											<td class="label" width="12%"><xsl:value-of select="php:function('lang','Minimum')"/></td>
											<td class="label" width="12%"><xsl:value-of select="php:function('lang','Maximum')"/></td>
										</tr>															
										<xsl:call-template name="loop_groupby">
											<xsl:with-param name="i">1</xsl:with-param>
											<xsl:with-param name="count" >5</xsl:with-param>
										</xsl:call-template>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table class="boxtitle" cellSpacing="0" cellPadding="0" width="100%" border="0" >
										<tr >
											<td align="left" width="100%" ><xsl:value-of select="php:function('lang','With filters ')"/>:</td>
										</tr>	
									</table>
								</td>
							</tr>
							<tr>
	
								<td class="field" align="left" width="55%" colspan="8" valign="top">
									<table border="0" width="100%" cellpadding="1" cellspacing="1" >
										<tr align="center">	
											<td class="label" width="28%" ><xsl:value-of select="php:function('lang','Column')"/></td>
											<td class="label" width="32%" ><xsl:value-of select="php:function('lang','Operation')"/></td>
											<td class="label" width="40%" ><xsl:value-of select="php:function('lang','Criteria')"/></td>
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
							<!--<td colspan="5">Please check your data and save your Report first!</td>-->
						</xsl:otherwise>
					</xsl:choose>
					</table>
				<!-- operations end -->
			</td>
		</tr>
		<tr>
			<td align="right" class="mandatory_label" width="10%" ><xsl:value-of select="php:function('lang','Data Source')"/>:</td>
			<td class="field" align="left" width="24%">
				<xsl:choose>
					<xsl:when test = "string(/APPSHORE/APP/report/report_id)">
						<input type="hidden" name="table_name" >
							<xsl:attribute name="value">
								<xsl:value-of select="/APPSHORE/APP/report/table_name" />
							</xsl:attribute>
						</input>
						<xsl:for-each select = "tables/tables_item" >
							<xsl:if test=" table_name = /APPSHORE/APP/report/table_name " >
								<xsl:value-of select="label" />
							</xsl:if>
						</xsl:for-each>	
					</xsl:when>
					<xsl:otherwise >
						<select name="table_name"  onchange ='javascript:changedTable()'>
							<option ></option>
							<xsl:for-each select = "tables/tables_item" >
								<xsl:choose>
									<xsl:when test = "table_name = /APPSHORE/APP/report/table_name">
										<option selected="true">
											<xsl:attribute name="value"><xsl:value-of select="table_name" /></xsl:attribute>
											<xsl:value-of select="label"/>
										</option>							
									</xsl:when>
									<xsl:otherwise>
												<option>
													<xsl:attribute name="value"><xsl:value-of select="table_name" /></xsl:attribute>
													<xsl:value-of select="label"/>
												</option>
									</xsl:otherwise>
								</xsl:choose>			
							</xsl:for-each>
						</select>
					</xsl:otherwise>
				</xsl:choose>	
				<xsl:if test="/APPSHORE/APP/error/table_name">
                    <span class="failure">
                        <br/><xsl:value-of select="/APPSHORE/APP/error/table_name" />
                    </span>
				</xsl:if>
			</td>	
		</tr>
		<tr>
			<td align="right" class="mandatory_label" width="10%" ><xsl:value-of select="php:function('lang','Private')"/>:</td>
			<td class="field" align="left" width="23%">
				<input type="checkbox" name="private" >
					<xsl:attribute name="onclick">checkTheBox(this)</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="report/private" /></xsl:attribute>
					<!--	by default is checked in creation mode  -->					
					<xsl:if test="string(/APPSHORE/APP/report/report_id)">
						<xsl:if test="report/private = '1'">
							<xsl:attribute name="checked"/>
						</xsl:if>
					</xsl:if>
					<xsl:if test="not(string(/APPSHORE/APP/report/report_id))">
						<xsl:attribute name="checked"/>
						<xsl:attribute name="value">1</xsl:attribute>
					</xsl:if>
				</input>		
			</td>
		</tr>
		<tr>
			<td align="right" class="mandatory_label" width="10%" ><xsl:value-of select="php:function('lang','Columns')"/>:</td>		
			<td class="field" align="left" width="23%" rowspan="4" >
				<select style='width:180px' size="15" name="column_name" >
					<xsl:for-each select = "report/columns/columns_item" >
						<option>
							<xsl:attribute name="value"><xsl:value-of select="column_name" /></xsl:attribute>
							<xsl:value-of select="label"/>
						</option>
					</xsl:for-each>
				</select>&#160;
				<img class="icon" name="maglass" onclick ='popupIntra("{$baseurl}&amp;op=reports.popup.selectColumns&amp;table_name="+document.report_edit.table_name.value,"Select Columns");'>
					<xsl:attribute name="src"><xsl:value-of select="$api_image_path" />/maglass_16.png</xsl:attribute>
				</img>
				<xsl:if test="/APPSHORE/APP/error/column_name">
                    <span class="failure">
                        <br/><xsl:value-of select="/APPSHORE/APP/error/column_name" />
                    </span>
				</xsl:if>							
			</td>
		</tr>
			
	</table>
	<table border="0" width="100%" cellpadding="0" cellspacing="0">				
		<tr >
			<xsl:choose>
				<xsl:when test=" report/scope=1 ">
					<td >
						<input type="submit" class="formBarButton"  name="key" value="Save" onclick="buildGroupbycolumn();buildFiltercriteria();"/>&#160; 
						<!-- COPY, DELETE, RUN, disabled only in creation mode -->
						<xsl:if test="string(/APPSHORE/APP/report/report_id)">
							<input type="submit" class="formBarButton" name="key" value="Duplicate" />&#160;
							<input class="formBarButton" type="button" value="Delete"  onclick="javascript:confirmDelete('{$baseurl}&amp;op=reports.base.edit&amp;report_id={/APPSHORE/APP/report/report_id}&amp;key=Delete')"/>&#160;
							<input type="button" class="formBarButton" onclick ="popupIntra('{$baseurl}&amp;op=reports.listing.runtab&amp;report_id='+document.report_edit.report_id.value,'Report results');">
								<xsl:attribute name="value">Run Report</xsl:attribute>
							</input>&#160;
						</xsl:if>
						<input type="submit" class="formBarButton" name="key" value="Cancel" />
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td>
						<br/>
						<xsl:if test="string(/APPSHORE/APP/report/report_id)">
							<input type="button" class="formBarButton" onclick ="popupIntra('{$baseurl}&amp;op=reports.listing.runtab&amp;report_id='+document.report_edit.report_id.value, 740, 470, 'Report results');">
								<xsl:attribute name="value">Run Report</xsl:attribute>
							</input>&#160;
						</xsl:if>
					</td>
				</xsl:otherwise>
		</xsl:choose>
		</tr>
	</table>
	</form>	
	
</xsl:template>

</xsl:stylesheet>
