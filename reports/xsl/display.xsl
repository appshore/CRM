<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="display_filter">
<script language="JavaScript" type="text/javascript" src="{$lib_js_path}/popup.js"/>
<script LANGUAGE="JavaScript" >
<![CDATA[
function checkTheBox( Mycheck) 
{
	if ( Mycheck.checked == true )
		{
		Mycheck.value = 1;
		}
	else
		{
		Mycheck.value = 0;
		}
}

function confirmDelete(href) 
{
	if (confirm('Do you really want to delete this report?')) {
	window.location.replace(href);
	} 
}
]]>
</script>
	<form name="report_edit" method="post">
		
			<input type="hidden" name="op" value="reports.base.edit"/>
			<input type="hidden" name="submenu_id" value="display"/>
			<input type="hidden" name="display_id" >
				<xsl:attribute name="value"><xsl:value-of select="report/display_id" /></xsl:attribute>
			</input>
			<input type="hidden" name="report_user" >
				<xsl:attribute name="value"><xsl:value-of select="report/report_user" /></xsl:attribute>
			</input>
			<input type="hidden" name="report_table" >
				<xsl:attribute name="value"><xsl:value-of select="report/table_name" /></xsl:attribute>
			</input>
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
			<table  cellSpacing="1" cellPadding="1" border="0" width="100%" valign="top" colspan="8">	
				<xsl:choose>
					<xsl:when test="report/report_id and report/selectedcolumns">
						<tr>
							<td class="label" align="left" width="15%">Document</td>
							<td  class="field" align="left" width="24%"></td>
							<td class="field" align="left" rowspan="6" >
								<table  cellSpacing="1" cellPadding="1" border="0" width="100%" valign="top" colspan="8">
									<tr>
										<td><br/>
											<ul>
												<!--<li>Document Background: The color in the background.</li>-->
												<li>Document Align: alignment (left,center or right).</li>
												<li>Document Header: if you need a header (logo, print icon,title)</li>
												<li>Document Print: Check if you want the print icon in header</li>
												<li>Document Grand Total: A Grand Total will be displayed in the footer of document</li>
											</ul>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<!--<tr>
							<td class="label" align="right" width="15%">Background:</td>
							<td  class="field" align="left" width="24%">
								<select name="background_color"  >
									<option></option>
									<xsl:for-each select = "report/bgcolor/bgcolor_item" >
										<xsl:choose>
											<xsl:when test="type = /APPSHORE/APP/report/background_color">
												<option selected="true">
													<xsl:attribute name="value"><xsl:value-of select="type" /></xsl:attribute>
													<xsl:value-of select="label" />
												</option>
											</xsl:when>
											<xsl:otherwise>
												<option>
													<xsl:attribute name="value"><xsl:value-of select="type" /></xsl:attribute>
													<xsl:value-of select="label" />
												</option>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:for-each>
								</select>
							</td>
						</tr>-->
						<tr>
							<td class="label" align="right" width="15%" onmouseover='contextualHelp("alignment (left,center or right)");' onmouseout='return nd(500);'>
								<xsl:value-of select="php:function('lang','Align')"/>:
							</td>
							<td  class="field" align="left" width="24%">
								<select name="document_align">
									<option></option>
									<xsl:for-each select = "report/align/align_item" >
										<xsl:choose>
											<xsl:when test="type = /APPSHORE/APP/report/document_align">
												<option selected="true">
													<xsl:attribute name="value"><xsl:value-of select="type" /></xsl:attribute>
													<xsl:value-of select="label" />
												</option>
											</xsl:when>
											<xsl:otherwise>
												<option>
													<xsl:attribute name="value"><xsl:value-of select="type" /></xsl:attribute>
													<xsl:value-of select="label" />
												</option>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:for-each>
								</select>
							</td>
						</tr>
						<tr>
							<td class="label" align="right" width="15%">
								<a onmouseover='contextualHelp("if you need a header on document(logo, print icon,title)");' onmouseout='return nd(500);'>Header:</a>
							</td>
							<td  class="field" align="left" width="24%">
								<input type="checkbox" >
									<xsl:attribute name="name">document_header</xsl:attribute>
									<xsl:attribute name="onclick">checkTheBox(this)</xsl:attribute>
									<xsl:attribute name="value"><xsl:value-of select="report/document_header" /></xsl:attribute>
									<xsl:if test="report/document_header = '1'">
										<xsl:attribute name="checked"/>
									</xsl:if>
								</input>
							</td>
						</tr>
						<tr>
							<td class="label" align="right" width="15%">
								<a onmouseover='contextualHelp("Check if you want the print icon in document header");' onmouseout='return nd(500);'>Print icon:</a>
							</td>
							<td  class="field" align="left" width="24%">
								<input type="checkbox" >
									<xsl:attribute name="name">print</xsl:attribute>
									<xsl:attribute name="onclick">checkTheBox(this)</xsl:attribute>
									<xsl:attribute name="value"><xsl:value-of select="report/print" /></xsl:attribute>
									<xsl:if test="report/print = '1'">
										<xsl:attribute name="checked"/>
									</xsl:if>
								</input>
							</td>
						</tr>

						<tr>
							<td class="label" align="right" width="15%">
								<a onmouseover='contextualHelp("If checked, a Grand Total will be displayed in the footer of document");' onmouseout='return nd(500);' oncontextmenu='return false;'>Grand Total:</a>
							</td>
							<td  class="field" align="left" width="24%">
								<input type="checkbox" >
									<xsl:attribute name="name">document_footer_gtotal</xsl:attribute>
									<xsl:attribute name="onclick">checkTheBox(this)</xsl:attribute>
									<xsl:attribute name="value"><xsl:value-of select="report/document_footer_gtotal" /></xsl:attribute>
									<xsl:if test="report/document_footer_gtotal = '1'">
										<xsl:attribute name="checked"/>
									</xsl:if>
								</input>
							</td>
						</tr>
						<xsl:if test="/APPSHORE/APP/phpreports_trace_enabled = 'true' ">
							<tr>
								<td class="label" align="right" width="10%">Trace:</td>
								<td  class="field" align="left" width="24%">
									<input type="checkbox" >
										<xsl:attribute name="name">trace</xsl:attribute>
										<xsl:attribute name="onclick">checkTheBox(this)</xsl:attribute>
										<xsl:attribute name="value"><xsl:value-of select="report/trace" /></xsl:attribute>
										<xsl:if test="report/trace = '1'">
											<xsl:attribute name="checked"/>
										</xsl:if>
									</input>
								</td>
							</tr>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<td >Please check your data and save your Report first!</td>
					</xsl:otherwise>
				</xsl:choose>
			</table>

			<table  cellSpacing="1" cellPadding="1" border="0" width="100%" valign="top" colspan="8">	
				<xsl:choose>
					<xsl:when test="report/report_id and report/selectedcolumns">

						<tr>
							<td class="label" align="left" width="15%">Page</td>
							<td  class="field" align="left" width="24%"></td>
							<td class="field" align="left" rowspan="6" >
								<table  cellSpacing="1" cellPadding="1" border="0" width="100%" valign="top" colspan="8">
									<tr>
										<td><br/>
											<ul>
												<li>Page Size: The page size in rows (ex:30).</li>
												<li>Page Width: The page width in pixels.(ex:600)</li>
												<li>Page Header: If you want the columns labels as headings on each page.</li>
												<li>Page Break: If you need a page break after the 1st group breaks, check the box.</li>
											</ul>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td class="label" align="right" width="15%">
								<a onmouseover='contextualHelp("The page size in rows (ex:30)");' onmouseout='return nd(500);' oncontextmenu='return false;'>Size:</a>
							</td>
							<td  class="field" align="left" width="24%">
								<input type="text" size="10" name="page_size" >
									<xsl:attribute name="value">
										<xsl:value-of select="report/page_size" />
									</xsl:attribute>
								</input>
							</td>
						</tr>
						<tr>
							<td class="label" align="right" width="15%">
								<a onmouseover='contextualHelp("The page width in pixels.(ex:600)");' onmouseout='return nd(500);' oncontextmenu='return false;'>Width:</a>
							</td>
							<td  class="field" align="left" width="24%">
								<input type="text" size="10" name="page_width" >
									<xsl:attribute name="value">
										<xsl:value-of select="report/page_width" />
									</xsl:attribute>
								</input>
							</td>
						</tr>
						<tr>
							<td class="label" align="right" width="15%">
								<a onmouseover='contextualHelp("Check if you want the columns labels as headings over each page");' onmouseout='return nd(500);' oncontextmenu='return false;'>Header:</a>
							</td>
							<td  class="field" align="left" width="24%">
								<input type="checkbox" >
									<xsl:attribute name="name">page_header</xsl:attribute>
									<xsl:attribute name="onclick">checkTheBox(this)</xsl:attribute>
									<xsl:attribute name="value"><xsl:value-of select="report/page_header" /></xsl:attribute>
									<xsl:if test="report/page_header = '1'">
										<xsl:attribute name="checked"/>
									</xsl:if>
								</input>
							</td>
						</tr>
						<tr>
							<td class="label" align="right" width="15%">
								<a onmouseover='contextualHelp("Check if you need a page break after the first group breaks");' onmouseout='return nd(500);' oncontextmenu='return false;'>Break:</a>
							</td>
							<td  class="field" align="left" width="24%">
								<input type="checkbox" >
									<xsl:attribute name="name">page_break</xsl:attribute>
									<xsl:attribute name="onclick">checkTheBox(this)</xsl:attribute>
									<xsl:attribute name="value"><xsl:value-of select="report/page_break" /></xsl:attribute>
									<xsl:if test="report/page_break = '1'">
										<xsl:attribute name="checked"/>
									</xsl:if>
								</input>
							</td>
						</tr>

					</xsl:when>
					<xsl:otherwise>
						<td >Please check your data and save your Report first!</td>
					</xsl:otherwise>
				</xsl:choose>
			</table>
			
		<table border="0" width="100%" cellpadding="0" cellspacing="0">	
			<tr >
				<xsl:choose>
					<xsl:when test=" report/scope=1 ">
						<td >
							<xsl:choose>
							<xsl:when test="report/selectedcolumns and report/report_id">
								<input type="submit" class="formBarButton" name="key" value="Save"/>&#160; 
								<input type="submit" class="formBarButton" name="key" value="Copy" />&#160;
								<input class="formBarButton" type="button" value="Delete"  onclick="javascript:confirmDelete('{$baseurl}&amp;op=reports.base.edit&amp;report_id={/APPSHORE/APP/report/report_id}&amp;key=Delete')"/>&#160; 
								<input type="button"  onclick ="popupIntra('{$baseurl}&amp;op=reports.listing.runtab&amp;report_id='+document.report_edit.report_id.value,'Report results');">
									<xsl:attribute name="value">Run Report</xsl:attribute>
								</input>&#160;
								<input type="submit" class="formBarButton"  name="key" value="Cancel" />
							</xsl:when>
							<xsl:otherwise>
							</xsl:otherwise>
							</xsl:choose>
						</td>
						<td>
							<input type="submit" class="formBarButton" name="key" value="Previous" />&#160; 
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td>
						<br/>
						<xsl:if test="report/selectedcolumns and report/report_id">
							<input type="button"  onclick ="popupReport('{$baseurl}&amp;op=reports.listing.runtab&amp;report_id='+document.report_edit.report_id.value,'Report results');">
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
