<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>
			
<xsl:template match="APP[action/node()[name() = /APPSHORE/APP/recordset/appName]]">
    <table width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
			<td class="left_panel" id="left_panel" style="display:{/APPSHORE/API/cookie/left_panel}">
			    <xsl:call-template name="verticalMenus">		    
					<xsl:with-param name="appName">administration</xsl:with-param>
					<xsl:with-param name="appLabel">Administration</xsl:with-param>
				</xsl:call-template>	
			</td>
            <td id="right_panel" class="right_panel">
				<xsl:choose>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'start'">
				    	<xsl:call-template name="applications_start"/>
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'search'">
				    	<xsl:call-template name="custom_search">
				    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
				    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabel"/>
				    	</xsl:call-template>	
				    	<xsl:call-template name="custom_grid">
				    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
				    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabel"/>
				    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appName"/>				    		
				    		<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>
				    	</xsl:call-template>
				    	<xsl:call-template name="custom_bulk">
				    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>				    		
				    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appName"/>				    		
				    		<xsl:with-param name="selectedForm" select="'custom_grid'"/>
				    		<xsl:with-param name="delete">false</xsl:with-param>				    		
				    	</xsl:call-template>
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'view'">
				    	<xsl:call-template name="custom_view">
				    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
				    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabelSingular"/>
				    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appNameSingular"/>
				    		<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>		
				    		<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>
							<xsl:with-param name="assignedto">false</xsl:with-param>
							<xsl:with-param name="delete">false</xsl:with-param>		
							<xsl:with-param name="duplicate">false</xsl:with-param>		
							<xsl:with-param name="print">false</xsl:with-param>		
				    	</xsl:call-template>				    					    	
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'edit'">
				    	<xsl:call-template name="custom_edit">
				    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
				    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabelSingular"/>
				    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appNameSingular"/>
				    		<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>		
				    		<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>
							<xsl:with-param name="assignedto">false</xsl:with-param>
							<xsl:with-param name="duplicate">false</xsl:with-param>
				    	</xsl:call-template>				    					    	
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'activateApplications'">
				    	<xsl:call-template name="activateApplications"/>
					</xsl:when>
					<xsl:otherwise>
				    	<xsl:call-template name="custom_actions"/>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>



<xsl:template name="applications_start">
	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Applications</xsl:with-param>
	</xsl:call-template>
    <div>
		<xsl:value-of disable-output-escaping="yes" select="php:function('lang','administration.applications.start')"/>
	</div>    
</xsl:template>


<xsl:template name='activateApplications'>	
	<script LANGUAGE="JavaScript" >	
	<![CDATA[
	function passApplicationsList( l2, MyList) 
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
	<form name='activateApplications' method='post' >
	<input type='hidden' name='op' id="op" value='administration.applications_base.activateApplications'/>	
	<input type='hidden' name='activeapps' id="activeapps" value="" />	
	<input type="hidden" name="key" id="key"/>				
	
	<div class="formTitleTags start_float">
    	<xsl:value-of select="php:function('lang','Activate applications')"/>
	</div>
	
	<xsl:call-template name="footerApplicationsForm">
		<xsl:with-param name="thisForm">activateApplications</xsl:with-param>
	</xsl:call-template> 

	<table cellSpacing='1' cellPadding='1' border='0' style="line-height:2em">
		<tr class="label" align="center">
			<td width="120px">
				<xsl:value-of select="php:function('lang','Sequence')"/>
			</td>
			<td width="300px">
				<xsl:value-of select="php:function('lang','Activated applications')"/>
			</td>
			<td width="80px">
				<xsl:value-of select="php:function('lang','Select')"/>
			</td>
			<td width="300px">
				<xsl:value-of select="php:function('lang','Deactivated applications')"/>
			</td>
		</tr>
		<tr class="field" align='center'>
			<td >
				<input type='button' class="formBarButton" style='width:80px' onclick='moveTop(allapps);'>
					<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Top')"/></xsl:attribute>
				</input>
				<br/><br/><br/>
				<input type='button' class="formBarButton" style='width:80px' onclick='moveUp(allapps);' >
					<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Up')"/></xsl:attribute>
				</input>				
				<br/><br/><br/>
				<input type='button' class="formBarButton" style='width:80px' onclick='moveDown(allapps);'>
					<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Down')"/></xsl:attribute>
				</input>				
				<br/><br/><br/>
				<input type='button' class="formBarButton" style='width:80px' onclick='moveBottom(allapps);' >
					<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Bottom')"/></xsl:attribute>
				</input>				
			</td>			
			<td >
				<select style='width:100%' size="20" name="allapps" id="allapps" multiple="true" >
					<xsl:for-each select = "apps/apps_item[status_id = 'A']" >
						<option value="{app_name}" >
							<xsl:value-of select="app_label" />
						</option>
					</xsl:for-each>
				</select>
			</td>
			<td >
				<input type='button' class="formBarButton" style='width:40px' onclick='copyAll( allapps, appids);removeAll(allapps);' value='&#62;&#62;' /><br/><br/><br/> 
				<input type='button' class="formBarButton" style='width:40px' onclick='copySelected( allapps, appids);removeSelected(allapps);' value='&#62;' /><br/><br/><br/> 
				<input type='button' class="formBarButton" style='width:40px' onclick='copySelected( appids, allapps);removeSelected(appids);' value='&#60;' /><br/><br/><br/>
				<input type='button' class="formBarButton" style='width:40px' onclick='copyAll( appids, allapps);removeAll(appids);' value='&#60;&#60;' />								
			</td>
			<td >
				<select style='width:100%' size="20" name="appids" id="appids" multiple="true">
					<xsl:for-each select = "apps/apps_item[status_id != 'A']" >
						<option value="{app_name}" >
							<xsl:value-of select="app_label" />
						</option>
					</xsl:for-each>
				</select>				
			</td>
		</tr>
	</table>

	<xsl:call-template name="footerApplicationsForm">
		<xsl:with-param name="thisForm">activateApplications</xsl:with-param>
	</xsl:call-template> 
	
	</form>	
</xsl:template>

<xsl:template name="footerApplicationsForm">
	<xsl:param name="thisForm"/>	

	<div class="clearboth">
		<input type="submit" class="formBarButton" id="Save" name="Save" onclick="passApplicationsList( allapps, activeapps);document.{$thisForm}.key.value='Save'">
	        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
	    </input>&#160;        	
		<input type="submit" class="formBarButton" id="Cancel" name="Cancel">
	        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
	    </input>
	</div>
</xsl:template>

</xsl:stylesheet>
