<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>
			
<xsl:template name="activities_search">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>	
	<xsl:param name="period"/>	
	
	<script language="JavaScript" type="text/javascript" src="{$lib_js_path}/form.js"/>		

	<xsl:choose>
	    <xsl:when test = "$appLabel">
		    <div class="clearboth formTitle">
				<xsl:call-template name="customSearchHeader">
					<xsl:with-param name="appLabel" select="$appLabel"/>		
				</xsl:call-template>
			</div>
		</xsl:when>
		<xsl:otherwise>
			<div style="height:10px"/>
		</xsl:otherwise>
	</xsl:choose>
		
	<form name="custom_search" id="custom_search" method="post">
		<input type="hidden" name="op" id="op" value="{$appName}.{$period}.search"/>
		<input type="hidden" name="key" id="key" />				

	    <div class="clearboth">
			<xsl:for-each select = "/APPSHORE/APP/search_fields/search_fields_item" >
			    <div class="searchfield">
					<xsl:call-template name="searchFields">
						<xsl:with-param name="thisForm" select="'custom_search'"/>
					</xsl:call-template>
				</div>
			</xsl:for-each>
	  		<!-- for IE -->
	    	<div style="clear:both"/>
	    </div>
	  
	    <div class="clearboth">
	        <xsl:call-template name="customSearchFooter">
				<xsl:with-param name="thisForm" select="'custom_search'"/>	
			</xsl:call-template>&#160;
		    <xsl:if test = "/APPSHORE/API/savedSearches">
		        <xsl:call-template name="customSearch">
					<xsl:with-param name="thisForm" select="'custom_search'"/>	
	 		  		<xsl:with-param name="appName" select="$appName"/>
	 		  		<xsl:with-param name="appLabel" select="$appLabel"/>
				</xsl:call-template>
			</xsl:if>
		</div>
	</form>
</xsl:template>

<xsl:template name="calendars_tabs">
	<form name="tab_{/APPSHORE/APP/recordset/tab_id}" id="tab_{/APPSHORE/APP/recordset/tab_id}" method="post">
		<input type="hidden" name="op" id="op" value="activities.{/APPSHORE/APP/recordset/tab_id}.search"/>
		<input type="hidden" name="keytabs" id="keytabs"/>				
		<input type="hidden" name="period" id="period"/>					

	<table cellSpacing="0" cellPadding="0" style="margin-top:1em;width:100%">
		<!-- MAIN MENU APPS -->
		<tr style="width:100%">
			<xsl:for-each select="tabs/tabs_item">
				<td style="padding-right:2px;text-align:center">
			<xsl:choose>
				<xsl:when test="tab_id = /APPSHORE/APP/recordset/tab_id">
						<div class="row_on" style="padding-bottom:4px">
							<xsl:call-template name="rounded"><xsl:with-param name="row" select="'ton'" /></xsl:call-template>
						&#160;<a href="{$baseurl}&amp;op={tab_op}"><xsl:value-of select="php:functionString('lang',tab_name)"/></a>&#160;
					</div>
				</xsl:when>
				<xsl:otherwise>
						<div  class="row_off" style="padding-bottom:4px">
							<xsl:call-template name="rounded"/>
						&#160;<a href="{$baseurl}&amp;op={tab_op}"><xsl:value-of select="php:functionString('lang',tab_name)"/></a>&#160;
					</div>
				</xsl:otherwise>
			</xsl:choose>
				</td>
			</xsl:for-each>
			<xsl:choose>
				<xsl:when test="not(/APPSHORE/APP/recordset/tab_id = 'activities')">
					<td align="center" class="boxtitle" style="width:60%">
						<xsl:value-of select="/APPSHORE/APP/recordset/current_period"/>
					</td>
					<td align="right">
						<xsl:call-template name="calendarNavigation">
							<xsl:with-param name="thisForm" >tab_<xsl:value-of select="/APPSHORE/APP/recordset/tab_id"/></xsl:with-param>
						</xsl:call-template>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td  style="width:80%">
						&#160;
					</td>
				</xsl:otherwise>
			</xsl:choose>			
		</tr>
	</table>
	
	<xsl:if test="/APPSHORE/APP/recordset/tab_id = 'activities'">
		<div class="row_on" style="clear:both;width:100%;height:12px">&#160;</div>	
	</xsl:if>
	
	</form>
		
</xsl:template>

</xsl:stylesheet>
