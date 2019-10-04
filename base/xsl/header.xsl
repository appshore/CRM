<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="commonHead">
		<xsl:if test = "/APPSHORE/API/popup">
			<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE"/>
			<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE"/>
			<META HTTP-EQUIV="EXPIRES" CONTENT="0"/>
		</xsl:if>

		<title><xsl:value-of select="/APPSHORE/API/brand" /><xsl:if test="/APPSHORE/API/apps/apps_item[name = /APPSHORE/API/op/appname]/title">	- <xsl:value-of select="php:functionString('lang',/APPSHORE/API/apps/apps_item[name = /APPSHORE/API/op/appname]/title)"/></xsl:if></title>
		<link rel="icon" href="{/APPSHORE/API/favicon}" type="image/x-ico" />
		<link rel="shortcut icon" href="{/APPSHORE/API/favicon}" />	
		<link rel="stylesheet" type="text/css" href="{$basepath}/api/css/stylesheet.php?theme_id={/APPSHORE/API/current_user/theme_id}&amp;language_direction={/APPSHORE/API/current_user/language_direction}"/>

		<script type="text/javascript" >
			var api_image_path = '<xsl:value-of select="$api_image_path" />';
			var sid = '<xsl:value-of select="/APPSHORE/API/sid" />';
			var baseurl = '<xsl:value-of select="$baseurl" />';
			var basepath = '<xsl:value-of select="$basepath" />';
		</script>
</xsl:template>

<xsl:template name="main_window_header">
	<div >
		<div class="start_float">
			<a href="{$basepath}">
				<img border="0" title="{/APPSHORE/API/my_company/company_name}" src="{$basepath}/lib/logo.php"/>
			</a>													
		</div>
		<div class="end_float" >
			<div style="padding-right:5px" class="grid_right" >
				<xsl:if test = "/APPSHORE/API/apimenu/logout/node()">
					<xsl:if test="/APPSHORE/API/current_user/new_features">
						<a href="{$baseurl}&amp;op=support.base.newfeatures" style="font-weight:bold">
							<xsl:value-of select="php:function('lang','New features')"/>
						</a>
						&#160;-&#160;
					</xsl:if>
					<xsl:choose>
						<xsl:when test = "/APPSHORE/API/apimenu/preferences">
							<a href="{$baseurl}&amp;op=preferences.profile_base.view"><xsl:value-of select="/APPSHORE/API/current_user/full_name" /></a>						
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="/APPSHORE/API/current_user/full_name" />
						</xsl:otherwise>
					</xsl:choose>						
					<xsl:if test = "string-length(/APPSHORE/API/current_user/full_name) > 1">				
						&#160;-&#160;
					</xsl:if>
					<xsl:choose>
						<xsl:when test = "/APPSHORE/API/apimenu/administration">
							<a href="{$baseurl}&amp;op=administration.company_base.view"><xsl:value-of select="/APPSHORE/API/my_company/company_name" /></a>						
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="/APPSHORE/API/my_company/company_name" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</div>
			<div style="padding-right:5px;padding-bottom:5px" class="grid_right" >
				<xsl:if test = "/APPSHORE/API/apimenu/preferences/node()">
					<a href="{$baseurl}&amp;op={/APPSHORE/API/apimenu/preferences/preferences_item/op}">
                         <xsl:value-of select="php:functionString('lang',/APPSHORE/API/apimenu/preferences/preferences_item/title)"/>
					</a>
					&#160;-&#160;
				</xsl:if>
				<xsl:if test = "/APPSHORE/API/apimenu/administration/node()">
					<a href="{$baseurl}&amp;op={/APPSHORE/API/apimenu/administration/administration_item/op}">
                        <xsl:value-of select="php:functionString('lang',/APPSHORE/API/apimenu/administration/administration_item/title)"/>
					</a>
					&#160;-&#160;
				</xsl:if>
				<xsl:if test = "/APPSHORE/API/apimenu/logout/node()">
					<a href="{$baseurl}&amp;op={/APPSHORE/API/apimenu/logout/logout_item/op}">
                        <xsl:value-of select="php:functionString('lang',/APPSHORE/API/apimenu/logout/logout_item/title)"/>
					</a>
				</xsl:if>
				<xsl:if test = "/APPSHORE/API/apimenu/login/node()">
					<img border="0" title="Login" src="{$api_image_path}/login.gif"/>
					&#160;<a href="{$baseurl}&amp;op={/APPSHORE/API/apimenu/login/login_item/op}">
                        <xsl:value-of select="php:functionString('lang',/APPSHORE/API/apimenu/login/login_item/title)"/>
					</a>
				</xsl:if>	
			</div>				
		</div>
	</div>
	<div class="clearboth"/>
</xsl:template>

</xsl:stylesheet>
