<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>
			
<xsl:template match="APP[action/node()[name() = /APPSHORE/APP/recordset/appName]]">
	<script LANGUAGE="JavaScript" >	
	<![CDATA[
	
	function passUsersList( l2, MyList) 
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
	
	function getTeamid( list, selected) 
	{
	    for ( i=(list.length-1); i>=0; i--) 
	        if (list.options[i].selected == true ) 
	        {
	       	    if ( i > 0 && selected.value.length )	
				    selected.value += ',';
                selected.value += list.options[i].value;
            }
	}
	
	function toBeDeleted( gridForm, selected)
	{
		selected.value = '';
	
		for (var i = 0; i < gridForm.elements.length ; i++)
			if (  gridForm.elements[i].type == 'checkbox' && gridForm.elements[i].id == 'select' 
				&& gridForm.elements[i].checked == true && gridForm.elements[i].value != '0'
				&& gridForm.elements[i].name != 'check_all' )
			{
				if ( i > 0 && selected.value.length )	
					selected.value += ',';
		        selected.value += gridForm.elements[i].value;
			}
		
		return selected.value;
	}

	]]>
	</script>
	
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
				    	<xsl:call-template name="sales_start"/>
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'teams'">
				    	<xsl:call-template name="sales_teams"/>			    	
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'salesPeople'">
				    	<xsl:call-template name="salesPeople"/>				    	
					</xsl:when>						
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'assignUsersToTeams'">
				    	<xsl:call-template name="assignUsersToTeams"/>				    	
					</xsl:when>					
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'setQuotas'">
				    	<xsl:call-template name="setQuotas"/>				    	
					</xsl:when>						
					<xsl:otherwise>
				    	<xsl:call-template name="custom_actions"/>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name="sales_start">
	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Sales organization</xsl:with-param>
	</xsl:call-template>
    <div>
		<xsl:value-of disable-output-escaping="yes" select="php:function('lang','administration.sales.start')"/>
	</div>
</xsl:template>

<xsl:template name="sales_teams">
	<form name="sales_teams" method="post" >
		<input type="hidden" name="op" value="{/APPSHORE/API/op/opname}"/>
		<input type="hidden" name="key"/>	
		<input type="hidden" name="selected"/>	

	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel" select="'Sales teams'"/>
	</xsl:call-template>

	<table border="0" width="100%" cellpadding="1" cellspacing="1" style="line-height:2em">
		<tr class="label" align="center" >
		    <xsl:call-template name="checkAllListForm">
				<xsl:with-param name="thisForm" select="'sales_teams'"/>
			</xsl:call-template>				
			<td>&#160;</td>		
			<td width="*%">
				<xsl:value-of select="php:function('lang','Sales team')"/>
			</td>
			<td width="*%">
				<xsl:value-of select="php:function('lang','Manager')"/>
			</td>
			<td width="*%">
				<xsl:value-of select="php:function('lang','Team members')"/>
			</td>			
		</tr>		
		<xsl:for-each select = "sales/sales_item">
			<tr align="left" class="unselectedtext" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
			    <xsl:call-template name="checkListForm">
					<xsl:with-param name="thisForm" select="'sales_teams'"/>
					<xsl:with-param name="thisId" select="team_id"/>				
					<xsl:with-param name="scope" select="'1'"/>					
				</xsl:call-template>					
				<td align="center" width="2%">
					<xsl:variable name="title"><xsl:value-of select="php:function('lang','Edit')"/></xsl:variable>				
					<a href="javascript:popupIntra('{$baseurl}&amp;op=administration.sales_popup.edit&amp;team_id={team_id}','{$title}');"  >
						<img class="image" src="{$api_image_path}/edit.png"/>						
					</a>
				</td>										
				<td>					
					<xsl:call-template name="loop">
						<xsl:with-param name="i" select="'1'"/>
						<xsl:with-param name="count" select="level"/>
					</xsl:call-template>
					<xsl:variable name="title"><xsl:value-of select="php:function('lang','Edit')"/></xsl:variable>				
					<a href="javascript:popupIntra('{$baseurl}&amp;op=administration.sales_popup.edit&amp;team_id={team_id}','{$title}');">
						<xsl:value-of select="team_name"/>							
					</a>					
				</td>
				<td align="center">
					<a href="{$baseurl}&amp;op=administration.users_base.view&amp;user_id={manager_id}">
						<xsl:value-of select="manager_full_name"/>
					</a>
				</td>				
				<td>
					<xsl:for-each select = "users/users_item">				
						<a href="{$baseurl}&amp;op=administration.users_base.view&amp;user_id={user_id}">
							<xsl:value-of select="full_name" />
						</a>&#160;&#160;&#160;
					</xsl:for-each>						
				</td>				
			</tr>	
		</xsl:for-each>
	</table>
	<table border="0" width="100%" cellpadding="0" cellspacing="0" style="line-height:2em">				
		<tr align="left">
		    <xsl:call-template name="checkAllListForm">
				<xsl:with-param name="thisForm" select="'sales_teams'"/>
			</xsl:call-template>	
			<td >
				<xsl:if test="/APPSHORE/APP/scope > 0 "> 	
					<input type="submit" class="formBarButton" id="Delete" name="Delete" onclick="toBeDeleted(document.sales_teams, document.sales_teams.selected);document.sales_teams.key.value='Delete';">
		           		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Delete')"/></xsl:attribute>                    
				        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Delete')"/></xsl:attribute>
				    </input>&#160;
				</xsl:if>
				<xsl:variable name="title"><xsl:value-of select="php:function('lang','New')"/></xsl:variable>				
				<input type="button" class="formBarButton" id="new" name="new" onclick="popupIntra('{$baseurl}&amp;op=administration.sales_popup.edit&amp;team_id={team/team_id}','{$title}');">
		            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','New')"/></xsl:attribute>
                </input>
			</td>
		</tr>
	</table>
	</form>	
</xsl:template>

<xsl:template name="loop">
	<xsl:param name="i"/>
	<xsl:param name="count"/>
	<xsl:if test="$i &lt; $count">
<!--    body of the loop goes here    -->
		&#160;&#160;&#160;&#160;&#160;
<!--    end of body of the loop   -->
		<xsl:call-template name="loop">
			<xsl:with-param name="i" select="$i + 1"/>
			<xsl:with-param name="count" select="$count"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template name="salesPeople">	

	<form name="salesPeople" method="post" >
		<input type="hidden" name="op" value="administration.sales_base.salesPeople"/>
		<input type="hidden" name="selectedusers" value=""/>
	
	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Sales people</xsl:with-param>
	</xsl:call-template>

    <table cellSpacing="1" cellPadding="1" border="0" width="100%" style="line-height:2em">	
		<tr align="left">
			<td >	
				<input type="hidden" name="key" />				
				<input type="submit" class="formBarButton" name="Submit" onclick="passUsersList(userids,selectedusers);document.salesPeople.key.value='Save'">
                    <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
                </input>&#160;			
				<input type="submit" class="formBarButton" name="Cancel" onclick="document.salesPeople.key.value='Cancel'">
                    <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
                </input>                					
			</td>		
		</tr>
		<tr class="label" align="center">
			<td>
				<xsl:value-of select="php:function('lang','Users')"/>
			</td>
			<td>
				<xsl:value-of select="php:function('lang','Assign to')"/>
			</td>
			<td>
				<xsl:value-of select="php:function('lang','Sales people')"/>
			</td>
		</tr>	
		<tr class="field" align="center">	
			<td >
				&#160;<select style="width:250px" size="15" name="allusers" id="allusers" multiple="true" >
					<xsl:for-each select="/APPSHORE/APP/users/users_item" >
                        <option value="{user_id}">
		           			<xsl:value-of select="full_name" />
				    	</option>
					</xsl:for-each>
				</select>
			</td>
			<td >
				<input type="button" class="formBarButton" style="width:40px" onclick="copyAll( allusers, userids);removeAll(allusers);" value="&#62;&#62;" /><br/><br/> 
				<input type="button" class="formBarButton" style="width:40px" onclick="copySelected( allusers, userids);removeSelected(allusers);" value="&#62;" /><br/><br/>
				<input type="button" class="formBarButton" style="width:40px" onclick="copySelected( userids, allusers);removeSelected(userids);" value="&#60;" /><br/><br/>
				<input type="button" class="formBarButton" style="width:40px" onclick="copyAll( userids, allusers);removeAll(userids);" value="&#60;&#60;" />							
			</td>
			<td >
				<select style="width:250px" size="15" name="userids"  multiple="true">
					<xsl:for-each select = "/APPSHORE/APP/salespeople/salespeople_item" >
						<option value="{user_id}">
					        <xsl:value-of select="full_name" />
						</option>
					</xsl:for-each>
				</select>				
			</td>
		</tr>
		<tr align="left">
			<td >	
				<input type="submit" class="formBarButton" name="Submit" onclick="passUsersList( userids, selectedusers);document.salesPeople.key.value='Save'">
                    <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
                </input>&#160;			
				<input type="submit" class="formBarButton" name="Cancel" onclick="document.salesPeople.key.value='Cancel'">
                    <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
                </input>                					
			</td>		
		</tr>
	</table>	
	</form>	
</xsl:template>

<xsl:template name='assignUsersToTeams'>	

	<form name='assignUsersToTeams' method='post' >
		<input type='hidden' name='op' value='administration.sales_base.assignUsersToTeams'/>
		<input type='hidden' name='selectedteams' value="{/APPSHORE/APP/selected/selected_item/team_id}"/>
		<input type='hidden' name='selectedusers' value=""/>
	
	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Team members</xsl:with-param>
	</xsl:call-template>
	
	<table cellSpacing="1" cellPadding="1" border="0" width="100%" style="line-height:2em">
		<tr >
			<td class="label" align="right">
				<xsl:value-of select="php:function('lang','Sales team')"/>:
			</td>
			<td class="field" align="left" >
				&#160;<select style='width:250px' name="allteams" id="allteams" onchange='selectedteams.value="";getTeamid(allteams,selectedteams);assignUsersToTeams.submit();return true;'>
						<option/>
					<xsl:for-each select = "teams/teams_item" >
						<option value="{team_id}">
							<xsl:if test="team_id = /APPSHORE/APP/selected/selected_item/team_id">
								<xsl:attribute name="selected" select="'true'"/>
							</xsl:if>
							<xsl:call-template name="loop">
								<xsl:with-param name="i" select="'1'"/>
								<xsl:with-param name="count" select="level"/>
							</xsl:call-template>
							<xsl:value-of select="team_name"/>
						</option>
					</xsl:for-each>	
				</select>
			</td>
		</tr>
	</table>
	<table>
		<tr align='left'>
			<td >	
				<input type="hidden" name="key" />				
				<input type="submit" class="formBarButton" name="Submit" onclick="passUsersList( userids, selectedusers);document.assignUsersToTeams.key.value='Save'">
                    <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
                </input>&#160;			
				<input type="submit" class="formBarButton" name="Cancel" onclick="document.assignUsersToTeams.key.value='Cancel'">
                    <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
                </input>                					
			</td>		
		</tr>
	</table>	
    <table cellSpacing="1" cellPadding="1" border="0" width="100%" style="line-height:2em">	
		<tr class="label" align='center'>
			<td>
				<xsl:value-of select="php:function('lang','Sales people')"/>
			</td>
			<td>
				<xsl:value-of select="php:function('lang','Assign to')"/>
			</td>
			<td>
				<xsl:value-of select="php:function('lang','Team members')"/>
			</td>
		</tr>	
		<tr class="field" align='center'>	
			<td >
				&#160;<select style='width:250px' size="15" name="allusers" id="allusers" multiple="true" >
					<xsl:for-each select = "users/users_item[not(user_id = /APPSHORE/APP/sales_users/sales_users_item/user_id)]" >
	                    <option value="{user_id}">
			           		<xsl:value-of select="full_name" />
					     </option>
					</xsl:for-each>
				</select>
			</td>
			<td >
				<input type="button" class="formBarButton" style="width:40px" onclick="copyAll( allusers, userids);removeAll(allusers);" value="&#62;&#62;" /><br/><br/>
				<input type="button" class="formBarButton" style="width:40px" onclick="copySelected( allusers, userids);removeSelected(allusers);" value="&#62;" /><br/><br/>
				<input type="button" class="formBarButton" style="width:40px" onclick="copySelected( userids, allusers);removeSelected(userids);" value="&#60;" /><br/><br/>
				<input type="button" class="formBarButton" style="width:40px" onclick="copyAll( userids, allusers);removeAll(userids);" value="&#60;&#60;" />								
			</td>
			<td >
				<select style='width:250px' size="15" name="userids" id="userids"  multiple="true">
					<xsl:for-each select = "users/users_item[user_id = /APPSHORE/APP/sales_users/sales_users_item/user_id]" >
						<option value="{user_id}">
					        <xsl:value-of select="full_name" />
						</option>
					</xsl:for-each>
				</select>				
			</td>
		</tr>
	</table>	
	<table>
		<tr align='left'>
			<td >	
				<input type="submit" class="formBarButton" name="Submit" onclick="passUsersList(userids,selectedusers);document.assignUsersToTeams.key.value='Save'">
                    <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
                </input>&#160;			
				<input type="submit" class="formBarButton" name="Cancel" onclick="document.assignUsersToTeams.key.value='Cancel'">
                    <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
                </input>                					
			</td>		
		</tr>
	</table>	
	</form>	
</xsl:template>


<xsl:template name='setQuotas'>	

	<form name='setQuotas' method='post' >
		<input type='hidden' name='op' value='administration.sales_base.setQuotas'/>	
	
	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Quotas</xsl:with-param>
	</xsl:call-template>
	
	<table cellSpacing="1" cellPadding="1" border="0" width="100%" style="line-height:2em">
		<tr >
			<td class="label" align="right" width="20%">
				<xsl:value-of select="php:function('lang','Sales people')"/>:
			</td>
			<td class="field" align="left" width="30%">
				<select name="user_id" id="user_id" onchange='document.setQuotas.submit();return true;'>
					<xsl:for-each select = "users/users_item" >
						<option value="{user_id}">
							<xsl:if test="user_id = /APPSHORE/APP/user_id">
 								<xsl:attribute name="selected" select="'true'"/>
						    </xsl:if>
					        <xsl:value-of select="full_name" />
					     </option>
					</xsl:for-each>	
				</select>
			</td>		
			<td class="label" align="right" width="20%">
				<xsl:value-of select="php:function('lang','Fiscal year')"/>:
			</td>
			<td class="field" align="left" width="30%">
				<select name="fiscalyear" id="fiscalyear" onchange='document.setQuotas.submit();return true;'>
					<xsl:for-each select = "fiscalyears/fiscalyears_item" >
						<option value="{year}">
							<xsl:if test="year = /APPSHORE/APP/fiscalyear">
 								<xsl:attribute name="selected" select="'true'"/>
						    </xsl:if>
					         <xsl:value-of select="year"/>
					     </option>
					</xsl:for-each>	
				</select>
			</td>
		</tr>
	</table>
	
	<xsl:call-template name="footerEditForm">
		<xsl:with-param name="testParam" select="user_id"/>
		<xsl:with-param name="thisForm" select="'setQuotas'"/>
		<xsl:with-param name="isTop">true</xsl:with-param>
	</xsl:call-template> 
	
    <table cellSpacing="1" cellPadding="1" border="0" width="100%" style="line-height:2em">
			<tr class="label" align='center'>
				<td width="15%">
					<xsl:value-of select="php:function('lang','Month')"/>
				</td>					
				<td width="20%">
					<xsl:value-of select="php:function('lang','Amount')"/>
				</td>
				<td width="12%">
					<xsl:value-of select="php:function('lang','Month')"/>/<xsl:value-of select="php:function('lang','Year')"/>
				</td>				
				<td width="12%">
					<xsl:value-of select="php:function('lang','Month')"/>/<xsl:value-of select="php:function('lang','Quarter')"/>
				</td>				
				<td width="*%">
					<xsl:value-of select="php:function('lang','Quarter')"/>
				</td>								
				<td width="16%">
					<xsl:value-of select="php:function('lang','Amount')"/>
				</td>	
				<td width="12%">
					<xsl:value-of select="php:function('lang','Quarter')"/>/<xsl:value-of select="php:function('lang','Year')"/>
				</td>												
	        </tr>     
	        	
		<xsl:for-each select = "/APPSHORE/APP/months/months_item" >   
			<tr>
				<td class="label" align='center'>
					<xsl:value-of select="month_name"/>
				</td>
				<td class="field" >
					&#160;<xsl:value-of select="/APPSHORE/APP/currency"/>&#160;
					<input type="text" size="12" name="amount_{month_id}" id="amount_{month_id}" value="{amount}">
						<xsl:value-of select="amount"/>
					</input>				
				</td>	
				<td class="field" align="center">
					<xsl:value-of select="month_year_ratio"/>&#160;%
				</td>
				<td class="field" align="center">
					<xsl:value-of select="month_quarter_ratio"/>&#160;%
				</td>
				<xsl:choose>
					<xsl:when test="quarterly_amount">
						<td class="label" align="center">
							<xsl:value-of select="quarter_name"/>
						</td>
						<td class="field" >
							&#160;<xsl:value-of select="/APPSHORE/APP/currency"/>&#160;<xsl:value-of select="quarterly_amount"/>
						</td>															
						<td class="field" align="center">
							<xsl:value-of select="quarter_year_ratio"/>&#160;%
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td/>
						<td/>
						<td/>
					</xsl:otherwise>
				</xsl:choose>											
	        </tr>         	     	
        </xsl:for-each>	
	        <tr>		        
				<td class="label" align="center">
					<xsl:value-of select="php:function('lang','Fiscal year')"/>
				</td>	
				<td class="field" >
					&#160;<xsl:value-of select="/APPSHORE/APP/currency"/>&#160;<xsl:value-of select="yearly_amount"/>
				</td>
				<td/>					
				<td/>					
				<td/>
				<td/>								
				<td/>							
	        </tr>         
	</table>
	
	<xsl:call-template name="footerEditForm">
		<xsl:with-param name="testParam" select="user_id"/>
		<xsl:with-param name="thisForm" select="'setQuotas'"/>
	</xsl:call-template> 

	</form>	
</xsl:template>


</xsl:stylesheet>
