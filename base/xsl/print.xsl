<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="/">
	<html>
		<head>
			<title><xsl:value-of select="/APPSHORE/API/brand" /><xsl:if test="/APPSHORE/API/apps/apps_item[name = /APPSHORE/API/op/appname]/title">	- <xsl:value-of select="php:functionString('lang',/APPSHORE/API/apps/apps_item[name = /APPSHORE/API/op/appname]/title)"/></xsl:if></title>
			<link rel="icon" href="{/APPSHORE/API/favicon}" type="image/x-ico" />
			<link rel="shortcut icon" href="{/APPSHORE/API/favicon}" />	
			<link rel="stylesheet" type="text/css" href="{$basepath}/api/css/stylesheet.php?theme_id={/APPSHORE/API/current_user/theme_id}&amp;language_direction={/APPSHORE/API/current_user/language_direction}"/>
		</head>

		<body id='popup'>
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
		</body>
	</html>
</xsl:template> 

</xsl:stylesheet>
