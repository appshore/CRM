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
				    	<xsl:call-template name="roles_start"/>
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'view'">
				    	<xsl:call-template name="custom_view">
				    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
				    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabelSingular"/>
				    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appNameSingular"/>
				    		<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>	
				    		<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>			    		
							<xsl:with-param name="assignedto">false</xsl:with-param>
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
				    	</xsl:call-template>				    					    	
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'grantPermissionsToRoles'">
				    	<xsl:call-template name="grantPermissionsToRoles"/>
					</xsl:when>
					<xsl:otherwise>
				    	<xsl:call-template name="custom_actions"/>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name="roles_start">
	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Roles</xsl:with-param>
	</xsl:call-template>
    <div>
		<xsl:value-of disable-output-escaping="yes" select="php:function('lang','administration.roles.start')"/>
	</div>
</xsl:template>

<xsl:template name='grantPermissionsToRoles'>	
	<script LANGUAGE="JavaScript" >
	<![CDATA[

	function computeAND( prev, val) 
	{				
		prev &= val;
		return prev;
	}
		
	]]>
	</script>

	<form name='grantPermissionsToRoles' method='post' >
		<input type='hidden' name='op' id="op" value='administration.roles_base.grantPermissionsToRoles'/>	
		<input type="hidden" name="key" id="key"/>
	
	<div class="formTitleTags start_float">
    	<xsl:value-of select="php:functionString('lang','Grant permissions')"/>
	</div>
	
	<div class="clearboth fieldLabelContainer" style="padding:10px 0 10px 0">
		<div class="fieldLabel start_float">
			<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Select a role')"/></xsl:attribute>
			<xsl:value-of select="php:function('lang','Select a role')"/>
		</div>
		<div class="clearboth fieldText" >
			<select style='width:250px' id="role_id" name="role_id" onchange="grantPermissionsToRoles.submit();return true;">
				<xsl:for-each select = "roles/roles_item" >
					<option value="{role_id}">
						<xsl:if test="role_id = /APPSHORE/APP/role/role_id">
							<xsl:attribute name="selected" value="true" />
					    </xsl:if>
				         <xsl:value-of select="role_name" />
				     </option>
				</xsl:for-each>	
			</select>
		</div>
	</div>

	<xsl:call-template name="footerPermissionsForm">
		<xsl:with-param name="thisForm">grantPermissionsToRoles</xsl:with-param>
	</xsl:call-template> 
	
    <table cellSpacing='1' cellPadding='1' border='0' width='100%' style="line-height:2em">	
		<tr class="label" align='center'>
			<td rowspan="2">
				<xsl:value-of select="php:function('lang','Applications')"/>
			</td>
			<td colspan="2">
				<xsl:value-of select="php:function('lang','User')"/>
			</td>
			<td colspan="2">
				<xsl:value-of select="php:function('lang','Role')"/>
			</td>
			<td colspan="2">
				<xsl:value-of select="php:function('lang','Public')"/>
			</td>
			<td rowspan="2">
				<xsl:value-of select="php:function('lang','Import')"/>
			</td>
			<td rowspan="2">
				<xsl:value-of select="php:function('lang','Export')"/>
			</td>
			<td rowspan="2">
				<xsl:value-of select="php:function('lang','Administration')"/>
			</td>
		</tr>
		
		<tr class="label" align='center'>
			<td>
				<xsl:value-of select="php:function('lang','Read')"/>
			</td>
			<td>
				<xsl:value-of select="php:function('lang','Write')"/>
			</td>
			<td>
				<xsl:value-of select="php:function('lang','Read')"/>
			</td>
			<td>
				<xsl:value-of select="php:function('lang','Write')"/>
			</td>
			<td>
				<xsl:value-of select="php:function('lang','Read')"/>
			</td>
			<td>
				<xsl:value-of select="php:function('lang','Write')"/>
			</td>
		</tr>
		
		<xsl:for-each select = "apps/apps_item" >
			<input type='hidden' name="app_{app_name}_level" value="{level}"/>	

			<tr align='center' class="unselectedtext" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
				<td align='left' >
					<xsl:value-of select="app_label"/>
				</td>
				<td>
					<input type="checkbox" name="app_{app_name}_ur"  value="{ur}">
						<xsl:attribute name="onclick">
							if ( app_<xsl:value-of select="app_name"/>_ur.checked == true )
							{
								app_<xsl:value-of select="app_name"/>_exp.checked=true;							
								app_<xsl:value-of select="app_name"/>_exp.value=1;							
								app_<xsl:value-of select="app_name"/>_level.value = 1;								
							}				
							else
							{
								app_<xsl:value-of select="app_name"/>_uw.checked=false;							
								app_<xsl:value-of select="app_name"/>_rr.checked=false;								
								app_<xsl:value-of select="app_name"/>_rw.checked=false;								
								app_<xsl:value-of select="app_name"/>_pr.checked=false;
								app_<xsl:value-of select="app_name"/>_pw.checked=false;
								app_<xsl:value-of select="app_name"/>_imp.checked=false;
								app_<xsl:value-of select="app_name"/>_imp.value=0;							
								app_<xsl:value-of select="app_name"/>_exp.checked=false;							
								app_<xsl:value-of select="app_name"/>_exp.value=0;							
								app_<xsl:value-of select="app_name"/>_adm.checked=false;
								app_<xsl:value-of select="app_name"/>_level.value = 0;
							}		
						</xsl:attribute>
						<xsl:if test="ur > 0">					
							<xsl:attribute name="checked"/>
						</xsl:if>
					</input>				
				</td>					
				<td>
					<input type="checkbox" name="app_{app_name}_uw"  value="{uw}">
						<xsl:attribute name="onclick">
							if ( app_<xsl:value-of select="app_name"/>_uw.checked == true )
							{
								app_<xsl:value-of select="app_name"/>_ur.checked=true;
								app_<xsl:value-of select="app_name"/>_imp.checked=true;
								app_<xsl:value-of select="app_name"/>_imp.value=1;							
								app_<xsl:value-of select="app_name"/>_exp.checked=true;							
								app_<xsl:value-of select="app_name"/>_exp.value=1;							
								app_<xsl:value-of select="app_name"/>_level.value |= 3;
							}
							else
							{
								app_<xsl:value-of select="app_name"/>_level.value = computeAND( app_<xsl:value-of select="app_name"/>_level.value, 21);
								app_<xsl:value-of select="app_name"/>_rw.checked=false;								
								app_<xsl:value-of select="app_name"/>_pw.checked=false;
								app_<xsl:value-of select="app_name"/>_imp.checked=false;
								app_<xsl:value-of select="app_name"/>_imp.value=0;							
								app_<xsl:value-of select="app_name"/>_adm.checked=false;								
							}
						</xsl:attribute>
						<xsl:if test="uw > 0">					
							<xsl:attribute name="checked"/>
						</xsl:if>
					</input>
				</td>
				<td>
					<input type="checkbox"  name="app_{app_name}_rr"  value="{rr}">
						<xsl:attribute name="onclick">
							if ( app_<xsl:value-of select="app_name"/>_rr.checked == true )
							{
								app_<xsl:value-of select="app_name"/>_ur.checked=true;
								app_<xsl:value-of select="app_name"/>_exp.checked=true;							
								app_<xsl:value-of select="app_name"/>_exp.value=1;							
								app_<xsl:value-of select="app_name"/>_level.value |= 5;
							}
							else
							{
								app_<xsl:value-of select="app_name"/>_level.value = computeAND( app_<xsl:value-of select="app_name"/>_level.value, 3);
								app_<xsl:value-of select="app_name"/>_rw.checked=false;								
								app_<xsl:value-of select="app_name"/>_pr.checked=false;
								app_<xsl:value-of select="app_name"/>_pw.checked=false;
								app_<xsl:value-of select="app_name"/>_adm.checked=false;								
							}
						</xsl:attribute>
						<xsl:if test="rr > 0">					
							<xsl:attribute name="checked"/>
						</xsl:if>
					</input>				
				</td>					
				<td>
					<input type="checkbox" name="app_{app_name}_rw"  value="{rw}">
						<xsl:attribute name="onclick">
							if ( app_<xsl:value-of select="app_name"/>_rw.checked == true )
							{
								app_<xsl:value-of select="app_name"/>_ur.checked=true;
								app_<xsl:value-of select="app_name"/>_uw.checked=true;
								app_<xsl:value-of select="app_name"/>_rr.checked=true;
								app_<xsl:value-of select="app_name"/>_imp.checked=true;
								app_<xsl:value-of select="app_name"/>_imp.value=1;							
								app_<xsl:value-of select="app_name"/>_exp.checked=true;							
								app_<xsl:value-of select="app_name"/>_exp.value=1;							
								app_<xsl:value-of select="app_name"/>_level.value |= 15;
							}
							else
							{
								app_<xsl:value-of select="app_name"/>_level.value = computeAND( app_<xsl:value-of select="app_name"/>_level.value, 23);
								app_<xsl:value-of select="app_name"/>_pw.checked=false;
								app_<xsl:value-of select="app_name"/>_adm.checked=false;								
							}	
						</xsl:attribute>
						<xsl:if test="rw > 0">					
							<xsl:attribute name="checked"/>
						</xsl:if>
					</input>
				</td>
				<td>
					<input type="checkbox"  name="app_{app_name}_pr"  value="{pr}">
						<xsl:attribute name="onclick">
							if ( app_<xsl:value-of select="app_name"/>_pr.checked == true )
							{
								app_<xsl:value-of select="app_name"/>_ur.checked=true;
								app_<xsl:value-of select="app_name"/>_rr.checked=true;
								app_<xsl:value-of select="app_name"/>_exp.checked=true;							
								app_<xsl:value-of select="app_name"/>_exp.value=1;							
								app_<xsl:value-of select="app_name"/>_level.value |= 21;
							}
							else
							{
								app_<xsl:value-of select="app_name"/>_level.value = computeAND( app_<xsl:value-of select="app_name"/>_level.value, 15);
								app_<xsl:value-of select="app_name"/>_pw.checked=false;
								app_<xsl:value-of select="app_name"/>_adm.checked=false;								
							}		
						</xsl:attribute>
						<xsl:if test="pr > 0">					
							<xsl:attribute name="checked"/>
						</xsl:if>
					</input>				
				</td>					
				<td>
					<input type="checkbox" name="app_{app_name}_pw"  value="{pw}">
						<xsl:attribute name="onclick">
							if ( app_<xsl:value-of select="app_name"/>_pw.checked == true )
							{
								app_<xsl:value-of select="app_name"/>_ur.checked=true;
								app_<xsl:value-of select="app_name"/>_uw.checked=true;
								app_<xsl:value-of select="app_name"/>_rr.checked=true;
								app_<xsl:value-of select="app_name"/>_rw.checked=true;	
								app_<xsl:value-of select="app_name"/>_pr.checked=true;
								app_<xsl:value-of select="app_name"/>_imp.checked=true;
								app_<xsl:value-of select="app_name"/>_imp.value=1;							
								app_<xsl:value-of select="app_name"/>_exp.checked=true;							
								app_<xsl:value-of select="app_name"/>_exp.value=1;							
								app_<xsl:value-of select="app_name"/>_level.value |= 63;	
							}
							else
							{
								app_<xsl:value-of select="app_name"/>_level.value = computeAND( app_<xsl:value-of select="app_name"/>_level.value, 31);
								app_<xsl:value-of select="app_name"/>_adm.checked=false;								
							}		
						</xsl:attribute>
						<xsl:if test="pw > 0">					
							<xsl:attribute name="checked"/>
						</xsl:if>
					</input>
				</td>	
				<td >
					<input type="checkbox" name="app_{app_name}_imp"  value="{imp}">
						<xsl:attribute name="onclick">
							if ( app_<xsl:value-of select="app_name"/>_imp.checked == true )
							{
								app_<xsl:value-of select="app_name"/>_imp.value=1;							
								app_<xsl:value-of select="app_name"/>_ur.checked=true;
								app_<xsl:value-of select="app_name"/>_uw.checked=true;
								app_<xsl:value-of select="app_name"/>_level.value |= 3;
							}
							else
							{
								app_<xsl:value-of select="app_name"/>_imp.value = 0;							
								app_<xsl:value-of select="app_name"/>_adm.checked = false;								
								app_<xsl:value-of select="app_name"/>_level.value = computeAND( app_<xsl:value-of select="app_name"/>_level.value, 63);	
							}
						</xsl:attribute>
						<xsl:if test="imp > 0">					
							<xsl:attribute name="checked"/>
						</xsl:if>
					</input>
				</td>
				<td >
					<input type="checkbox" name="app_{app_name}_exp"  value="{exp}">
						<xsl:attribute name="onclick">
							if ( app_<xsl:value-of select="app_name"/>_exp.checked == true )
							{
								app_<xsl:value-of select="app_name"/>_exp.value = 1;							
								app_<xsl:value-of select="app_name"/>_ur.checked = true;
								app_<xsl:value-of select="app_name"/>_level.value |= 1;
							}
							else
							{
								app_<xsl:value-of select="app_name"/>_exp.value = 0;							
								app_<xsl:value-of select="app_name"/>_adm.checked = false;								
								app_<xsl:value-of select="app_name"/>_level.value = computeAND( app_<xsl:value-of select="app_name"/>_level.value, 63);	
							}
						</xsl:attribute>
						<xsl:if test="exp > 0">					
							<xsl:attribute name="checked"/>
						</xsl:if>
					</input>
				</td>
				
				<td >
					<input type="checkbox" name="app_{app_name}_adm"  value="{adm}">
						<xsl:attribute name="onclick">
							if ( app_<xsl:value-of select="app_name"/>_adm.checked == true )
							{
								app_<xsl:value-of select="app_name"/>_ur.checked=true;
								app_<xsl:value-of select="app_name"/>_uw.checked=true;
								app_<xsl:value-of select="app_name"/>_rr.checked=true;
								app_<xsl:value-of select="app_name"/>_rw.checked=true;
								app_<xsl:value-of select="app_name"/>_pr.checked=true;
								app_<xsl:value-of select="app_name"/>_pw.checked=true;							
								app_<xsl:value-of select="app_name"/>_imp.checked=true;
								app_<xsl:value-of select="app_name"/>_imp.value=1;							
								app_<xsl:value-of select="app_name"/>_exp.checked=true;							
								app_<xsl:value-of select="app_name"/>_exp.value=1;							
								app_<xsl:value-of select="app_name"/>_level.value |= 127;
							}
							else
							{
								app_<xsl:value-of select="app_name"/>_level.value = computeAND( app_<xsl:value-of select="app_name"/>_level.value, 63);	
							}
						</xsl:attribute>
						<xsl:if test="adm > 0">					
							<xsl:attribute name="checked"/>
						</xsl:if>
					</input>
				</td>
        	</tr>
        </xsl:for-each>		
	</table>

	<xsl:call-template name="footerPermissionsForm">
		<xsl:with-param name="thisForm">grantPermissionsToRoles</xsl:with-param>
	</xsl:call-template> 
	
	</form>	
</xsl:template>

<xsl:template name="footerPermissionsForm">
	<xsl:param name="thisForm"/>	

	<div class="clearboth">
		<xsl:if test="/APPSHORE/APP/scope > 0 "> 	
			<input type="submit" class="formBarButton" id="Save" name="Save" onclick="document.{$thisForm}.key.value='Save'">
	            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
	        </input>&#160;        	
		</xsl:if>  	
		<input type="submit" class="formBarButton" id="Cancel" name="Cancel">
	        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
	    </input>
	</div>
</xsl:template>


</xsl:stylesheet>
