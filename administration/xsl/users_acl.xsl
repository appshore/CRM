<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>
			
<xsl:template name='ipAccessControl'>	

	<script language="JavaScript" type="text/javascript" src="administration/js/users_acl.js"/>			

	<form name='ipAccessControl' method='post' >
	<input type='hidden' name='op' value='administration.users_acl.ipAccessControl'/>
	<input type="hidden" name="key" id="key"/>
	<input type='hidden' name='selectedaccess' value="" />
	
	<div class="formTitleTags start_float">
    	<xsl:value-of select="php:function('lang','IP access control')"/>
	</div>

	<div class="helpmsg">
		<xsl:value-of disable-output-escaping="yes" select="php:function('lang','administration.users_acl.help')"/>
	</div>

	<xsl:call-template name="footerGrantAccessForm">
		<xsl:with-param name="thisForm">ipAccessControl</xsl:with-param>
	</xsl:call-template> 

	<div class="clearboth formTable">
		<div class="clearboth fieldContainer" style="padding-top:10px">
			<div class="fieldLabel" title="{field_label}">
				<xsl:value-of select="php:function('lang','Public IP address')"/>&#160;
				<a class="fieldAssociatedLink" onclick="$('ipacl').value=addCurrentIP($('ipacl').value,'{public_ip_address}');"><xsl:value-of select="php:function('lang','Add to Company level')"/></a>
<!--				&#160;<a class="fieldAssociatedLink" onclick="$('ipacl_{/APPSHORE/API/current_user/user_id}').value=addCurrentIP($('ipacl_{/APPSHORE/API/current_user/user_id}').value,'{public_ip_address}');"><xsl:value-of select="php:function('lang','Add to Current user')"/></a>-->
			</div>
			<div class="fieldText">
				<xsl:value-of select="public_ip_address"/>
			</div>
		</div>
		<div class="clearboth fieldContainer" style="padding-top:10px">
			<div class="fieldLabel" title="{field_label}">
				<xsl:value-of select="php:function('lang','Activated')"/>
			</div>
			<div class="fieldText" style="width:90%">
				<input class="fieldInputCheckbox" id="is_ipacl" name="is_ipacl" onclick="is_boxchecked(this);" type="checkbox" value="{company/is_ipacl}" >
					<xsl:if test="company/is_ipacl = 'Y'">
						<xsl:attribute name="checked"/>
					</xsl:if>
				</input>
			</div>
		</div>
		<div class="clearboth fieldContainer" style="padding-top:10px">
			<div class="fieldLabel" title="{field_label}">
				<xsl:value-of select="php:function('lang','Company level')"/>
			</div>
			<div class="fieldText" style="width:90%">
				<textarea class="fieldTextarea" name="ipacl" id="ipacl" onblur="this.value=checkIP(this.value);">
					<xsl:value-of select="company/ipacl"/>
				</textarea>
			</div>
		</div>
		<div class="clearboth fieldContainer" style="padding-top:10px">
			<div class="fieldLabel">
				<xsl:value-of select="php:function('lang','User level')"/>
			</div>
			<div class="fieldText" >
				<xsl:for-each select = "users/users_item" >
					<xsl:choose>
						<xsl:when test="position() div 2">
							<div class="start_float " style="padding-top:5px;width:48%">
							 	<xsl:value-of select="full_name" />&#160;-&#160;<xsl:value-of select="user_name" /><br/>
								<textarea class="fieldInputTextarea" name="ipacl_{user_id}" id="ipacl_{user_id}" onchange="this.value=checkIP(this.value);">
									<xsl:value-of select="ipacl"/>
								</textarea>
							</div>
							<div class="start_float " style="width:20px">&#160;
							</div>
						</xsl:when>
						<xsl:otherwise>
							<div class="end_float" style="width:48%">
							 	<xsl:value-of select="full_name" />&#160;-&#160;<xsl:value-of select="user_name" /><br/>
								<textarea class="fieldInputTextarea" name="ipacl_{user_id}" id="ipacl_{user_id}" onchange="this.value=checkIP(this.value);">
									<xsl:value-of select="ipacl"/>
								</textarea>
							</div>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>	
			</div>
		</div>
	</div>
		
	<xsl:call-template name="footerGrantAccessForm">
		<xsl:with-param name="thisForm">ipAccessControl</xsl:with-param>
	</xsl:call-template> 
	
	</form>	
</xsl:template>

	
<xsl:template name="footerGrantAccessForm">
	<xsl:param name="thisForm"/>	

	<div class="clearboth">
		<input type="submit" class="formBarButton" name="Submit" onclick="document.{$thisForm}.key.value='Save'">
            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
        </input>&#160;			
		<input type="submit" class="formBarButton" name="Cancel">
            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
        </input>                					
	</div>
</xsl:template>


</xsl:stylesheet>
