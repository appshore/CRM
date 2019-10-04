<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>
			
<xsl:template name='grantRolesToUsers'>	

	<script language="JavaScript" type="text/javascript" src="administration/js/users_roles.js"/>			

	<form name='grantRolesToUsers' method='post' >
	<input type='hidden' name='op' value='administration.users_roles.grantRolesToUsers'/>
	<input type="hidden" name="key" id="key"/>
	<input type='hidden' name='selectedroles' value="" />

	<div class="formTitleTags start_float">
    	<xsl:value-of select="php:function('lang','Grant roles')"/>
	</div>
	<div class="clearboth fieldLabelContainer" style="padding:10px 0 10px 0">
		<div class="fieldLabel start_float">
			<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Select a user')"/></xsl:attribute>
			<xsl:value-of select="php:function('lang','Select a user')"/>
		</div>
		<div class="clearboth fieldText" >
			<select style='width:250px' id="user_id" name="user_id" onchange='grantRolesToUsers.submit();return true;'>
				<xsl:for-each select = "users/users_item" >
					<option value="{user_id}">
						<xsl:if test="user_id = /APPSHORE/APP/user/user_id">
							<xsl:attribute name="selected" select="'true'" />
					    </xsl:if>
				         <xsl:value-of select="full_name" />&#160;-&#160;<xsl:value-of select="user_name" />
				     </option>
				</xsl:for-each>	
			</select>
		</div>
	</div>
	
	<xsl:call-template name="footerGrantRolesForm">
		<xsl:with-param name="thisForm">grantRolesToUsers</xsl:with-param>
	</xsl:call-template> 
		
   <table cellSpacing='1' cellPadding='1' border='0' style="line-height:2em">	
		<tr class="label" align='center'>
			<td style='width:300px'>
				<xsl:value-of select="php:function('lang','Roles available')"/>
			</td>
			<td style='width:80px'>
				<xsl:value-of select="php:function('lang','Grant')"/>
			</td>
			<td style='width:300px'>
				<xsl:value-of select="php:function('lang','Roles granted')"/>
			</td>
		</tr>	
		<tr class="field" align='center'>	
			<td >
				<select style="width:100%" size="20" id="allroles" name="allroles" multiple="true" >
					<xsl:for-each select = "roles/roles_item" >
				       <xsl:if test="not(role_id = /APPSHORE/APP/user_roles/user_roles_item/role_id)">
							<option value="{role_id}">
				           		<xsl:value-of select="role_name" />
						     </option>
					   </xsl:if>
					</xsl:for-each>
				</select>
			</td>
			<td >
				<input type='button' class="formBarButton" style='width:40px' onclick='copyAll( allroles, roleids);removeAll(allroles);' value='&#62;&#62;' /><br/><br/><br/> 
				<input type='button' class="formBarButton" style='width:40px' onclick='copySelected( allroles, roleids);removeSelected(allroles);' value='&#62;' /><br/><br/><br/> 
				<input type='button' class="formBarButton" style='width:40px' onclick='copySelected( roleids, allroles);removeSelected(roleids);' value='&#60;' /><br/><br/><br/>
				<input type='button' class="formBarButton" style='width:40px' onclick='copyAll( roleids, allroles);removeAll(roleids);' value='&#60;&#60;' />								
			</td>
			<td >
				<select style="width:100%" size="20" id="roleids" name="roleids" multiple="true">
					<xsl:for-each select = "roles/roles_item[role_id = /APPSHORE/APP/user_roles/user_roles_item/role_id]" >
						<option value="{role_id}">
							<xsl:value-of select="role_name" />
						</option>
					</xsl:for-each>
				</select>				
			</td>
		</tr>
	</table>	
	
	<xsl:call-template name="footerGrantRolesForm">
		<xsl:with-param name="thisForm">grantRolesToUsers</xsl:with-param>
	</xsl:call-template> 
	
	</form>	
</xsl:template>

	
<xsl:template name="footerGrantRolesForm">
	<xsl:param name="thisForm"/>	

	<div class="clearboth">
		<input type="submit" class="formBarButton" name="Submit" onclick="passRolesList(roleids,selectedroles);document.{$thisForm}.key.value='Save'">
            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
        </input>&#160;			
		<input type="submit" class="formBarButton" name="Cancel">
            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
        </input>                					
	</div>
</xsl:template>


</xsl:stylesheet>
