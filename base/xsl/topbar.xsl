<?xml version="1.0" encoding="UTF-8"?>
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
		</head>

		<body id='main'>
			<div id="overDiv" style="position:absolute; left:1em; top:1em; visibility:hidden; z-index:2000;"/>
			<div id="notification" style="position:absolute; left:1em; top:1em; visibility:hidden;"/>

			<xsl:call-template name="main_window_header"/>
			
			<xsl:if test = "not(/APPSHORE/API/no_window_header)">				
				<!-- MENUS -->
				<xsl:call-template name="main_window_menus"/>		
			</xsl:if>		
			 
			<div id="content">
				<!-- MAIN -->
				<xsl:choose>
					<!-- Normal APP output -->
					<xsl:when test="/APPSHORE/APP">
						<xsl:apply-templates select="/APPSHORE/APP" />
					</xsl:when>
					<!-- HTML output -->
					<xsl:when test="/APPSHORE/APPHTML">
						<xsl:value-of disable-output-escaping="yes" select="/APPSHORE/APPHTML" />
					</xsl:when>
				</xsl:choose>	
			</div>

			<xsl:if test = "not(/APPSHORE/API/no_window_footer)">
				<xsl:call-template name="main_window_footer"/>
			</xsl:if>

			<script type="text/javascript" >
				var growler = new Growler({location:'<xsl:value-of select="/APPSHORE/API/current_user/notifications_location"/>'});
				<xsl:if test = "/APPSHORE/API/notifications">
					var notifier = new Notifications(sid);
				</xsl:if>			
			</script>	 

	
			<xsl:apply-templates select="/APPSHORE/API/messages" />

<!--
			<script type="text/javascript">
				jQuery(document).ready(function($) {
					jQuery('form select.fieldInputSelectMultiple').show().multiSelect({
						selectAll: false,
						noneSelected: '',
						oneOrMoreSelected: '*'
					});
				});
			</script>
-->
		</body>
	</html>
</xsl:template> 

<xsl:template name="main_window_menus">
	<table cellSpacing="0" cellPadding="0">
		<!-- MAIN MENU APPS -->
		<tr >
			<xsl:for-each select="/APPSHORE/API/apps/apps_item[name != 'api']">
				<xsl:choose>
					<xsl:when test="/APPSHORE/API/op/appname = name">
						<td class="row_on" style="padding-bottom:4px">
							<xsl:call-template name="rounded"><xsl:with-param name="row" select="'ton'"/></xsl:call-template>
							&#160;<a class="toptabs" id="_{name}" href="{$baseurl}&amp;op={name}.base.start"><xsl:value-of select="php:functionString('lang',title)"/></a>&#160;
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="row_off" style="padding-bottom:4px">
							<xsl:call-template name="rounded"/>
							&#160;<a class="toptabs" id="_{name}" href="{$baseurl}&amp;op={name}.base.start"><xsl:value-of select="php:functionString('lang',title)"/></a>&#160;
						</td>
					</xsl:otherwise>
				</xsl:choose>
				<td>&#160;</td>
			</xsl:for-each>
		</tr>
	</table>
	<!-- START APP SPACE -->

	<!-- App Specific Menu, ie Submenu -->
	<xsl:if test="count(/APPSHORE/API/apps/apps_item) > 0 ">
		<table width="100%" cellSpacing="0" cellPadding="0" class="start_direction tabsubmenu">
			<tr style="height:2em">
				<td style="width:2em" class="start_direction">
            		<img class="image" id="left_panel_img" style="margin-left:2px;cursor:pointer"
		                title="{php:function('lang','Show or hide the left panel')}"
						src="{$api_image_path}/leftpanel-{/APPSHORE/API/cookie/left_panel}.png"
						onClick="return setPanel('left_panel_img','left_panel','{$api_image_path}/leftpanel-none.png','{$api_image_path}/leftpanel-block.png');"
					/>
				</td>
				<td class="start_direction" >
					<xsl:if test="/APPSHORE/API/op/appname != 'api' and /APPSHORE/API/op/appname != 'administration' and /APPSHORE/API/op/appname != 'preferences' and /APPSHORE/API/op/appname != 'support'">
						<xsl:for-each select="/APPSHORE/API/appmenus/appmenus_item">
							<xsl:for-each select="links/links_item">
								<a href="{$baseurl}&amp;op={op}"><xsl:value-of select="php:functionString('lang',title)"/></a>&#160;
							</xsl:for-each>
						</xsl:for-each>
					</xsl:if>
				</td>
				<xsl:if test = "/APPSHORE/API/apimenu/logout">
						<td class="end_direction" >
							<form name="flatQuickSearch" method="post" >
								<input type="hidden" name="op" value="base.search.quicksearch"/>	
								<input type="text" class="fieldInputText" style="width:10em" name="criteria" value="{/APPSHORE/API/temp/quicksearch}"/>&#160;
								<input type="submit" class="formBarButton" name="key" onclick="this.value='Search'" value="{php:function('lang','Search')}"/>
							</form>	
						</td>
						<td class="end_direction" style="width:32px">
				            <a href="javascript:void(0);" onclick="printWindow();" title="{php:function('lang','Print')}">
								<img class="image" src="{$api_image_path}/print_16.png"/>				                
							</a>				    
						</td>
						<td class="end_direction" style="width:24px">
							<xsl:variable name="tech"><xsl:value-of select="php:function('lang','Technical support')"/></xsl:variable>
							<xsl:choose>
								<xsl:when test="/APPSHORE/API/support_website = 'webmail'">
									<xsl:call-template name="mailto">
										<xsl:with-param name="email" select="/APPSHORE/API/support_email"/>
										<xsl:with-param name="name"><xsl:value-of select="/APPSHORE/API/brand"/> Technical Support</xsl:with-param>
										<xsl:with-param name="src"><xsl:value-of select="$api_image_path"/>/support_16.png</xsl:with-param>
									</xsl:call-template>
								</xsl:when>
								<xsl:when test="/APPSHORE/API/support_website != ''">
									<a href="javascript:void(0);" title="{$tech}">
										<xsl:attribute name="onclick">popupInter('http://<xsl:value-of select="/APPSHORE/API/support_website"/>','<xsl:value-of select="$tech"/>');</xsl:attribute>
										<img class="icon" src="{$api_image_path}/support_16.png"/>
									</a> 
								</xsl:when>
								<xsl:otherwise>
									<a title="{$tech}" href="{$baseurl}&amp;op=support.base.start">
										<img class="icon" src="{$api_image_path}/support_16.png"/>
									</a> 
								</xsl:otherwise> 
							</xsl:choose>
					    </td>
	            </xsl:if>
			</tr>
		</table>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
