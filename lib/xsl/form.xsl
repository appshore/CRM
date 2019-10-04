<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="headerEditForm">
	<xsl:param name="testParam"/>
	<xsl:param name="labelParam"/>
	<xsl:param name="appLabel"/>
	<xsl:param name="appName"/>
	    
	<div class="boxtitle" style="clear:both">
		<xsl:value-of select="php:functionString('lang',$appLabel)"/>:&#160;
		<xsl:choose>
			<xsl:when test="string-length($testParam) > 0">
                <xsl:value-of select="$labelParam" />
			</xsl:when>
			<xsl:otherwise>
				<span style="color:black;font-weight:normal;font-style:italic"><xsl:value-of select="php:function('lang','New')"/></span>
			</xsl:otherwise>
		</xsl:choose>
	</div>
</xsl:template>

<xsl:template name="footerEditForm">
	<xsl:param name="testParam"/>
	<xsl:param name="thisForm"/>	
	<xsl:param name="isTop"/>	
		
	<xsl:if test="not($isTop = 'true')">
		<input type="hidden" name="key" id="key"/>
	</xsl:if>				
	<input type="submit" class="formBarButton" name="Save" onclick="document.{$thisForm}.key.value='Save'">
        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
    </input>&#160;        	
	<input type="submit" class="formBarButton" name="Cancel" onclick="document.{$thisForm}.key.value='Cancel'">
        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
    </input>
</xsl:template>

<xsl:template name="headerViewForm">
	<xsl:param name="labelParam"/>
	<xsl:param name="appLabel"/>
	<xsl:param name="appName"/>
	    
	<div class="boxtitle" style="clear:both">
		<xsl:value-of select="php:functionString('lang',$appLabel)"/>:&#160;<xsl:value-of select="$labelParam"/>
	</div>
	
</xsl:template>

<xsl:template name="footerViewForm">
	<xsl:param name="thisForm"/>
	<xsl:param name="duplicate"/>	
	<xsl:param name="delete"/>	
	<xsl:param name="isTop"/>	
		
	<xsl:if test="not($isTop = 'true')">
		<input type="hidden" name="key" id="key"/>
	</xsl:if>				
	<xsl:if test="/APPSHORE/APP/scope > 0 ">
		<input type="submit" class="formBarButton" name="edit" onclick="document.{$thisForm}.key.value='Edit'">
            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Edit')"/></xsl:attribute>
        </input>&#160;
		<xsl:choose>
			<xsl:when test="$duplicate">                    
				<input type="submit" class="formBarButton" name="duplicate" onclick="document.{$thisForm}.key.value='Duplicate'">
                    <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Duplicate')"/></xsl:attribute>
                </input>&#160;
			</xsl:when>
		</xsl:choose>   
		<xsl:choose>
			<xsl:when test="$delete">   					 		                
				<input type="submit" class="formBarButton" name="delete" onclick="document.{$thisForm}.key.value='Delete'">
                    <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Delete')"/></xsl:attribute>
                </input>
			</xsl:when>
		</xsl:choose>  		                    
	</xsl:if>
</xsl:template>

<xsl:template name="timeStamp">
	<xsl:param name="thisField"/>	
	<a class="link" style="height:1em" onclick="insertTimeStamp( document.{$thisField},'{/APPSHORE/API/current_user/full_name}', true);">
		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Add a time stamp')"/></xsl:attribute>
		<img class="image" style="padding-left:3px" src="{$api_image_path}/timestamp.gif"/>
    </a>
</xsl:template>

</xsl:stylesheet>
