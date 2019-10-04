<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>


<xsl:template name="geoMap">
	<xsl:param name="byAddress"/>
	<xsl:param name="byZipcode"/>
	<a href="javascript:;" onclick="popupInter('http://maps.google.com/maps?q={$byAddress}&amp;hl={/APPSHORE/API/current_user/language_id}&amp;output=embed','Google Maps');">
		<xsl:value-of select="php:function('lang','By address')"/>
	</a>&#160;
	<a href="javascript:;" onclick="popupInter('http://maps.google.com/maps?q={$byZipcode}&amp;hl={/APPSHORE/API/current_user/language_id}&amp;output=embed','Google Maps');">
		<xsl:value-of select="php:function('lang','By zipcode')"/>
	</a>
</xsl:template>


<xsl:template name="geoDirection">
	<xsl:param name="fromHere"/>
	<xsl:param name="toHere"/>	
	<a href="javascript:;" onclick="popupInter('http://maps.google.com/maps?saddr={$toHere}&amp;daddr={$fromHere}&amp;hl={/APPSHORE/API/current_user/language_id}&amp;output=embed','Google Maps');">
		<xsl:value-of select="php:function('lang','To here')"/>
	</a>&#160;	
	<a href="javascript:;" onclick="popupInter('http://maps.google.com/maps?saddr={$fromHere}&amp;daddr={$toHere}&amp;hl={/APPSHORE/API/current_user/language_id}&amp;output=embed','Google Maps');">
		<xsl:value-of select="php:function('lang','From here')"/>
	</a>	
</xsl:template>

<!--
<xsl:template name="geoLocation">
	<xsl:param name="address"/>
	<xsl:param name="city"/>
	<xsl:param name="state"/>
	<xsl:param name="country"/>
	<xsl:param name="zipcode"/>
	<a class="link" title="Map by address" >
        <xsl:attribute name="onclick">
            popupInter("http://maps.google.com/maps?q="+encodeURIComponent("{$address},{$city},{$state},{$country}")+"&amp;hl={/APPSHORE/API/current_user/language_id}","Google Maps");
        </xsl:attribute>
        <img class="image" style="padding-left:3px" src="{$api_image_path}/clock.gif"/>
    </a> 					
</xsl:template>


<xsl:template name="geoLocation">
	<xsl:param name="address"/>
	<xsl:param name="city"/>
	<xsl:param name="state"/>
	<xsl:param name="country"/>
	<xsl:param name="zipcode"/>
	<a class="link" title="Map by address" onclick='popupInter("http://maps.google.com/maps?q="+encodeURIComponent("{$address},{$city},{$state},{$country}")+"&amp;hl={/APPSHORE/API/current_user/language_id}","Google Maps");'>
        <img class="image" style="padding-left:3px" src="{$api_image_path}/clock.gif"/>
    </a> 					
</xsl:template>
-->

</xsl:stylesheet>
