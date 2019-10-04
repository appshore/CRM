<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name='setup_accounts'>	
	
	<script type="text/javascript" src="{$lib_js_path}/form.js"/>		
	<script type="text/javascript">
		var fieldRequired = new Array();
		var fieldDescription = new Array();
		var	fieldInc = 0;
		fieldRequired[0] = 'account_name';
		fieldDescription[0] = '<xsl:value-of select="php:function('lang','Name')"/>';
		fieldRequired[1] = 'email';
		fieldDescription[1] = '<xsl:value-of select="php:function('lang','Email')"/>';
		fieldRequired[2] = 'pop3_username';
		fieldDescription[2] = '<xsl:value-of select="php:function('lang','Username')"/>';
		fieldRequired[3] = 'pop3_server';
		fieldDescription[3] = '<xsl:value-of select="php:function('lang','POP3 server')"/>';
		fieldRequired[4] = 'pop3_port';
		fieldDescription[4] = '<xsl:value-of select="php:function('lang','POP3 server port')"/>';
	</script>
	
	<br/>
<!--	<div class="helpmsg">-->
<!--		<xsl:value-of select="php:function('lang','Inbound webmail is a new feature that will stay on beta test for few weeks')"/>.-->
<!--		<xsl:value-of select="php:function('lang','Please report issues to support@appshore.com')"/><br/>-->
<!--		<xsl:value-of select="php:function('lang','The parameter')"/><font class="fieldLabel"> Leave messages on server </font>-->
<!--		<xsl:value-of select="php:function('lang','is forced as checked during this test period')"/>.-->
<!--	</div>	-->

	<div class="helpmsg">
		<xsl:value-of disable-output-escaping="yes" select="php:function('lang','webmail.setup_accounts.help')"/>
	</div>	
		
	<form name="accounts" method="post" onsubmit="return formCheck(this, fieldRequired, fieldDescription);">
		<input type='hidden' id="op" name='op' value='webmail.setup_accounts.edit'/>
		<input type='hidden' id="key" name='key' value=''/>

		<div>
			<xsl:value-of select="php:function('lang','Accounts list')"/>
		</div>
		<div>
			<select class="fieldInputSelect" name="account_id" id="account_id" onchange="document.accounts.key.value='';document.accounts.submit();">
					<option/>				
				<xsl:for-each select = "accounts/accounts_item" >
					<option value="{account_id}">
						<xsl:if test="account_id = /APPSHORE/APP/account/account_id">
							<xsl:attribute name="selected" value="true" />
						</xsl:if>
						<xsl:value-of select="account_name" />
					</option>
				</xsl:for-each>	
			</select>
		</div>
		<br/>
		
		<xsl:call-template name="buttons_setup_accounts"/>

		<div class="formTable" style="width:99%">
			<div class="fieldLabelContainer">
				<div class="fieldLabel">
					<xsl:value-of select="php:function('lang','Active')"/>
				</div>
				<div>
					<input class="fieldInputCheckbox" type="checkbox" id="is_enable" name="is_enable" value="{account/is_enable}" onclick="is_boxchecked(this);" >
						<xsl:if test="account/is_enable = 'Y'">
							<xsl:attribute name="checked"/>
						</xsl:if>
					</input>									
				</div>
			</div>				
			<div class="fieldLabelContainer">
				<div class="fieldLabel fieldLabelMandatory">
					<xsl:value-of select="php:function('lang','Name')"/>
				</div>
				<div style="width:50%">
					<input class="fieldInputText" type="text" id="account_name" name="account_name" >
						<xsl:attribute name="value"><xsl:value-of select="account/account_name" /></xsl:attribute>
					</input>
				</div>
			</div>				
			<div class="fieldLabelContainer">
				<div class="fieldLabel fieldLabelMandatory">
					<xsl:value-of select="php:function('lang','Email')"/>
				</div>
				<div style="width:50%">
					<input class="fieldInputText" type="text" id="email" name="email" >
						<xsl:attribute name="value"><xsl:value-of select="account/email" /></xsl:attribute>
					</input>
				</div>
			</div>				
			<div class="fieldLabelContainer">
				<div class="fieldLabel fieldLabelMandatory">
					<xsl:value-of select="php:function('lang','Username')"/>
				</div>
				<div style="width:50%">
					<input class="fieldInputText" type="text" id="pop3_username" name="pop3_username" >
						<xsl:attribute name="value"><xsl:value-of select="account/pop3_username" /></xsl:attribute>
					</input>
				</div>
			</div>				
			<div class="fieldLabelContainer">
				<div class="fieldLabel">
					<xsl:value-of select="php:function('lang','Password')"/>
				</div>
				<div style="width:50%">
					<input class="fieldInputPassword" type="password" id="pop3_password" name="pop3_password"/>
				</div>
			</div>				
			<div class="fieldLabelContainer">
				<div class="fieldLabel fieldLabelMandatory">
					<xsl:value-of select="php:function('lang','POP3 server')"/>
				</div>
				<div style="width:50%">
					<input class="fieldInputText" type="text" id="pop3_server" name="pop3_server" >
						<xsl:attribute name="value"><xsl:value-of select="account/pop3_server" /></xsl:attribute>
					</input>				
				</div>
			</div>				
			<div class="fieldLabelContainer">
				<div class="fieldLabel fieldLabelMandatory">
					<xsl:value-of select="php:function('lang','POP3 server port')"/>
				</div>
				<div>
					<select class="fieldInputSelect" name="pop3_port" id="pop3_port">
							<option/>				
						<xsl:for-each select = "pop3ports/pop3ports_item" >
							<option value="{pop3_port}">
								<xsl:if test="pop3_port = /APPSHORE/APP/account/pop3_port">
									<xsl:attribute name="selected" value="true" />
								</xsl:if>
								<xsl:value-of select="pop3_port" />
							</option>
						</xsl:for-each>	
					</select>
				</div>
			</div>				
			<div class="fieldLabelContainer">
				<div class="fieldLabel">
					<xsl:value-of select="php:function('lang','Secure connection (SSL)')"/>
				</div>
				<div>
					<input class="fieldInputCheckbox" type="checkbox" id="pop3_ssl" name="pop3_ssl" value="{account/pop3_ssl}" onclick="is_boxchecked(this);" >
						<xsl:if test="account/pop3_ssl = 'Y'">
							<xsl:attribute name="checked"/>
						</xsl:if>
					</input>									
				</div>
			</div>				
<!--			<div class="fieldLabelContainer">-->
<!--				<div class="fieldLabel">-->
<!--					<xsl:value-of select="php:function('lang','Leave messages on server')"/>-->
<!--				</div>-->
<!--				<div>-->
<!--					<input class="fieldInputCheckbox" type="checkbox" id="pop3_lmos" name="pop3_lmos" value="{account/pop3_lmos}" onclick="is_boxchecked(this);" >-->
<!--						<xsl:if test="account/pop3_lmos = 'Y'">-->
<!--							<xsl:attribute name="checked"/>-->
<!--						</xsl:if>-->
<!--					</input>									-->
<!--				</div>-->
<!--			</div>				-->
		</div>		
		
		<xsl:call-template name="buttons_setup_accounts"/>		

	</form>

</xsl:template>

<xsl:template name="buttons_setup_accounts">	
	<div class="formBar">	
		<input type="submit" class="formBarButton" id="New"  name="New" onclick="document.accounts.account_id.value='';document.accounts.key.value=this.name;">
			<xsl:attribute name="value"><xsl:value-of select="php:function('lang','New')"/></xsl:attribute>
		</input>&#160;
		<input type="submit" class="formBarButton"  id="Save" name="Save" onclick="document.accounts.key.value=this.name;">
			<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
		</input>&#160;	
		<input type="submit" class="formBarButton" id="Delete" name="Delete" onclick="document.accounts.key.value=this.name;">
			<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Delete')"/></xsl:attribute>
		</input>&#160;	
		<input type="submit" class="formBarButton" id="Test" name="Test" onclick="document.accounts.key.value=this.name;">
			<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Test connection')"/></xsl:attribute>
		</input>
	</div>
</xsl:template>

</xsl:stylesheet>
