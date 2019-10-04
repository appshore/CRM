<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="/">		
	<html>
		<head>
			<xsl:call-template name="commonHead"/>

			<link rel="stylesheet" type="text/css" href="includes/prototype/windows/themes/default.css"/>

			<xsl:call-template name="common_javascript"/>

			<script type="text/javascript" src="includes/overlibmws/overlibmws.js"/>
			<script type="text/javascript" src="includes/prototype/cookie.js"/>
			<script type="text/javascript" src="includes/prototype/Growler.js"/>
			<xsl:if test = "/APPSHORE/API/notifications">
				<script type="text/javascript" src="{$lib_js_path}/notifications.js?language={/APPSHORE/API/current_user/language_id}"/>		
			</xsl:if>
			
			<xsl:if test = "/APPSHORE/API/google_tracker">
				<!-- Google analytics -->
				<script type="text/javascript">
					var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
					document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
				</script>
				<script type="text/javascript">
					try {
					var pageTracker = _gat._getTracker('<xsl:value-of select="/APPSHORE/API/google_tracker"/>');
					pageTracker._trackPageview();
					} catch(err) {}
				</script>
			</xsl:if>
		</head>
		<body id='main'>		
			<div id="notification" style="position:absolute; left:1em; top:1em; visibility:hidden;"/>
			<xsl:apply-templates select="/APPSHORE/API/messages" />

			<xsl:choose>
				<!-- Normal APP output -->
				<xsl:when test="/APPSHORE/APP/action/auth = 'login'">
					<xsl:call-template name="login"/>
				</xsl:when>
				<xsl:when test="/APPSHORE/APP/action/auth = 'recovery'">
					<xsl:call-template name="recovery"/>
				</xsl:when>
				<!-- HTML output -->
				<xsl:when test="/APPSHORE/APPHTML">
					<xsl:value-of disable-output-escaping="yes" select="/APPSHORE/APPHTML" />
				</xsl:when>
			</xsl:choose>	

			<script type="text/javascript" >
				var growler = new Growler();
			</script>	 
		</body>
	</html>	
</xsl:template> 

<xsl:template name="headerAuth">
	<xsl:call-template name="main_window_header"/>
	<script language="JavaScript" type="text/javascript" >
		if ( Cookie.get('APPSESSID') != sid &amp;&amp; Cookie.get('language') == '' )
			document.observe("dom:loaded", function() {
				top.growler.error('<xsl:value-of select="php:function('lang','Please enable the cookie feature on your browser to improve your experience.')"/>');
			});
	</script>
</xsl:template>

<xsl:template name="login">
	<xsl:call-template name="headerAuth"/>

	<div align="center" style="width:100%;">

		<xsl:choose>
			<xsl:when test = "/APPSHORE/API/server/subdomain = 'demo'">
				<div style="font-size:14px;font-weight:bold;line-height:3em;color:green;text-align:center;width:100%">
					<xsl:value-of select="php:function('lang','Demonstration account, the data set is automatically reinitialized every hour')"/>
				</div>
				<div class="clearboth" style="height:120px;width:400px" valign="middle">
					<div class="start_float" style="width:50%">
						<strong>Administrative Demonstration</strong>
						<div>username: admin</div>
						<div>password: admin</div>
					</div>
					<div class="end_float">
						<strong>End User Demonstration</strong>
						<div>username: user</div>
						<div>password: user</div>
					</div>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div class="clearboth" style="height:120px"/>
			</xsl:otherwise>
		</xsl:choose>
		
			
		<div class="row_off" style="width:550px">
			<xsl:call-template name="rounded"><xsl:with-param name="row" select="'ton'" /></xsl:call-template>
<!--			<div valign="middle" class="row_on label" style="padding-bottom:5px;padding-left:5px">-->
<!--				<div class="start_direction">-->
<!--					<xsl:value-of select="php:function('lang','Login to')"/>&#160;<xsl:value-of select="/APPSHORE/API/customer_name"/>-->
<!--				</div>-->
<!--			</div>-->
			<form method="post" name="login" action="{$baseurl}">
			<input type="hidden" id="op" name="op" value="base.auth.login" />
			<input type="hidden" id="passwd_type" name="passwd_type" value="text" />
			<input type="hidden" id="nextop" name="nextop" value="{/APPSHORE/APP/nextop}" />
			<table cellspacing="0" cellpadding="5" width="100%" border="0" class="row_off">
				<tr valign="middle" class="row_on">
					<td class="start_direction formBlockTitle">
						<xsl:value-of select="php:function('lang','Login to')"/>&#160;<xsl:value-of select="/APPSHORE/API/customer_name"/>
					</td>
					<td class="end_direction">
						<select class="row_off" name="forced_language_id" onchange="if(this.selectedIndex==0)return false;Cookie.set('language',this.options[this.selectedIndex].value);window.location.reload();">
								<option value="default" style="color:gray"></option>				
							<xsl:for-each select = "/APPSHORE/API/languages/languages_item" >
								<option value="{language_id}">
									<xsl:if test="language_id = /APPSHORE/API/current_user/language_id">
										<xsl:attribute name="selected" value="true"/>
									</xsl:if>
									<xsl:value-of select="language_name"/>
								</option>
							</xsl:for-each>
						</select>	
					</td>
				</tr>
				<tr >
					<td class="end_direction" width="45%">
						<br/>
						<xsl:value-of select="php:function('lang','User name or email')"/>
					</td>
					<td class="start_direction" width="55%">
						<br/>
						<input type="text" name="appshore_user" size="30" value=""/>
					</td>
				</tr>
				<tr >
					<td class="end_direction">
						<xsl:value-of select="php:function('lang','Password')"/>
					</td>
					<td class="start_direction">
						<input name="appshore_pass" type="password"/>
					</td>
				</tr>
				<tr >
					<td/>
					<td class="start_direction">
						<input type="submit" class="formBarButton" name="submit" >
					        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Login')"/></xsl:attribute>
						</input>										
					</td>
				</tr>
			</table>
			</form>	
			<div class="row_off label end_direction" style="padding-top:10px;padding-right:5px">
				<a href="{$baseurl}&amp;op=base.auth.recovery"><xsl:value-of select="php:function('lang','Forgot your password?')"/></a>
			</div>
			<xsl:call-template name="rounded"><xsl:with-param name="row" select="'boff'" /></xsl:call-template>
		</div>
	</div>
</xsl:template> 

<xsl:template name="recovery">
	<xsl:call-template name="headerAuth"/>

	<div style="height:120px"/>
	
	<div align="center" style="width:100%;">
		<div class="row_off" style="width:550px">
			<xsl:call-template name="rounded"><xsl:with-param name="row" select="'ton'" /></xsl:call-template>
			<div class="start_direction row_on formBlockTitle" style="padding-bottom:5px;padding-left:5px">
				<xsl:value-of select="php:function('lang','Password recovery')"/>
			</div>
			<br/>
			<form method="post">
			<input type="hidden" id="op" name="op" value="base.auth.recovery" />
			<input type="hidden" id="key" name="key"/>
			<table cellspacing="0" cellpadding="5" width="100%" border="0" class="row_off">
				<tr >
					<td class="end_direction" width="45%">
						<xsl:value-of select="php:function('lang','User name or email')"/>
					</td>
					<td class="start_direction" width="55%">
						<input id="email" name="email" size="30" type="text" value="" />
					</td>
				</tr>
				<tr >
					<td></td>
					<td class="start_direction">
						<input type="submit" class="formBarButton" id="submit" name="submit" onclick="$('key').value='Submit';">
					        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Submit')"/></xsl:attribute>
						</input>										
					</td>
				</tr>
			</table>		
			</form>	
			<div class="row_off label" align="center" style="padding-top:10px">
				<xsl:value-of select="php:function('lang','A new password will be sent to your email address')"/>
			</div>
		<xsl:call-template name="rounded"><xsl:with-param name="row" select="'boff'" /></xsl:call-template>
		</div>
	</div>
</xsl:template> 

</xsl:stylesheet>
