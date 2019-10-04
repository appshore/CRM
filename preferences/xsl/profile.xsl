<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP[action/node()[name() = /APPSHORE/APP/recordset/appName]]">
    <table width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
			<td class="left_panel" id="left_panel" style="display:{/APPSHORE/API/cookie/left_panel}">
			    <xsl:call-template name="verticalMenus">		    
					<xsl:with-param name="appName">preferences</xsl:with-param>
					<xsl:with-param name="appLabel">Preferences</xsl:with-param>
				</xsl:call-template>	
			</td>
            <td class="right_panel" id="right_panel">
				<xsl:choose>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'view'">
				    	<xsl:call-template name="custom_view">
				    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
				    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabelSingular"/>
				    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appNameSingular"/>
				    		<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>
				    		<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>			    		
							<xsl:with-param name="delete">false</xsl:with-param>
							<xsl:with-param name="duplicate">false</xsl:with-param>		
							<xsl:with-param name="print">false</xsl:with-param>		
							<xsl:with-param name="assignedto">false</xsl:with-param>
				    	</xsl:call-template>				    					    	
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'edit'">
				    	<xsl:call-template name="custom_edit">
				    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
				    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabelSingular"/>
				    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appNameSingular"/>
				    		<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>	
				    		<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>			    		
							<xsl:with-param name="delete">false</xsl:with-param>
							<xsl:with-param name="duplicate">false</xsl:with-param>
							<xsl:with-param name="assignedto">false</xsl:with-param>
				    	</xsl:call-template>				    					    	
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'changePassword'">
				    	<xsl:call-template name="change_password">
				    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
				    	</xsl:call-template>				    	
					</xsl:when>					
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name="change_password">
	<xsl:param name="appName"/>

	<script language="JavaScript" type="text/javascript">
		<![CDATA[
		function passwordStrength(pwd, thisDiv)
		{
			var score = calcPwdStrength(pwd);
			
			if( score > 3 )	
				thisDiv.style.background = 'green';
			else if ( score > 2 )
				thisDiv.style.background = 'yellow';
			else
				thisDiv.style.background = 'red';
		}
		
		function calcPwdStrength(pwd)
		{
			var score = Math.round(pwd.length/3);

			if(/\w/.test(pwd) && /\d/.test(pwd))
				score++;

			if( pwd.toUpperCase() != pwd && pwd.toLowerCase() != pwd)
				score++;
			
			return score;
		}	
		]]>
		
		function isSamePassword(oldpwd, pwd1, pwd2)
		{
			var ret = true;
			
			if( oldpwd.length == 0 )
			{
				ret_msg = '<xsl:value-of select="php:function('lang','Please enter the old password')"/>'; 
				ret = false;
			}
			else if( pwd1 != pwd2 )
			{
				ret_msg = '<xsl:value-of select="php:function('lang','Please enter twice the same new password')"/>'; 
				ret = false;
			}
			else if( calcPwdStrength(pwd1) &lt; 2 )
			{
				ret_msg = '<xsl:value-of select="php:function('lang','New password is too weak')"/>'; 
				ret = false;
			}
			else if( ret == true &amp;&amp; oldpwd == pwd1 )
			{
				ret_msg = '<xsl:value-of select="php:function('lang','New password is same as the old one')"/>'; 
				ret = false;
			}
			
			if( ret == false )
				Dialog.alert('<div style="padding:10px">'+ret_msg+'</div>',{className:"dialog",title:getTranslation('common','Alert'),width:400,okLabel:getTranslation('common','Ok')});
				
			return ret;
		}	
	</script>


    <div class="clearboth formTitleTags">
       	<xsl:value-of select="php:function('lang','Change password')"/>
	</div>	
	
	<form name="change_password" method="post"   onsubmit="if( $('key').value == 'Save') return isSamePassword($('oldpassword').value,$('newpassword1').value,$('newpassword2').value);">
		<input type="hidden" name="op" id="op" value="preferences_profile.base.changePassword"/>
		<input type="hidden" name="key" id="key" />			

		<xsl:call-template name="passwordEditButtons">
			<xsl:with-param name="thisForm">change_password</xsl:with-param>		
		</xsl:call-template>			
		
		<div class="clearboth formTable">
			<div class="fieldContainer">
				<div class="fieldLabel" title="{field_label}">
					<xsl:value-of select="php:function('lang','Old password')"/>
				</div>
				<div class="fieldText"  style="height:2em">
					<input type="password" style="width:20em" name="oldpassword" id="oldpassword"/>
				</div>
			</div>
			<div class="fieldContainer">
				<div class="fieldLabel" title="{field_label}">
					<xsl:value-of select="php:function('lang','New password')"/>
				</div>
				<div class="fieldText" style="height:2em;">
					<input type="password" style="width:20em" name="newpassword1" id="newpassword1" onkeyup="passwordStrength(this.value, $('passmeter'));"/>
					&#160;<span id="passmeter" align="center" style="width:20em;background:red;height:2em">&#160;<xsl:value-of select="php:function('lang','Password strength')"/>&#160;</span>
				</div>
			</div>
			<div class="fieldContainer">
				<div class="fieldLabel" title="{field_label}">
					<xsl:value-of select="php:function('lang','Confirm new password')"/>
				</div>
				<div class="fieldText"  style="height:2em">
					<input type="password" style="width:20em" name="newpassword2" id="newpassword2"/>
				</div>
			</div>
		</div>

		<xsl:call-template name="passwordEditButtons">
			<xsl:with-param name="thisForm">change_password</xsl:with-param>		
		</xsl:call-template>			

	</form>
</xsl:template>

<xsl:template name="passwordEditButtons">
	<xsl:param name="thisForm"/>	
	
	<div class="clearboth formBar">
		<input type="submit" class="formBarButton" name="Save" id="Save" onclick="document.{$thisForm}.key.value=this.name">
	        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
	    </input>&#160;
		<input type="reset" class="formBarButton" name="Cancel" id="Cancel">
	        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Reset')"/></xsl:attribute>
	        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
	    </input>
	</div>	
</xsl:template>

</xsl:stylesheet>
