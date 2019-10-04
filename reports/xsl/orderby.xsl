<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<!-- ******************************************************************************************* -->
<xsl:template name="reports_orderby">
<script LANGUAGE="JavaScript" >
<![CDATA[

function buildOrderbyOptions() 
{ 
	document.report_orderby.orderbyoptions.value = "";
	maxlines= eval(document.report_orderby.oby_fromo_lines.value);

    for ( i=1; i <= maxlines ; i++) 
	{
		if (eval('document.report_orderby.obyfrom_o'+i).value.length )
		{ 
			if ( i > 1  )
				document.report_orderby.orderbyoptions.value += '/';
			document.report_orderby.orderbyoptions.value += eval('document.report_orderby.obyfrom_o'+i).value;	
			document.report_orderby.orderbyoptions.value += '+'+eval('document.report_orderby.obyfrom_odir'+i).value;
		}
	}
	
}

function buildOrderbygroupOptions() 
{ 
	document.report_orderby.orderbygroupoptions.value = "";
	maxlines= eval(document.report_orderby.oby_fromg_lines.value);

    for ( i=1; i <= maxlines ; i++) 
	{
		if (eval('document.report_orderby.obyfrom_ghidden'+i).value.length )
		{ 
			if ( i > 1  )
				document.report_orderby.orderbygroupoptions.value += '/';
			document.report_orderby.orderbygroupoptions.value += eval('document.report_orderby.obyfrom_ghidden'+i).value; /*special hidden field */
			document.report_orderby.orderbygroupoptions.value += '+'+eval('document.report_orderby.obyfrom_gdir'+i).value;
		}
	}
	
}

function updateOrderbyColumn(currline) 
{
	buildOrderbyOptions();<!--alert(document.report_orderby.orderbyoptions.value);-->
	buildOrderbygroupOptions();<!--alert(document.report_orderby.orderbygroupoptions.value);-->
	document.report_orderby.subst_key.name='key'; 
	document.report_orderby.subst_key.value='Save';
	return(document.report_orderby.submit());
}
]]>
</script>

	<xsl:call-template name="headerEditForm">
			<xsl:with-param name="testParam"><xsl:value-of select="report/report_id" /></xsl:with-param>
			<xsl:with-param name="labelParam"><xsl:value-of select="report/report_name" /></xsl:with-param>
			<xsl:with-param name="appLabel">Report</xsl:with-param>
			<xsl:with-param name="appName">reports</xsl:with-param>
	</xsl:call-template>

	<form name="report_orderby" method="post">	
		<table  cellSpacing="1" cellPadding="1" border="0" width="100%" valign="top">
			<input type="hidden" name="op" value="reports.base.orderbyedit"/>
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
			<!--** == **-->

			<input type="hidden" name="orderbyoptions" >
				<xsl:attribute name="value"><xsl:value-of select="report/orderbyoptions" /></xsl:attribute>
			</input>
			<input type="hidden" name="orderbygroupoptions" >
				<xsl:attribute name="value"><xsl:value-of select="report/orderbygroupoptions" /></xsl:attribute>
			</input>
			<input type="hidden" name="oby_fromg_lines" >
				<xsl:attribute name="value"><xsl:value-of select="report/oby_fromg_lines" /></xsl:attribute>
			</input>
			<input type="hidden" name="oby_fromo_lines" >
				<xsl:attribute name="value"><xsl:value-of select="report/oby_fromo_lines" /></xsl:attribute>
			</input>

			<!--** == **-->
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
					<tr>
						<td class="label" align="right" width="10%" >Order by <br/>(from groupBys):</td>	
						<td class="field" align="left" width="56%" colspan="3" valign="top">
							<table border="0" width="100%" cellpadding="1" cellspacing="1" >
								<tr align="center">	
									<td class="label" width="15%">Column</td>
									<td class="label" width="20%">Direction</td>
									<td class="label" width="65%"></td>

								</tr>	
								<xsl:call-template name="loop_orderbygroup">
									<xsl:with-param name="i">1</xsl:with-param>
									<xsl:with-param name="count" select="report/groupbylines"></xsl:with-param>
								</xsl:call-template>	
							</table>
						</td>				
					</tr>		
					<tr>
						<td class="label" align="right" width="10%" >
							Order by&#160;:</td>	
						<td class="field" align="left" width="56%" colspan="3" valign="top">
							<table border="0" width="100%" cellpadding="1" cellspacing="1" >
								<tr align="center">	
									<td class="field" width="15%">Column</td>
									<td class="field" width="20%">Direction</td>
									<td class="field" width="65%"></td>

								</tr>	
								<xsl:call-template name="loop_orderby">
									<xsl:with-param name="j">1</xsl:with-param>
									<xsl:with-param name="count" ><xsl:value-of select="report/oby_fromo_lines" /></xsl:with-param>
								</xsl:call-template>	
							</table>
						</td>				
					</tr>
				</xsl:when>
			</xsl:choose>
		</table>

		<table border="0" width="100%" cellpadding="0" cellspacing="0">				
		<tr >
			<xsl:choose>
				<xsl:when test=" report/scope=1 ">
					<td >
						<xsl:choose>
						<xsl:when test="report/report_id and report/selectedcolumns ">
							<input type="submit" class="formBarButton" name="key" value="Save" onclick="javascript:updateOrderbyColumn();"/>&#160;
							<input type="button" class="formBarButton"  onclick ="popupIntra('{$baseurl}&amp;op=reports.listing.runtab&amp;report_id='+document.report_orderby.report_id.value,'Report results');">
								<xsl:attribute name="value">Run Report</xsl:attribute>
							</input>&#160;
							<input type="button" class="formBarButton" name="key" value="Back"  onclick="javascript:window.location.replace('{$baseurl}&amp;op=reports.base.edit&amp;report_id={/APPSHORE/APP/report/report_id}');"/>&#160;
							<input type="submit" class="formBarButton" name="key" value="Cancel" />&#160;
							<input type="submit" class="formBarButton" name="key" value="Reset" />&#160;
							
						</xsl:when>
						</xsl:choose>
					</td>
				</xsl:when>
		</xsl:choose>
		</tr>
	</table>

	</form>
</xsl:template>
<!-- ******************************************************************************************* -->
	<!--these fields are spontaneous from the groupby choice, user can add ASC or DESC-->
<xsl:template name="loop_orderbygroup">
	<xsl:param name="i"/>
	<xsl:param name="count"/>
	<xsl:if test="$i &lt;= $count">
<!--    body of the loop goes here    -->
		<xsl:choose>
			<xsl:when test="report/groupbys/groupbys_item[position()=$i]/groupby = '1'" >
				<tr  align="left">	
					<td >
						<input style="color:#AAAAAA;">	
							<xsl:attribute name="name">obyfrom_g<xsl:value-of select="$i" /></xsl:attribute>
							<xsl:attribute name="readOnly">true</xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="/APPSHORE/APP/report/groupbys/groupbys_item[position()=$i]/label" /></xsl:attribute>	
						</input>
						<input type="hidden">	
							<xsl:attribute name="name">obyfrom_ghidden<xsl:value-of select="$i" /></xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="/APPSHORE/APP/report/groupbys/groupbys_item[position()=$i]/groupby_name" /></xsl:attribute>	
						</input>
					</td>
					<td align="center">
						<select>	
							<xsl:attribute name="name">obyfrom_gdir<xsl:value-of select="$i" /></xsl:attribute>
							<xsl:attribute name="type">submit</xsl:attribute>
							<xsl:attribute name="onchange">updateOrderbyColumn(<xsl:value-of select="$i" />);</xsl:attribute>

							<xsl:choose>
								<xsl:when test=" report/groupbys/groupbys_item[position()=$i]/DESC=1 ">
									<option selected="true" value="DESC">DESC</option>
									<option value="ASC">ASC</option>
								</xsl:when>	
								<xsl:when test=" report/groupbys/groupbys_item[position()=$i]/ASC=1 ">
									<option selected="true" value="ASC">ASC</option>
									<option value="DESC">DESC</option>
								</xsl:when>
								<xsl:otherwise>
									<option value="ASC">ASC</option>
									<option value="DESC">DESC</option>
								</xsl:otherwise>
							</xsl:choose>
						</select>
					</td>
				</tr>
			</xsl:when>
		</xsl:choose>
<!--    end of body of the loop   -->
	</xsl:if>
	<xsl:if test="$i &lt;= $count">
		<xsl:call-template name="loop_orderbygroup">
			<xsl:with-param name="i">
				<!-- Increment index-->
				<xsl:value-of select="$i + 1"/>
			</xsl:with-param>
			<xsl:with-param name="count">
				<xsl:value-of select="$count"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
<!-- ******************************************************************************************* -->
	<!--These fields are chosen for orderby by the user-->
<xsl:template name="loop_orderby">
	<xsl:param name="j"/>
	<xsl:param name="count"/>

	<xsl:if test="$j &lt;= $count">
	<!--    body of the loop goes here    -->
			<tr  align="left">	
				<td >
					<select>	
						<xsl:attribute name="name">obyfrom_o<xsl:value-of select="$j" /></xsl:attribute>
						<xsl:attribute name="type">submit</xsl:attribute>
						<xsl:attribute name="onchange">updateOrderbyColumn(<xsl:value-of select="$j" />);</xsl:attribute>
						<option value=""></option>
						<xsl:for-each select = "report/columns/columns_item" >	
							<xsl:choose>
								<xsl:when test=" (column_name = /APPSHORE/APP/report/orderbys/orderbys_item[position()=$j]/orderby_name) and (orderbyused = '1')">
									<option selected="true">
									<xsl:attribute name="value"><xsl:value-of select="column_name" /></xsl:attribute>
									<xsl:value-of select="label"/>
									</option>	
								</xsl:when>	
								<xsl:otherwise>
									<xsl:if test = " not(orderbyused = '1')">
										<option>
										<xsl:attribute name="value"><xsl:value-of select="column_name" /></xsl:attribute>
										<xsl:value-of select="label"/>
										</option>	
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</select>	
				</td>
				<td align="center">
						<select>	
							<xsl:attribute name="name">obyfrom_odir<xsl:value-of select="$j" /></xsl:attribute>
							<xsl:attribute name="type">submit</xsl:attribute>
						<xsl:attribute name="onchange">updateOrderbyColumn(<xsl:value-of select="$j" />);</xsl:attribute>
								<xsl:choose>
									<xsl:when test= "/APPSHORE/APP/report/orderbys/orderbys_item[position()=$j]/ASC = 1">
										<option selected="true">ASC</option>
										<option value="DESC">DESC</option>
									</xsl:when>	
									<xsl:when test= "/APPSHORE/APP/report/orderbys/orderbys_item[position()=$j]/DESC = 1">
										<option selected="true">DESC</option>
										<option value="ASC">ASC</option>
									</xsl:when>	
									<xsl:otherwise>
										<option selected="true">ASC</option>
										<option value="DESC">DESC</option>
									</xsl:otherwise>
								</xsl:choose>
						</select>
				</td>	
				<td width="30%">
				</td>	
			</tr>
<!--    end of body of the loop   -->
	</xsl:if>

	<xsl:if test="$j &lt;= $count">
		<xsl:call-template name="loop_orderby">
			
			<xsl:with-param name="j">
				<!-- Increment index-->
				<xsl:value-of select="$j + 1"/>
			</xsl:with-param>
			<xsl:with-param name="count">
				<xsl:value-of select="$count"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<!-- ******************************************************************************************* -->
</xsl:stylesheet>
