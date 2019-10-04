<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP">
	<script LANGUAGE="JavaScript" >	
	<![CDATA[
	
	
	function passGroupsList( l2, MyList) 
	{ 
		MyList.value.length = 0;	
	    for ( i=0; i < l2.length ; i++) 
		{
			if ( i > 0 && MyList.value.length )	
				MyList.value += ',';	
				
			MyList.value += l2.options[i].value;			
		}
	}
	
	
	function passRolesList( l2, MyList) 
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
	
	
	function getGroupid( list, selected) 
	{
	    for ( i=(list.length-1); i>=0; i--) 
	        if (list.options[i].selected == true ) 
	        {
	       	    if ( i > 0 && selected.value.length )	
				    selected.value += ',';
                selected.value += list.options[i].value;
            }
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
					<xsl:when test="action/groups = 'search'">
				    	<xsl:call-template name="groups_search"/>
				    	<xsl:call-template name="groups_list"/>
					</xsl:when>	
					<xsl:when test="action/groups = 'view'">
				    	<xsl:call-template name="group_view"/>
					</xsl:when>	
					<xsl:when test="action/groups = 'edit'">
				    	<xsl:call-template name="group_edit"/>
					</xsl:when>	
					<xsl:when test="action/groups = 'activateGroups'">
				    	<xsl:call-template name="activateGroups"/>
					</xsl:when>	
					<xsl:when test="action/groups = 'grantRolesToGroups'">
				    	<xsl:call-template name="grantRolesToGroups"/>
					</xsl:when>		
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>


<xsl:template name="groups_search">

	<form name="group_search" method="post">
	<input type="hidden" name="op" value="administration.groups.search"/>			
    <table class="boxtitle" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td >
				Search Groups
			</td>
		</tr>
	</table>
	<table cellSpacing="1" cellPadding="1" border="0" width="100%" valign="top">
		<tr  width="100%">
			<td width="30%">Group Name</td>
			<td >Group Status</td>
		</tr>
		<tr >
			<td >
				<input name="group_name" >
					<xsl:attribute name="value">
						<xsl:value-of select="/APPSHORE/APP/recordset/group_name" />
					</xsl:attribute>
				</input>
			</td>
			<td >
				<select name="group_status" >
							<option>
							</option>
					<xsl:choose>
						<xsl:when test="/APPSHORE/APP/recordset/group_status = 'A'">
							<option selected ="true" value="A">
								Activated
							</option>
							<option value="D">
								Desactivated
							</option>
						</xsl:when>
						<xsl:when test="/APPSHORE/APP/recordset/group_status = 'D'">
							<option value="A">
								Activated
							</option>
							<option selected ="true" value="D">
								Desactivated
							</option>
						</xsl:when>
						<xsl:otherwise>
							<option value="A">
								Activated
							</option>
							<option value="D">
								Desactivated
							</option>
						</xsl:otherwise>
					</xsl:choose>				
				</select>
			</td>			
		</tr>
		<tr>
			<td colspan="6">
				<br/>
				<input type="submit" name="key" value="Search" />&#160; 
				<input type="submit" name="key" value="Clear" />&#160;
			</td>
		</tr>
	</table>
	</form>	
</xsl:template>


<xsl:template name="groups_list">

	<form name="group_listing" method="post" >
		<input type="hidden" name="op" value="administration.groups.search"/>
		<input type="hidden" name="currentVal">
			<xsl:attribute name="value"><xsl:value-of select="recordset/currentVal" /></xsl:attribute>
		</input>
		<input type="hidden" name="countMax">
			<xsl:attribute name="value"><xsl:value-of select="recordset/countMax" /></xsl:attribute>
		</input>
		<input type="hidden" name="first">
			<xsl:attribute name="value"><xsl:value-of select="recordset/first" /></xsl:attribute>
		</input>
		<input type="hidden" name="orderby" >
			<xsl:attribute name="value"><xsl:value-of select="recordset/orderby" /></xsl:attribute>
		</input>
		<input type="hidden" name="ascdesc" >
			<xsl:attribute name="value"><xsl:value-of select="recordset/ascdesc" /></xsl:attribute>
		</input>	
		<input type="hidden" name="group_name" >
			<xsl:attribute name="value"><xsl:value-of select="recordset/group_name" /></xsl:attribute>
		</input>	
		<input type="hidden" name="group_id" >
			<xsl:attribute name="value"><xsl:value-of select="recordset/group_id" /></xsl:attribute>
		</input>	
		<input type="hidden" name="group_status" >
			<xsl:attribute name="value"><xsl:value-of select="recordset/group_status" /></xsl:attribute>
		</input>			
    <table class="boxtitle" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td >
				Groups 
			</td>
			<td align="right">
				<xsl:choose>
					<xsl:when test="recordset/countMax = 0">
						No Groups
					</xsl:when>
					<xsl:otherwise>								
						Groups <xsl:value-of select="recordset/currentVal+1" /> to <xsl:value-of select="recordset/first" /> of <xsl:value-of select="recordset/countMax" />					
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
	</table>
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr class="label" >
			<td>
				<a href="javascript: orderby( document.group_listing, 'group_name');" >Name</a>
			</td>
			<td >
				Definition
			</td>
			<td >
				<a href="javascript: orderby( document.group_listing, 'group_status');">Status</a>
			</td>
		</tr>
		<xsl:for-each select = "groups/groups_item">
			<tr class="unselectedtext" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
			
				<td width="30%">
					<a href="{$baseurl}&amp;op=administration.groups.view&amp;group_id={group_id}">
						<xsl:value-of select="group_name"/>
					</a>
				</td>
				<td width="60%">
					<xsl:value-of select="group_label"/>
				</td>				
				<td width="10%">
					<xsl:choose> 
						<xsl:when test="group_status = 'A'">
							Activated
						</xsl:when>
						<xsl:otherwise>								
							Desactivated					
						</xsl:otherwise>
					</xsl:choose>	
				</td>
			</tr>	
		</xsl:for-each>
		</table>
		<table>
			<tr>
				<td align="left" >
					<br/>
					<input type="submit" name="key" value="First"  />&#160; 
					<input type="submit" name="key" value="Previous" />&#160; 
					<input type="submit" name="key" value="Next" />&#160; 
					<input type="submit" name="key" value="Last" />
				</td>
			</tr>
		</table>
	</form>
</xsl:template>

<xsl:template name="group_view">

	<form name="group_view" method="post" >
		<input type="hidden" name="op" value="administration.groups.view"/>
		<input type="hidden" name="group_id" >
			<xsl:attribute name="value"><xsl:value-of select="group/group_id" /></xsl:attribute>
		</input>

    <table class="boxtitle" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td>
				View Group&#032;<b><xsl:value-of select="group/group_name"/></b>
			</td>
		</tr>
	</table>
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr>
			<td class="label" align="right" width="20%" >Name:</td>
			<td align="left" class="field" width="30%" >
				<xsl:value-of select="group/group_name"/>
			</td>
			<td class="label" align="right" width="20%" >Status:</td>			
			<td align="left" class="field"  width="30%" >
				<xsl:choose> 
					<xsl:when test="group/group_status = 'A'">
						Activated
					</xsl:when>
					<xsl:otherwise>								
						Desactivated					
					</xsl:otherwise>
				</xsl:choose>				
			</td>			
		</tr>
		<tr>
			<td class="label" align="right" width="20%" >Email:</td>
			<td align="left" class="field" width="30%" >
				<xsl:value-of select="group/group_email"/>
			</td>		
			<td class="label" align="right" width="20%" ></td>
			<td align="left" class="field">
			</td>	
		</tr>
		<tr>
			<td class="label" align="right" width="20%" >Definition:</td>			
			<td align="left" class="field" colspan="3">
				<xsl:value-of select="group/group_label"/>
			</td>
		</tr>
		<tr>
			<td align="right" class="label" >Created:</td>
			<td align="left" class="field"  >
				<xsl:value-of select="group/created"/><br/>
				<xsl:value-of select="group/created_by"/>
			</td>			
			<td align="right" class="label" >Updated:</td>
			<td align="left" class="field"  >
				<xsl:value-of select="group/updated"/><br/>
				<xsl:value-of select="group/updated_by"/>
			</td>
		</tr>			
	</table>
	<table border="0" width="100%" cellpadding="0" cellspacing="0">				
		<tr align="left">
			<td >
				<br/>
				<input type="submit" name="key" value="Edit" />&#160; 
				<input type="submit" name="key" value="Duplicate"/>&#160; 
				<input type="submit" name="key" value="Delete" />&#160; 
				<input type="submit" name="key" value="Print" /> 
			</td>
		</tr>
	</table>
	</form>	
</xsl:template>

	
<xsl:template name="group_edit">

	<form name="group_edit" method="post" >
		<input type="hidden" name="op" value="administration.groups.edit"/>
		<input type="hidden" name="group_id" >
			<xsl:attribute name="value"><xsl:value-of select="group/group_id" /></xsl:attribute>
		</input>
    <table class="boxtitle" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td >
				<xsl:choose>
					<xsl:when test="group/group_id">
						Edit Group&#032;<b><xsl:value-of select="group/group_name" /></b>
					</xsl:when>
					<xsl:otherwise>
						New group
					</xsl:otherwise>
				</xsl:choose>	
			</td>
		</tr>
	</table>
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr>
			<td class="label" align="right" width="20%" >Name:</td>
			<td class="field" align="left" width="30%" >
				<input type="text" size="30" name="group_name" >
					<xsl:attribute name="value">
						<xsl:value-of select="group/group_name" />
					</xsl:attribute>
				</input>
			</td>			
			<td class="label" align="right" width="20%" >Status:</td>
			<td  class="field" align="left" width="30%" >
				<select name="group_status" >
					<xsl:choose>
						<xsl:when test="group/group_status = 'A'">
							<option selected ="true" value="A">
								Activated
							</option>
							<option value="D">
								Desactivated
							</option>
						</xsl:when>
						<xsl:otherwise>
							<option value="A">
								Activated
							</option>
							<option selected="true" value="D">
								Desactivated
							</option>
						</xsl:otherwise>
					</xsl:choose>				
				</select>
			</td>
		</tr>
		<tr>
			<td class="label" align="right" width="20%" >Email:</td>
			<td class="field" align="left" width="30%" >
				<input type="text" size="30" name="group_email" >
					<xsl:attribute name="value">
						<xsl:value-of select="group/group_email" />
					</xsl:attribute>
				</input>
			</td>	
			<td class="label" align="right" width="20%" ></td>
			<td class="field" align="left" width="30%" >
			</td>					
		</tr>
		<tr>				
			<td class="label" align="right">Definition:</td>			
			<td  class="field" align="left" colspan="3">
				<input type="text" size="90" name="group_label" >
					<xsl:attribute name="value">
						<xsl:value-of select="group/group_label" />
					</xsl:attribute>
				</input>
			</td>
		</tr>
	</table>
	<table border="0" width="100%" cellpadding="0" cellspacing="0">				
		<tr >
			<td >
				<br/>
				<input type="submit" name="key" value="Save" />&#160; 
				<input type="reset" value="Reset" />&#160;
				<xsl:choose>
					<xsl:when test="group/group_id">
						<input type="submit" name="key" value="View"/> 
					</xsl:when>
				</xsl:choose>				
			</td>
		</tr>
	</table>
	</form>	
</xsl:template>


<xsl:template name='selectGroups'>
	<form name='select_groups' method='post' >
	<input type='hidden' name='op' value='administration.groups.expirePasswords'/>	
	<input type='hidden' name='selectedgroups' value="" />	
    <table class="boxtitle" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td>
				Expire Passwords
			</td>
		</tr>
	</table>	
	<table cellSpacing='1' cellPadding='1' border='0' width='100%' >
		<tr class="label" align='center'>
			<td >Available Groups</td>
			<td >Select</td>
			<td >Selected Groups</td>
		</tr>
		<tr class="field" align='center'>
			<td >
				&#160;<select style='width:250px' size="20" name="allgroups" multiple="true" >
					<xsl:for-each select = "groups/groups_item" >
						<option>
							<xsl:attribute name="value"><xsl:value-of select="group_id" /></xsl:attribute>
							<xsl:value-of select="last_name" />,&#160;<xsl:value-of select="first_names" />
						</option>
					</xsl:for-each>
				</select>
			</td>
			<td >
				<input type='button' style='width:40px' onclick='copyAll( allgroups, groupids);' value='&#62;&#62;' /><br/><br/><br/> 
				<input type='button' style='width:40px' onclick='copySelected( allgroups, groupids);' value='&#62;' /><br/><br/><br/> 
				<input type='button' style='width:40px' onclick='removeSelected(groupids);' value='&#60;' /><br/><br/><br/>
				<input type='button' style='width:40px' onclick='removeAll(groupids);' value='&#60;&#60;' />								
			</td>
			<td >
				<select style='width:250px' size="20" name="groupids"  multiple="true">
					<xsl:for-each select = "groups/groups_item[selected = 1]" >
						<option>
							<xsl:attribute name="value"><xsl:value-of select="group_id" /></xsl:attribute>
							<xsl:value-of select="last_name" />,&#160;<xsl:value-of select="first_names" />
						</option>
					</xsl:for-each>
				</select>				
			</td>
		</tr>
		<tr align='left'>
			<td ><br/>	
				<input type='submit' onclick='passGroupsList( groupids, selectedgroups);' name='key' value='Expire' />&#160; 
				<input type='reset' onclick='removeAll(groupids)' name='key' value='Cancel' />					
			</td>
		</tr>
	</table>
	</form>	
</xsl:template>

<xsl:template name='activateGroups'>	

	<form name='select_groups' method='post' >
	<input type='hidden' name='op' value='administration.groups.activateGroups'/>	
	<input type='hidden' name='selectedgroups' value="" />	
    <table class="boxtitle" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td>
				Activate Groups
			</td>
		</tr>
	</table>	
	<table cellSpacing='1' cellPadding='1' border='0' width='100%' >
		<tr class="label" align='center'>
			<td >Activated Groups</td>
			<td >Select</td>
			<td >Desactivated Groups</td>
		</tr>
		<tr class="field" align='center'>
			<td >
				&#160;<select style='width:250px' size="20" name="allgroups" multiple="true" >
					<xsl:for-each select = "groups/groups_item[group_status = 'A']" >
						<option>
							<xsl:attribute name="value"><xsl:value-of select="group_id" /></xsl:attribute>
							<xsl:value-of select="group_name" />
						</option>
					</xsl:for-each>
				</select>
			</td>
			<td >
				<input type='button' style='width:40px' onclick='copyAll( allgroups, groupids);removeAll(allgroups);' value='&#62;&#62;' /><br/><br/><br/> 
				<input type='button' style='width:40px' onclick='copySelected( allgroups, groupids);removeSelected(allgroups);' value='&#62;' /><br/><br/><br/> 
				<input type='button' style='width:40px' onclick='copySelected( groupids, allgroups);removeSelected(groupids);' value='&#60;' /><br/><br/><br/>
				<input type='button' style='width:40px' onclick='copyAll( groupids, allgroups);removeAll(groupids);' value='&#60;&#60;' />								
			</td>
			<td >
				<select style='width:250px' size="20" name="groupids"  multiple="true">
					<xsl:for-each select = "groups/groups_item[group_status != 'A']" >
						<option>
							<xsl:attribute name="value"><xsl:value-of select="group_id" /></xsl:attribute>
							<xsl:value-of select="group_name" />
						</option>
					</xsl:for-each>
				</select>				
			</td>
		</tr>
		<tr align='left'>
			<td ><br/>	
				<input type='submit' onclick='passGroupsList( groupids, selectedgroups);' name='key' value='Save' />&#160; 
				<input type='reset' name='key' value='Cancel' />					
			</td>
		</tr>
	</table>
	</form>	
</xsl:template>

<xsl:template name='grantRolesToGroups'>	

	<form name='select_groups' method='post' >
	<input type='hidden' name='op' value='administration.groups.grantRolesToGroups'/>	
	<input type='hidden' name='selectedgroups' >	
	   <xsl:attribute name="value"><xsl:value-of select="/APPSHORE/APP/selected/selected_item/group_id" /></xsl:attribute>
	</input>
	<input type='hidden' name='selectedroles' value="" />
    <table class="boxtitle" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td>
				Grant Roles to Groups
			</td>
		</tr>
	</table>	
	<table cellSpacing='1' cellPadding='1' border='0' width='100%' >
		<tr >
			<td class="label" align="right">Group:</td>
			<td class="field" align="left" >
				&#160;<select style='width:250px' name="allgroups" onchange='selectedgroups.value=""; getGroupid(allgroups, selectedgroups); select_groups.submit();return true;'>
				            <option></option>
					<xsl:for-each select = "groups/groups_item" >
					   <xsl:choose>
					       <xsl:when test="group_id = /APPSHORE/APP/selected/selected_item/group_id">
                                <option selected="true">
							         <xsl:attribute name="value"><xsl:value-of select="group_id" /></xsl:attribute>
							         <xsl:value-of select="group_name" />
							     </option>
						    </xsl:when>
						    <xsl:otherwise>
							     <option>
							         <xsl:attribute name="value"><xsl:value-of select="group_id" /></xsl:attribute>
							         <xsl:value-of select="group_name" />
							     </option>
					   	   </xsl:otherwise>
					   </xsl:choose>	
					</xsl:for-each>	
				</select>
			</td>
		</tr>
	</table>
    <table cellSpacing='1' cellPadding='1' border='0' width='100%' >	
		<tr class="label" align='center'>
			<td >Available Roles</td>
			<td >Grant</td>
			<td >Roles Granted</td>
		</tr>	
		<tr class="field" align='center'>	
			<td >
				&#160;<select style='width:250px' size="20" name="allroles" multiple="true" >
					<xsl:for-each select = "roles/roles_item" >
						<xsl:choose>
					       <xsl:when test="role_id = /APPSHORE/APP/groups_roles/groups_roles_item/role_id">
						   </xsl:when>
						    <xsl:otherwise> 
                                <option >
					           		<xsl:attribute name="value"><xsl:value-of select="role_id" /></xsl:attribute>
					           		<xsl:value-of select="role_name" />
							     </option>
					        </xsl:otherwise>  
					   </xsl:choose>	
					</xsl:for-each>
				</select>
			</td>
			<td >
				<input type='button' style='width:40px' onclick='copyAll( allroles, roleids);removeAll(allroles);' value='&#62;&#62;' /><br/><br/><br/> 
				<input type='button' style='width:40px' onclick='copySelected( allroles, roleids);removeSelected(allroles);' value='&#62;' /><br/><br/><br/> 
				<input type='button' style='width:40px' onclick='copySelected( roleids, allroles);removeSelected(roleids);' value='&#60;' /><br/><br/><br/>
				<input type='button' style='width:40px' onclick='copyAll( roleids, allroles);removeAll(roleids);' value='&#60;&#60;' />								
			</td>
			<td >
				<select style='width:250px' size="20" name="roleids"  multiple="true">
					<xsl:for-each select = "roles/roles_item[role_id = /APPSHORE/APP/groups_roles/groups_roles_item/role_id]" >
						<option>
							<xsl:attribute name="value"><xsl:value-of select="role_id" /></xsl:attribute>
							<xsl:value-of select="role_name" />
						</option>
					</xsl:for-each>
				</select>				
			</td>
		</tr>
		<tr align='left'>
			<td ><br/>	
				<input type='submit' onclick='passRolesList( roleids, selectedroles);' name='key' value='Save' />&#160; 
				<input type='submit' name='key' value='Cancel' />					
			</td>
		</tr>
	</table>	
	</form>	
</xsl:template>

</xsl:stylesheet>
