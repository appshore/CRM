<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP[action/emailer]">
    <table height="100%" width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
			<td class="left_panel" id="left_panel" style="display:{/APPSHORE/API/cookie/left_panel}">
			    <xsl:call-template name="verticalMenus">		    
					<xsl:with-param name="appName">administration</xsl:with-param>
					<xsl:with-param name="appLabel">Administration</xsl:with-param>
				</xsl:call-template>	
			</td>
            <td id="right_panel" class="right_panel">
				<xsl:choose>
					<xsl:when test="action/emailer = 'view'">
				    	<xsl:call-template name="emailer_view"/>
					</xsl:when>	
					<xsl:when test="action/emailer = 'edit'">
				    	<xsl:call-template name="emailer_edit"/>				    	
					</xsl:when>				    					
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name="emailer_view">

	<form name="emailer_view" method="post" >
		<input type="hidden" name="op" value="administration.emailer.view"/>
		<input type="hidden" name="company_id" >
			<xsl:attribute name="value"><xsl:value-of select="emailer/company_id" /></xsl:attribute>
		</input>
 	<xsl:call-template name="headerViewForm">
		<xsl:with-param name="labelParam"><xsl:value-of select="emailer/company_name" /></xsl:with-param>
		<xsl:with-param name="appLabel">Email</xsl:with-param>
		<xsl:with-param name="appName">emailer</xsl:with-param>
	</xsl:call-template>

	<div id="emailer">
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr>
			<td align="right" class="label" width="20%" ><xsl:value-of select="php:function('lang','From')"/>:</td>
			<td align="left" class="field" width="30%" ><xsl:value-of select="emailer/emailer_from"/></td>
			<td align="right" class="label" width="20%" ><xsl:value-of select="php:function('lang','Name')"/>:</td>
			<td align="left" class="field" width="30%" ><xsl:value-of select="emailer/emailer_fromname"/></td>
		</tr>
		<tr>
			<td align="right" class="label" ><xsl:value-of select="php:function('lang','Reply to')"/>:</td>
			<td align="left" class="field"  ><xsl:value-of select="emailer/emailer_replyto"/></td>
			<td align="right" class="label" ></td>
			<td align="left" class="field" ></td>
		</tr>		
		<tr>
			<td align="right" class="label" ><xsl:value-of select="php:function('lang','Protocol')"/>:</td>
			<td align="left" class="field"  ><xsl:value-of select="emailer/emailer_mailer"/></td>
			<td align="right" class="label" ></td>
			<td align="left" class="field"  ></td>			
		</tr>
		<xsl:if test = "emailer/emailer_mailer != 'sendmail'">				
			<tr>
				<td align="right" class="label" ><xsl:value-of select="php:function('lang','Email server')"/>:</td>
				<td align="left" class="field"  ><xsl:value-of select="emailer/emailer_host"/></td>
				<td align="right" class="label" ><xsl:value-of select="php:function('lang','Port')"/>:</td>
				<td align="left" class="field"  ><xsl:value-of select="emailer/emailer_port"/></td>			
			</tr>
			<tr>
				<td align="right" class="label" ><xsl:value-of select="php:function('lang','Authentication')"/>:</td>
				<td align="left" class="field"  ><xsl:value-of select="emailer/auth_name"/></td>	
				<td align="right" class="label" >SSL - TLS:</td>
				<td align="left" class="field"  ><xsl:value-of select="emailer/emailer_ssl"/></td>					
			</tr>
		</xsl:if>
		<tr >
			<td align="right" class="label" ><xsl:value-of select="php:function('lang','Note')"/>:</td>
			<td align="left" class="field"  colspan="4">
				<textarea cols="75" rows="3" name="note" readonly="true" class="textarea">
						<xsl:value-of select="emailer/note" />
				</textarea>
			</td>
		</tr>
        <tr >
			<td class="label" align="right" ><xsl:value-of select="php:function('lang','Creation')"/>:</td>
			<td align="left" class="field"  >
				<xsl:value-of select="emailer/created"/>&#160;<xsl:value-of select="php:function('lang','by')"/>&#160;<xsl:value-of select="emailer/created_by"/>
			</td>
			<td class="label" align="right" ><xsl:value-of select="php:function('lang','Last Update')"/>:</td>
			<td align="left" class="field"  >
				<xsl:value-of select="emailer/updated"/>&#160;<xsl:value-of select="php:function('lang','by')"/>&#160;<xsl:value-of select="emailer/updated_by"/>
			</td>
		</tr>		
	</table>
	<xsl:call-template name="footerViewForm">
		<xsl:with-param name="thisForm">emailer_view</xsl:with-param>
	</xsl:call-template>&#160;
	<input type='submit' class="formBarButton" onclick="document.emailer_view.key.value='Test'">
        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Send email')"/></xsl:attribute>
        <xsl:attribute name="title">Send email to test configuration</xsl:attribute>                            
    </input>	
	</div>
	</form>	
</xsl:template>


	
<xsl:template name='emailer_edit'>
	<form name='emailer_edit' method='post'>
		<input type="hidden" name="op" value="administration.emailer.edit"/>
		<input type="hidden" name="company_id" >
			<xsl:attribute name="value"><xsl:value-of select="emailer/company_id" /></xsl:attribute>
		</input>			
	<xsl:call-template name="headerEditForm">
		<xsl:with-param name="testParam"><xsl:value-of select="emailer/company_id" /></xsl:with-param>
		<xsl:with-param name="labelParam"><xsl:value-of select="emailer/company_name" /></xsl:with-param>
		<xsl:with-param name="appLabel">Email</xsl:with-param>
		<xsl:with-param name="appName">emailer</xsl:with-param>
	</xsl:call-template>
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr>
			<td align="right" class="mandatory_label" width="20%" ><xsl:value-of select="php:function('lang','Email')"/>:</td>
			<td align="left" class="field" width="30%" >
				<input type="text" size="35" name="emailer_from" >
					<xsl:attribute name="value">
						<xsl:value-of select="emailer/emailer_from" />
					</xsl:attribute>
				</input>
				<xsl:if test="/APPSHORE/APP/error/emailer_from">
                    <span class="failure">
                        <br/><xsl:value-of select="/APPSHORE/APP/error/emailer_from" />
                    </span>
                </xsl:if>					
			</td>
			<td align="right" class="label" width="20%" ><xsl:value-of select="php:function('lang','Name')"/>:</td>
			<td align="left" class="field" width="30%" >
				<input type="text" size="35" name="emailer_fromname" >
					<xsl:attribute name="value">
						<xsl:value-of select="emailer/emailer_fromname" />
					</xsl:attribute>
				</input>
			</td>			
		</tr>
		<tr>
			<td align="right" class="label" ><xsl:value-of select="php:function('lang','Protocol')"/>:</td>
			<td align="left" class="field" >
				<select name="emailer_mailer" >
					<xsl:attribute name="onchange">
						$('mailer').setStyle({
							display: ( (this.value == 'sendmail') ? 'none' : 'block' )
							});

					</xsl:attribute>
					<xsl:for-each select = "mailers/mailers_item" >
						<xsl:choose>
							<xsl:when test="emailer_mailer = /APPSHORE/APP/emailer/emailer_mailer">
								<option selected="true">
									<xsl:attribute name="value"><xsl:value-of select="emailer_mailer" /></xsl:attribute>
									<xsl:value-of select="emailer_mailer"/>
								</option>
							</xsl:when>
							<xsl:otherwise>
								<option>
									<xsl:attribute name="value"><xsl:value-of select="emailer_mailer" /></xsl:attribute>
									<xsl:value-of select="emailer_mailer"/>
								</option>
							</xsl:otherwise>
						</xsl:choose>			
					</xsl:for-each>
				</select>		
			</td>
			<td align="right" class="label" ></td>
			<td align="left" class="field"  ></td>
		</tr>	
	</table>
		<div id="mailer" >
	<table border="0" width="100%" cellpadding="1" cellspacing="1" >
		<tr>
			<td align="right" class="mandatory_label" width="20%" ><xsl:value-of select="php:function('lang','Email server')"/>:</td>
			<td align="left" class="field" width="30%" >
				<input type="text" size="35" name="emailer_host" >
					<xsl:attribute name="value">
						<xsl:value-of select="emailer/emailer_host" />
					</xsl:attribute>
				</input>
				<xsl:if test="/APPSHORE/APP/error/emailer_host">
                    <span class="failure">
                        <br/><xsl:value-of select="/APPSHORE/APP/error/emailer_host" />
                    </span>
                </xsl:if>					
			</td>	
			<td align="right" class="label" width="20%" ><xsl:value-of select="php:function('lang','Port')"/>:</td>
			<td align="left" class="field" width="30%" >
				<input type="text" size="5" name="emailer_port" >
					<xsl:attribute name="value">
						<xsl:value-of select="emailer/emailer_port" />
					</xsl:attribute>
				</input>
				<xsl:if test="/APPSHORE/APP/error/emailer_port">
                    <span class="failure">
                        <br/><xsl:value-of select="/APPSHORE/APP/error/emailer_port" />
                    </span>
                </xsl:if>					
			</td>			
		</tr>				
		<tr>
			<td align="right" class="mandatory_label" width="20%" ><xsl:value-of select="php:function('lang','Username')"/>:</td>
			<td align="left" class="field" width="30%" >
				<input type="text" size="35" name="emailer_username" >
					<xsl:attribute name="value">
						<xsl:value-of select="emailer/emailer_username" />
					</xsl:attribute>
				</input>
				<xsl:if test="/APPSHORE/APP/error/emailer_username">
                    <span class="failure">
                        <br/><xsl:value-of select="/APPSHORE/APP/error/emailer_username" />
                    </span>
                </xsl:if>					
			</td>
			<td align="right" class="label" width="20%" ><xsl:value-of select="php:function('lang','Password')"/>:</td>
			<td align="left" class="field" width="30%" >
				<input type="password" size="20" name="emailer_password" value=""/>								
			</td>		
		</tr>	
		<tr>
			<td align="right" class="label" ><xsl:value-of select="php:function('lang','Authentication')"/>:</td>
			<td align="left" class="field"  >
				<select name="emailer_auth"  >
					<xsl:for-each select = "auths/auths_item" >
						<xsl:choose>
							<xsl:when test="emailer_auth = /APPSHORE/APP/emailer/emailer_auth">
								<option selected="true">
									<xsl:attribute name="value"><xsl:value-of select="emailer_auth" /></xsl:attribute>
									<xsl:value-of select="auth_name"/>
								</option>
							</xsl:when>
							<xsl:otherwise>
								<option>
									<xsl:attribute name="value"><xsl:value-of select="emailer_auth" /></xsl:attribute>
									<xsl:value-of select="auth_name"/>
								</option>
							</xsl:otherwise>
						</xsl:choose>			
					</xsl:for-each>
				</select>		
			</td>
			<td align="right" class="label" >SSL - TLS:</td>
			<td align="left" class="field" >
				<select name="emailer_ssl" >
					<xsl:for-each select = "ssls/ssls_item" >
						<xsl:choose>
							<xsl:when test="emailer_auth = /APPSHORE/APP/emailer/emailer_ssl">
								<option selected="true">
									<xsl:attribute name="value"><xsl:value-of select="emailer_ssl" /></xsl:attribute>
									<xsl:value-of select="ssl_name"/>
								</option>
							</xsl:when>
							<xsl:otherwise>
								<option>
									<xsl:attribute name="value"><xsl:value-of select="emailer_ssl" /></xsl:attribute>
									<xsl:value-of select="ssl_name"/>
								</option>
							</xsl:otherwise>
						</xsl:choose>			
					</xsl:for-each>
				</select>		
			</td>			
		</tr>	
	</table>
	</div>		
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr >
			<td align="right" class="label" width="20%" ><xsl:value-of select="php:function('lang','Note')"/>:</td>
			<td align="left" class="field"  width="80%" colspan="4">				
				<textarea class="formtextarea" cols="75" rows="3" name="note" >
						<xsl:value-of select="emailer/note" />
				</textarea>
			</td>
		</tr>	
	</table>

	<xsl:call-template name="footerEditForm">
		<xsl:with-param name="testParam"><xsl:value-of select="emailer/company_id" /></xsl:with-param>
		<xsl:with-param name="thisForm">emailer_edit</xsl:with-param>
	</xsl:call-template>&#160;
	<input type='submit' class="formBarButton" onclick="document.emailer_view.key.value='Test'">
        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Send email')"/></xsl:attribute>
        <xsl:attribute name="title">Send email to test configuration</xsl:attribute>                            
    </input>	
	
	</form>	
</xsl:template>

</xsl:stylesheet>
