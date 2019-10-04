<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="data_filter">
<script language="JavaScript" type="text/javascript" src="{$lib_js_path}/popup.js"/>
<script LANGUAGE="JavaScript" >
<![CDATA[

function checkTheBox( Mycheck) 
{
	if ( Mycheck.checked == true )
		Mycheck.value = 1;
	else
		Mycheck.value = 0;
}

function changedTable()
{
document.report_edit.selectedcolumns.value='';
document.report_edit.column_name.length=0;
if (document.report_edit.table_name.value=='') 
	document.report_edit.maglass.type='hidden';
else
	document.report_edit.maglass.type='visible';
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
		<input type="hidden" name="submenu_id" value="data"/>
		<input type="hidden" name="report_id" >
			<xsl:attribute name="value"><xsl:value-of select="report/report_id" /></xsl:attribute>
		</input>
		<input type="hidden" name="selectedcolumns" >
			<xsl:attribute name="value"><xsl:value-of select="report/selectedcolumns" /></xsl:attribute>
		</input>
		<input type="hidden" name="groupbycolumns" >
			<xsl:attribute name="value"><xsl:value-of select="report/groupbycolumns" /></xsl:attribute>
		</input>
		<input type="hidden" name="filtercriterias" >
			<xsl:attribute name="value"><xsl:value-of select="report/filtercriterias" /></xsl:attribute>
		</input>
		<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr>
			<td align="right" class="mandatory_label" width="10%" ><xsl:value-of select="php:function('lang','Report Name')"/>:</td>
			<td  class="field" align="left" width="24%">
				<input type="text" size="30" name="report_name" >
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
				<table border="0" width="100%" cellpadding="1" cellspacing="1">
					<row>
						<p>This is the <span style="font-weight: bold;">Beta version of AppShore reports</span>, an application which enables you to create and customize dynamic reports on your data from AppShore's applications.</p>
					</row>
					<row>
						<p>	To create a <span style="font-style: italic;">New report</span>, please:</p>
							<ul>
								<li>Give a name to your report</li>
								<li>Specify the data source on which your report will apply</li>
								<li>Set an owner name (By default your login name). <span style="color: rgb(255, 0, 0);">Attention: keep private box checked if you don't want other users from your company to be able to use your report!</span></li>
								<li>Choose from the "select columns" popup, the list of columns that will be used on your report.</li>
							</ul>
					</row>
					<row>
						<p>	After saving your report, you will be able to access:</p>
						<ul>The Operation panel
							<ul>
								<li>to group your data, specify summerize operations</li>
								<li>to give selection criterias</li>
							</ul>
							The Display panel
							<ul>
								<li>to set some display options</li>
							</ul>
						</ul>
					</row>
					<row>Enjoy! With AppShore there's still more to come !
					</row>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right" class="mandatory_label" width="10%" ><xsl:value-of select="php:function('lang','Data Source')"/>:</td>
			<td class="field" align="left" width="24%">
				<select name="table_name"  onchange ='changedTable();'>
					<xsl:choose>
						<xsl:when test="string(/APPSHORE/APP/report/report_id)">
<!-- 							<xsl:attribute name="disabled">true</xsl:attribute> -->
						</xsl:when>
					</xsl:choose>
					<option value=""/>
					<xsl:for-each select = "tables/tables_item" >
						<option value="{table_name}">
							<xsl:if test = "table_name = /APPSHORE/APP/report/table_name">
								<xsl:attribute name="selected" value="true"/>
							</xsl:if>
							<xsl:otherwise>
							<xsl:value-of select="label"/>
						</option>
					</xsl:for-each>
				</select>
				<xsl:if test="/APPSHORE/APP/error/table_name">
                    <span class="failure">
                        <br/><xsl:value-of select="/APPSHORE/APP/error/table_name" />
                    </span>
				</xsl:if>
			</td>	
		</tr>
		<tr>
			<td align="right" class="mandatory_label" width="10%" ><xsl:value-of select="php:function('lang','Owner Name')"/>:</td>
			<td class="field" align="left" width="23%">
				<select name="user_id"  >
					<!--<option value=""></option>		by default is the current user--> 
					<xsl:choose>
						<xsl:when test="not(string(/APPSHORE/APP/report/report_id))">
							<xsl:for-each select = "users/users_item" >
								<xsl:choose>
									<xsl:when test="user_id = /APPSHORE/APP/report/current_user_id">
										<option selected="true">
											<xsl:attribute name="value"><xsl:value-of select="user_id" /></xsl:attribute>
											<xsl:value-of select="user_name"/>
										</option>
									</xsl:when>
									<xsl:otherwise>
										<option>
											<xsl:attribute name="value"><xsl:value-of select="user_id" /></xsl:attribute>
											<xsl:value-of select="user_name"/>
										</option>		
									</xsl:otherwise>
								</xsl:choose>			
							</xsl:for-each>
						</xsl:when>					
						<xsl:otherwise>
							<xsl:for-each select = "users/users_item" >
								<xsl:choose>
									<xsl:when test="user_id = /APPSHORE/APP/report/user_id">
										<option selected="true">
											<xsl:attribute name="value"><xsl:value-of select="user_id" /></xsl:attribute>
											<xsl:value-of select="user_name"/>
										</option>
									</xsl:when>
									<xsl:otherwise>
										<option>
											<xsl:attribute name="value"><xsl:value-of select="user_id" /></xsl:attribute>
											<xsl:value-of select="user_name"/>
										</option>		
									</xsl:otherwise>
								</xsl:choose>			
							</xsl:for-each>
						</xsl:otherwise>
					</xsl:choose>
					
				</select>Private:
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
				<select style='width:180px' size="15" name="column_name"  >
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
							<input type="submit" class="formBarButton" name="key" value="Copy" />&#160;
							<input class="formBarButton" type="button" value="Delete"  onclick="javascript:confirmDelete('{$baseurl}&amp;op=reports.base.edit&amp;report_id={/APPSHORE/APP/report/report_id}&amp;key=Delete')"/>&#160;
							<input type="button"  onclick ="popupIntra('{$baseurl}&amp;op=reports.listing.runtab&amp;report_id='+document.report_edit.report_id.value,'Report results');">
								<xsl:attribute name="value">Run Report</xsl:attribute>
							</input>&#160;
						</xsl:if>
						<input type="submit" class="formBarButton" name="key" value="Cancel" />
					</td>
					<xsl:if test="string(/APPSHORE/APP/report/report_id)">
						<td>
							<input type="submit" class="formBarButton" name="key" value="Next" />&#160; 
						</td>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<td>
						<br/>
						<xsl:if test="string(/APPSHORE/APP/report/report_id)">
							<input type="button"  onclick ="popupIntra('{$baseurl}&amp;op=reports.listing.runtab&amp;report_id='+document.report_edit.report_id.value,'Report results');">
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
