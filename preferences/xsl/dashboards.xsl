<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP[action/dashboards]">
<script LANGUAGE="JavaScript" >	
<![CDATA[
	
	
	function passDashboardsList( l2, MyList) 
	{ 
		MyList.value.length = 0;	
	    for ( i=0; i < l2.length ; i++) 
		{
			if ( i > 0 && MyList.value.length )	
				MyList.value += ',';	
				
			MyList.value += l2.options[i].value;			
		}
	}
	

	function copyAll( list1, list2) 
	{
	    list1len = list1.length ;
	    for ( i=0; i<list1len ; i++)
		{
			list2len = list2.length;
			already = false;
			
			for ( j=0; j<list2len ; j++)
				if (list2.options[j].text == list1.options[i].text )
					already = true;
					
			if (already == false)
			{
	            list2.options[list2len]= new Option(list1.options[i].text, list1.options[i].value);
			}
	    }
	
	}
	
	function copySelected( list1, list2) 
	{
	    list1len = list1.length ;
	    for ( i=0; i<list1len ; i++)
		{
	        if (list1.options[i].selected == true ) 
			{
	            list2len = list2.length;
				already = false;
				for ( j=0; j<list2len ; j++)
					if (list2.options[j].text == list1.options[i].text )
						already = true;
				if (already == false)
				{
		            list2.options[list2len]= new Option(list1.options[i].text, list1.options[i].value);
				}
	        }
	    }
	
	}
	
	function removeSelected(list) 
	{
	    for ( i=(list.length-1); i>=0; i--) 
	       if (list.options[i].selected == true ) 
	          list.options[i] = null;
	}
	
	function removeAll(list) 
	{
	    for ( i=(list.length-1); i>=0; i--) 
		    list.options[i] = null;
	}
	
	function moveUp(list) 
	{
		listlen = list.length ;
	    for ( i=1; i<listlen ; i++) 
	    	if (list.options[i].selected == true && list.options[i-1].selected == false)
			{ 
				swaptext = list.options[i-1].text ;
				swapvalue = list.options[i-1].value ;
				list.options[i-1].text = list.options[i].text;
				list.options[i-1].value = list.options[i].value;
				list.options[i].text = swaptext;
				list.options[i].value = swapvalue;
				list.options[i-1].selected = true;
				list.options[i].selected = false;
			}
	}
	
	function moveDown(list) 
	{
		listlen = list.length ;
	    for ( i=listlen-2; i>=0 ; i--) 
	    	if (list.options[i].selected == true && list.options[i+1].selected == false)
			{ 
				swaptext = list.options[i].text ;
				swapvalue = list.options[i].value ;
				list.options[i].text = list.options[i+1].text;
				list.options[i].value = list.options[i+1].value;
				list.options[i+1].text = swaptext;
				list.options[i+1].value = swapvalue;
				list.options[i+1].selected = true;
				list.options[i].selected = false;
			}
	}
	
	function moveTop(list) 
	{
		listlen = list.length ;
	    for ( i=1; i<listlen ; i++)
			{ 
		    	if (list.options[i].selected == true )
				{
					j=0;
					while ( j < listlen)
					{ 
						if (list.options[j].selected == false )
						{
							swaptext = list.options[i].text ;
							swapvalue = list.options[i].value ;
							for ( k = i-1 ; k >= j ; k-- )
							{
								list.options[k+1].text = list.options[k].text;
								list.options[k+1].value = list.options[k].value;
							}
							list.options[j].text = swaptext;
							list.options[j].value = swapvalue;
							list.options[j].selected = true;
							list.options[i].selected = false;
							break;
						}
						else
							j++;
					}
				}
			}
		
	}
	
	function moveBottom(list) 
	{
		listlen = list.length ;
	    for ( i=listlen-2; i>=0 ; i--)
			{ 
		    	if (list.options[i].selected == true )
				{
					j= listlen-1;
					while ( j >= 0)
					{ 
						if (list.options[j].selected == false )
						{
							swaptext = list.options[i].text ;
							swapvalue = list.options[i].value ;
							for ( k = i+1 ; k <= j ; k++ )
							{
								list.options[k-1].text = list.options[k].text;
								list.options[k-1].value = list.options[k].value;
							}
							list.options[j].text = swaptext;
							list.options[j].value = swapvalue;
							list.options[j].selected = true;
							list.options[i].selected = false;
							break;
						}
						else
							j--;
					}
				}
			}
	}	
	
	]]>
	</script>
    <table height="100%" width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
			<td class="left_panel" id="left_panel" style="display:{/APPSHORE/API/cookie/left_panel}">
			    <xsl:call-template name="verticalMenus">		    
					<xsl:with-param name="appName">preferences</xsl:with-param>
					<xsl:with-param name="appLabel">Preferences</xsl:with-param>
				</xsl:call-template>	
			</td>
            <td id="right_panel" class="right_panel">
				<xsl:choose>
					<xsl:when test="action/dashboards = 'search'">
				    	<xsl:call-template name="dashboards_search"/>
				    	<xsl:call-template name="dashboards_list"/>
					</xsl:when>	
					<xsl:when test="action/dashboards = 'view'">
				    	<xsl:call-template name="dashboard_view"/>
					</xsl:when>	
					<xsl:when test="action/dashboards = 'edit'">
				    	<xsl:call-template name="dashboard_edit"/>
					</xsl:when>	
					<xsl:when test="action/dashboards = 'activatedashboards'">
				    	<xsl:call-template name="activateDashboards"/>
					</xsl:when>	
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>


<xsl:template name="dashboards_search">

	<form name="dashboard_search" method="post">
	<input type="hidden" name="op" value="preferences.dashboards.search"/>			
    <table class="boxtitle" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td >
				Search dashboards
			</td>
		</tr>
	</table>
	<table cellSpacing="1" cellPadding="1" border="0" width="100%" valign="top">
		<tr  width="100%">
			<td width="30%">dashboard Name</td>
			<td >dashboard Status</td>
		</tr>
		<tr >
			<td >
				<input name="dashboard_name" >
					<xsl:attribute name="value">
						<xsl:value-of select="/APPSHORE/APP/recordset/dashboard_name" />
					</xsl:attribute>
				</input>
			</td>
			<td >
				<select name="dashboard_status" >
							<option>
							</option>
					<xsl:choose>
						<xsl:when test="/APPSHORE/APP/recordset/dashboard_status = 'A'">
							<option selected ="true" value="A">
								Activated
							</option>
							<option value="D">
								Deactivated
							</option>
						</xsl:when>
						<xsl:when test="/APPSHORE/APP/recordset/dashboard_status = 'D'">
							<option value="A">
								Activated
							</option>
							<option selected ="true" value="D">
								Deactivated
							</option>
						</xsl:when>
						<xsl:otherwise>
							<option value="A">
								Activated
							</option>
							<option value="D">
								Deactivated
							</option>
						</xsl:otherwise>
					</xsl:choose>				
				</select>
			</td>			
		</tr>
		<tr>
			<td colspan="6">
				<input type="submit"  class="formBarButton" name="key" value="Search" />&#160; 
				<input type="submit"  class="formBarButton" name="key" value="Clear" />&#160;
			</td>
		</tr>
	</table>
	</form>	
</xsl:template>


<xsl:template name="dashboards_list">

	<form name="dashboard_listing" method="post" >
	<input type="hidden" name="op" value="preferences.dashboards.search"/>
	<xsl:for-each select = "recordset/node()">	
		<xsl:if test="name()">	
			<input type="hidden" name="{name()}" value="{node()}" />
		</xsl:if>
	</xsl:for-each>	
			
    <table class="boxtitle" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td >
				dashboards 
			</td>
			<td align="right">
				<xsl:choose>
					<xsl:when test="recordset/countMax = 0">
						No dashboards
					</xsl:when>
					<xsl:otherwise>								
						Dashboards <xsl:value-of select="recordset/currentVal+1" /> to <xsl:value-of select="recordset/first" /> of <xsl:value-of select="recordset/countMax" />					
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
	</table>
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr class="label" >
			<td>
				<a href="javascript: orderby( document.dashboard_listing, 'dashboard_name');" >Name</a>
			</td>
			<td>
				<a href="javascript: orderby( document.dashboard_listing, 'sequence');" >Sequence</a>
			</td>			
			<td >
				<a href="javascript: orderby( document.dashboard_listing, 'dashboard_status');">Status</a>
			</td>
		</tr>
		<xsl:for-each select = "dashboards/dashboards_item">
			<tr class="unselectedtext" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
			
				<td width="30%">
					<a href="{$baseurl}&amp;op=preferences.dashboards.view&amp;dashboard_id={dashboard_id}">
						<xsl:value-of select="dashboard_name"/>
					</a>
				</td>
				<td align="center" width="10%">
					<xsl:choose> 
						<xsl:when test="sequence = '999'">
							-
						</xsl:when>
						<xsl:otherwise>								
							<xsl:value-of select="sequence"/>
						</xsl:otherwise>
					</xsl:choose>					
				</td>
				<td width="10%">
					<xsl:choose> 
						<xsl:when test="dashboard_status = 'A'">
							Activated
						</xsl:when>
						<xsl:otherwise>								
							Deactivated
						</xsl:otherwise>
					</xsl:choose>	
				</td>
			</tr>	
		</xsl:for-each>
		</table>
		<table>
			<tr>
				<td align="left" >
					<input type="submit"  class="formBarButton" name="key" value="First"  />&#160; 
					<input type="submit"  class="formBarButton" name="key" value="Previous" />&#160; 
					<input type="submit"  class="formBarButton" name="key" value="Next" />&#160; 
					<input type="submit"  class="formBarButton" name="key" value="Last" />
				</td>
			</tr>
		</table>
	</form>
</xsl:template>

<xsl:template name="dashboard_view">

	<form name="dashboard_view" method="post" >
		<input type="hidden" name="op" value="preferences.dashboards.view"/>
		<input type="hidden" name="dashboard_id" >
			<xsl:attribute name="value"><xsl:value-of select="dashboard/dashboard_id" /></xsl:attribute>
		</input>

    <table class="boxtitle" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td>
				View &#032;<b><xsl:value-of select="dashboard/dashboard_name"/></b>
			</td>
		</tr>
	</table>
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr>
			<td class="label" align="right" width="20%" >Name:</td>
			<td align="left" class="field" width="30%" >
				<xsl:value-of select="dashboard/dashboard_name"/>
			</td>
			<td class="label" align="right" width="20%" >Status:</td>			
			<td align="left" class="field"  width="30%" >
				<xsl:choose> 
					<xsl:when test="dashboard/dashboard_status = 'A'">
						Activated
					</xsl:when>
					<xsl:otherwise>								
						Deactivated
					</xsl:otherwise>
				</xsl:choose>				
			</td>			
		</tr>		
	</table>
	<table border="0" width="100%" cellpadding="0" cellspacing="0">				
		<tr align="left">
			<td >
				<input type="submit"  class="formBarButton" name="key" value="Edit" />&#160; 
				<input type="submit"  class="formBarButton" name="key" value="Print" /> 
			</td>
		</tr>
	</table>
	</form>	
</xsl:template>

	
<xsl:template name="dashboard_edit">
	<form name="dashboard_edit" method="post" >
		<input type="hidden" name="op" value="preferences.dashboards.edit"/>
		<input type="hidden" name="dashboard_id" >
			<xsl:attribute name="value"><xsl:value-of select="dashboard/dashboard_id" /></xsl:attribute>
		</input>
		<input type="hidden" name="theme_id" >
			<xsl:attribute name="value"><xsl:value-of select="dashboard/theme_id" /></xsl:attribute>
		</input>		
		<input type="hidden" name="colnarrow1"/>
		<input type="hidden" name="colnarrow2"/>
		<input type="hidden" name="colwide1"/>
		<input type="hidden" name="narrow1">
			<xsl:attribute name="value"><xsl:value-of select="dashboard/narrow1" /></xsl:attribute>
		</input>		
		<input type="hidden" name="narrow2">
			<xsl:attribute name="value"><xsl:value-of select="dashboard/narrow2" /></xsl:attribute>
		</input>		
		<input type="hidden" name="wide1">
			<xsl:attribute name="value"><xsl:value-of select="dashboard/wide1" /></xsl:attribute>
		</input>				
    <table class="boxtitle" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td >
				<xsl:choose>
					<xsl:when test="dashboard/dashboard_id">
						Edit &#032;<b><xsl:value-of select="dashboard/dashboard_name" /></b>
					</xsl:when>
					<xsl:otherwise>
						New dashboard
					</xsl:otherwise>					
				</xsl:choose>	
			</td>
		</tr>
	</table>
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr>
			<td class="mandatory_label" align="right" width="20%" >Name:</td>
			<td  class="field" align="left" width="30%" >
				<input type="text" size="20" name="dashboard_name" >
					<xsl:attribute name="value">
						<xsl:value-of select="dashboard/dashboard_name" />
					</xsl:attribute>
				</input>
				<xsl:if test="/APPSHORE/APP/error/dashboard_name">
                    <span class="failure">
                        <br/><xsl:value-of select="/APPSHORE/APP/error/dashboard_name" />
                    </span>
                </xsl:if>					
			</td>				
			<td class="label" align="right" width="20%" ></td>
			<td  class="field" align="left" width="30%" >
			</td>
		</tr>		
	</table>
	<table cellSpacing="1" cellPadding="1" border="0" width="100%" >
		<tr class="field" width="100%" >
			<xsl:choose>
				<xsl:when test="dashboard/dashboard_id">			
					<xsl:for-each select = "dashboard/columns/columns_item" >
						<xsl:choose>
							<xsl:when test="column_name = 'N1'">
								<td style='width:25%'>
									<xsl:call-template name="columnNarrow1">
									</xsl:call-template>
								</td>
							</xsl:when>
							<xsl:when test="column_name = 'W1'">
								<td style='width:100%'>						
									<xsl:call-template name="columnWide1"/>						
								</td>
							</xsl:when>						
							<xsl:when test="column_name = 'N2'">
								<td style='width:25%'>
									<xsl:call-template name="columnNarrow2"/>						
								</td>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<td style='width:25%'>
						<xsl:call-template name="columnNarrow1">
						</xsl:call-template>
					</td>
					<td style='width:100%'>						
						<xsl:call-template name="columnWide1"/>						
					</td>			
					<td style='width:25%'>
						<xsl:call-template name="columnNarrow2"/>						
					</td>
				</xsl:otherwise>
			</xsl:choose>
		</tr>	
	</table>	
	<table cellSpacing="1" cellPadding="1" border="0" width="100%" >
		<tr class="field" width="100%">
			<td>
				<xsl:call-template name="NarrowAppsChooser">
				</xsl:call-template>
			</td>
			<td>
				<xsl:call-template name="WideAppsChooser">
				</xsl:call-template>
			</td>
		</tr>
	
	</table>	
	<table border="0" width="100%" cellpadding="0" cellspacing="0">
		<tr >
			<td >
				<input type='submit' class="formBarButton" onclick='passDashboardsList( selectNarrow1, colnarrow1);passDashboardsList( selectNarrow2, colnarrow2);passDashboardsList( selectWide1, colwide1);' name='key' value='Save' />&#160;
				<xsl:if test="dashboard/dashboard_id">
					<input type='submit' class="formBarButton" onclick='dashboard_edit.op.value="dashboards.base.start"' value='Cancel' />
				</xsl:if>
			</td>
		</tr>
	</table>
	</form>	
</xsl:template>

<xsl:template name='WideAppsChooser'>
	<table width="100%">
		<tr class="label" align="center">
			<td colspan="2">
				Select applications for Wide Column
			</td>
		</tr>	
		<tr width="100%" align="center">
			<td >
				<select size="7" name="WideChooser" style='width:270px' multiple="true" >
					<xsl:for-each select = "dashboard/apps/apps_item[app_width = 'W']" >
						<option>
							<xsl:attribute name="value"><xsl:value-of select="dashlet_name" /></xsl:attribute>
							<xsl:value-of select="app_label" />
						</option>
					</xsl:for-each>
				</select>
			</td>
			<td >
				<input type='button'  class="formBarButton" style='width:120px' onclick='copySelected( WideChooser, selectWide1);removeSelected( WideChooser);' value='Wide Column' /><br/>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name='NarrowAppsChooser'>
	<table width="100%">
		<tr class="label" align="center">
			<td colspan="2">
				Select applications for Narrow Columns
			</td>
		</tr>	
		<tr width="100%" align="center">
			<td >
				<select size="7" name="NarrowChooser" style='width:270px' multiple="true" >
					<xsl:for-each select = "dashboard/apps/apps_item[app_width = 'N']" >
						<option>
							<xsl:attribute name="value"><xsl:value-of select="dashlet_name" /></xsl:attribute>
							<xsl:value-of select="app_label" />
						</option>
					</xsl:for-each>
				</select>
			</td>
			<td >
				<input type='button'  class="formBarButton" style='width:120px' onclick='copySelected( NarrowChooser, selectNarrow1);removeSelected( NarrowChooser);' value='Column 1' /><br/>
				<input type='button'  class="formBarButton" style='width:120px' onclick='copySelected( NarrowChooser, selectNarrow2);removeSelected( NarrowChooser);' value='Column 2' /><br/>
			</td>
		</tr>
	</table>
</xsl:template>


<xsl:template name='columnNarrow1'>
	<table width="100%">
		<tr class="label" align="center">
			<td colspan="2">
				<input type="checkbox" name="checkN1" title='Check to select'>
					<xsl:attribute name="onclick">
						checkTheBox(this);
						if (!this.checked) 
							document.dashboard_edit.narrow1.value=0; 
						else 
							document.dashboard_edit.narrow1.value=1;
					</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="/APPSHORE/APP/dashboard/narrow1" /></xsl:attribute>
					<xsl:if test="/APPSHORE/APP/dashboard/narrow1 > '0'">
						<xsl:attribute name="checked"/>
					</xsl:if>
				</input>&#160;Narrow Column 1
			</td>	
		</tr>	
		<tr width="100%" align="center">
			<td >
				<select size="6" name="selectNarrow1" style='width:170px' multiple="true" >
					<xsl:for-each select = "boxes/boxes_item" >
						<option>
							<xsl:attribute name="value"><xsl:value-of select="dashlet_name" /></xsl:attribute>
							<xsl:value-of select="app_label" />
						</option>
					</xsl:for-each>
				</select>
			</td>
			<td >
				<input type='button'  class="formBarButton" style='width:50px' onclick='moveUp(selectNarrow1);' value='Up' /><br/>
				<input type='button'  class="formBarButton" style='width:50px' onclick='moveDown(selectNarrow1);' value='Down' /><br/>
				<input type='button'  class="formBarButton" style='width:50px' title='Move to narrow column 2' onclick='copySelected( selectNarrow1, selectNarrow2);removeSelected(selectNarrow1);' value='Swap' /><br/>
				<input type='button'  class="formBarButton" style='width:50px' title='Remove selected' onclick='copySelected( selectNarrow1, NarrowChooser);removeSelected( selectNarrow1);' value='X' /><br/> 				
			</td>
		</tr>
		<tr class="field" width="100%" align="center">
			<td >		
				<xsl:if test="/APPSHORE/APP/dashboard/narrow1 = '2'"> 
					<input type='submit'  class="formBarButton" style='width:50px' title='Move column to the left' onclick='document.dashboard_edit.narrow1.value=1;document.dashboard_edit.wide1.value=2;' value='&#60;'  name='key'/>&#160;
				</xsl:if>
			</td>
		</tr>		
	</table>
</xsl:template>


<xsl:template name='columnNarrow2'>
	<table width="100%">
		<tr class="label" align="center">
			<td colspan="2">
				<input type="checkbox" name="checkN2" title='Check to select'>
					<xsl:attribute name="onclick">
						checkTheBox(this);
						if (!this.checked) 
							document.dashboard_edit.narrow2.value=0; 
						else 
						document.dashboard_edit.narrow2.value=3;
					</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="/APPSHORE/APP/dashboard/narrow2" /></xsl:attribute>
					<xsl:if test="/APPSHORE/APP/dashboard/narrow2 > '0'">
						<xsl:attribute name="checked"/>
					</xsl:if>
				</input>&#160;Narrow Column 2
			</td>		
		</tr>		
		<tr  width="100%" align="center">
			<td >
				<select  size="6" name="selectNarrow2" style='width:170px' multiple="true" >
					<xsl:for-each select = "boxes/boxes_item" >
						<option>
							<xsl:attribute name="value"><xsl:value-of select="dashlet_name" /></xsl:attribute>
							<xsl:value-of select="app_label" />
						</option>
					</xsl:for-each>
				</select>
			</td>
			<td>
				<input type='button'  class="formBarButton" style='width:50px' onclick='moveUp(selectNarrow2);' value='Up' /><br/>
				<input type='button'  class="formBarButton" style='width:50px' onclick='moveDown(selectNarrow2);' value='Down' /><br/>
				<input type='button'  class="formBarButton" style='width:50px' title='Move to narrow column 1' onclick='copySelected( selectNarrow2, selectNarrow1);removeSelected(selectNarrow2);' value='Swap' /><br/> 
				<input type='button'  class="formBarButton" style='width:50px' title='Remove selected' onclick='copySelected( selectNarrow2, NarrowChooser);removeSelected( selectNarrow2);' value='X' /><br/> 
			</td>
		</tr>
		<tr class="field" width="100%" align="center">
			<td >
				<xsl:if test="/APPSHORE/APP/dashboard/narrow2 = '2'"> 
					<input type='submit'  class="formBarButton" style='width:50px' title='Move column to the right' onclick='document.dashboard_edit.narrow2.value=3;document.dashboard_edit.wide1.value=2;' value='&#62;'  name='key' />
				</xsl:if>		
			</td>
		</tr>		
	</table>
</xsl:template>

<xsl:template name='columnWide1'>
	<table width="100%" >
		<tr class="label" align="center">
			<td colspan="2">Wide Column</td>
		</tr>		
		<tr width="100%" align="center">
			<td >
				<select size="6" style='width:290px' name="selectWide1" multiple="true" >
					<xsl:for-each select = "boxes/boxes_item" >
						<option>
							<xsl:attribute name="value"><xsl:value-of select="dashlet_name" /></xsl:attribute>
							<xsl:value-of select="app_label" />
						</option>
					</xsl:for-each>
				</select>
			</td>
			<td >
				<input type='button'  class="formBarButton" style='width:50px' onclick='moveUp(selectWide1);' value='Up' /><br/>
				<input type='button'  class="formBarButton" style='width:50px' onclick='moveDown(selectWide1);' value='Down' /><br/>
				<input type='button'  class="formBarButton" style='width:50px' onclick='copySelected( selectWide1, WideChooser);removeSelected( selectWide1);' title='Remove selected' value='X' /><br/>				
			</td>
		</tr>
		<tr class="field" width="100%" align="center">
			<td >
				<xsl:if test="/APPSHORE/APP/dashboard/wide1 = '2'"> 
					<input type='submit'  class="formBarButton" style='width:50px' title='Move column to the left' onclick='document.dashboard_edit.narrow1.value=2;document.dashboard_edit.wide1.value=1;' value='&#60;'  name='key'/>&#160;
					<input type='submit'  class="formBarButton" style='width:50px' title='Move column to the right' onclick='document.dashboard_edit.narrow2.value=2;document.dashboard_edit.wide1.value=3;' value='&#62;'  name='key' />
				</xsl:if>			
			</td>	
		</tr>		
	</table>
</xsl:template>

<xsl:template name='activateDashboards'>	

	<form name='select_dashboards' method='post' >
	<input type='hidden' name='op' value='preferences.dashboards.activatedashboards'/>	
	<input type='hidden' name='activedashboards' value="" />	
    <table class="boxtitle" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td>
				Activate dashboards
			</td>
		</tr>
	</table>	
	<table cellSpacing="1" cellPadding="1" border="0" width="100%" >
		<tr class="label" align="center">
			<td width="15%">Sequence</td>
			<td >Activated dashboards</td>
			<td width="15%">Select</td>
			<td >Deactivated dashboards</td>
		</tr>
		<tr class="field" align='center'>
			<td >
				<input type='button' class="formBarButton" style='width:60px' onclick='moveTop(alldashboards);' value='Top' /><br/><br/><br/>
				<input type='button' class="formBarButton"  style='width:60px' onclick='moveUp(alldashboards);' value='Up' /><br/><br/><br/>
				<input type='button' class="formBarButton" style='width:60px' onclick='moveDown(alldashboards);' value='Down' /><br/><br/><br/>
				<input type='button' class="formBarButton" style='width:60px' onclick='moveBottom(alldashboards);' value='Bottom' />
			</td>			
			<td >
				&#160;<select style='width:200px' size="20" name="alldashboards" multiple="true" >
					<xsl:for-each select = "dashboards/dashboards_item[dashboard_status = 'A']" >
						<option>
							<xsl:attribute name="value"><xsl:value-of select="dashboard_id" /></xsl:attribute>
							<xsl:value-of select="dashboard_name" />
						</option>
					</xsl:for-each>
				</select>
			</td>
			<td >
				<input type='button'  class="formBarButton" style='width:40px' onclick='copyAll( alldashboards, dashboardids);removeAll(alldashboards);' value='&#62;&#62;' /><br/><br/><br/> 
				<input type='button'  class="formBarButton" style='width:40px' onclick='copySelected( alldashboards, dashboardids);removeSelected(alldashboards);' value='&#62;' /><br/><br/><br/> 
				<input type='button'  class="formBarButton" style='width:40px' onclick='copySelected( dashboardids, alldashboards);removeSelected(dashboardids);' value='&#60;' /><br/><br/><br/>
				<input type='button'  class="formBarButton" style='width:40px' onclick='copyAll( dashboardids, alldashboards);removeAll(dashboardids);' value='&#60;&#60;' />								
			</td>
			<td >
				<select style='width:200px' size="20" name="dashboardids"  multiple="true">
					<xsl:for-each select = "dashboards/dashboards_item[dashboard_status != 'A']" >
						<option>
							<xsl:attribute name="value"><xsl:value-of select="dashboard_id" /></xsl:attribute>
							<xsl:value-of select="dashboard_name" />
						</option>
					</xsl:for-each>
				</select>				
			</td>
		</tr>
	</table>
	<table border="0" width="100%" cellpadding="0" cellspacing="0">
		<tr >
			<td >
				<input type='submit' class="formBarButton" onclick='passDashboardsList( alldashboards, activedashboards);' name='key' value='Save' />&#160;
				<input type='reset' class="formBarButton" name='key' value='Cancel' />&#160;
			</td>
		</tr>
	</table>
	</form>	
</xsl:template>

</xsl:stylesheet>
