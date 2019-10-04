<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="quarterly_filter">
	<form id="quarterly_filter" name="quarterly_filter" method="post">
		<input type="hidden" name="op" id="op" value="forecasts.base.quarterly"/>			
		<input type="hidden" name="key" id="key" value=""/>			

    <div class="clearboth">
	    <div class="searchfield">
			<xsl:value-of select="php:function('lang','Fiscal year')"/><br/>
			<select id="year" name="year">
				<xsl:for-each select = "years/years_item" >
					<option value="{year}">
						<xsl:if test="year = /APPSHORE/APP/recordset/year">
							<xsl:attribute name="selected" value="true"/>
						</xsl:if>
						<xsl:value-of select="year"/>
					</option>
				</xsl:for-each>
			</select>
		</div>
	    <div class="searchfield">
			<xsl:value-of select="php:function('lang','Quarter')"/><br/>
			<select id="month_id" name="month_id">
				<xsl:for-each select = "quarters/quarters_item" >
					<option value="{month_id}">
						<xsl:if test="month_id = /APPSHORE/APP/recordset/month_id">
							<xsl:attribute name="selected" value="true"/>
						</xsl:if>
						<xsl:value-of select="php:functionString('lang',quarter_name)"/>
					</option>
				</xsl:for-each>
			</select>
		</div>
	    <div class="searchfield">
			<xsl:value-of select="php:function('lang','Sales people')"/><br/>
			<select id="user_id" name="user_id">
					<option/>				
				<xsl:for-each select = "users/users_item" >
					<option value="{user_id}">
						<xsl:if test="user_id = /APPSHORE/APP/recordset/user_id">
							<xsl:attribute name="selected" value="true"/>
						</xsl:if>
						<xsl:value-of select="full_name"/> - <xsl:value-of select="user_name"/>
					</option>
				</xsl:for-each>
			</select>
		</div>
	    <div class="searchfield">
			<xsl:value-of select="php:function('lang','Stage')"/><br/>
			<select id="stage_id" name="stage_id">
					<option/>				
				<xsl:for-each select = "stages/stages_item" >
					<option value="{stage_id}">
						<xsl:if test="stage_id = /APPSHORE/APP/recordset/stage_id">
							<xsl:attribute name="selected" value="true"/>
						</xsl:if>
						<xsl:value-of select="php:functionString('lang',stage_name)"/>
					</option>
				</xsl:for-each>
			</select>
		</div>
	    <div class="searchfield">
			<xsl:value-of select="php:function('lang','Probability')"/><br/>
			<select id="probability" name="probability">
					<option/>				
				<xsl:for-each select = "probabilities/probabilities_item" >
					<option value="{probability}">
						<xsl:if test="probability = /APPSHORE/APP/recordset/probability">
							<xsl:attribute name="selected" value="true"/>
						</xsl:if>
						<xsl:value-of select="probability"/>%
					</option>
				</xsl:for-each>
			</select>
		</div>
	</div>

    <div class="clearboth">
        <xsl:call-template name="customSearchFooter">
			<xsl:with-param name="thisForm" select="'quarterly_filter'"/>
		</xsl:call-template>&#160;
	    <xsl:if test = "/APPSHORE/API/savedSearches">
	        <xsl:call-template name="customSearch">
				<xsl:with-param name="thisForm" select="'quarterly_filter'"/>	
 		  		<xsl:with-param name="appName" select="'forecasts'"/>
 		  		<xsl:with-param name="appLabel" select="'Forecasts'"/>
			</xsl:call-template>
		</xsl:if>
	</div>

	</form>	 
</xsl:template>

</xsl:stylesheet>
