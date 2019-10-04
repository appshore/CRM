<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="dashlet_name[.='my_monthly_forecasts']">
	<div id="my_monthly_forecasts" align="center">
    	<xsl:call-template name="forecastsResults">
			<xsl:with-param name="period" select="'monthly'"/>
		</xsl:call-template>
    	<xsl:call-template name="forecastsResultsChart"/>					    						
	</div>
</xsl:template>

<xsl:template match="dashlet_name[.='my_monthly_forecasts_performances']">
	<div id="my_monthly_forecasts_performances" align="center">
    	<xsl:call-template name="performances"/>				    	
    	<xsl:call-template name="performancesChart"/>					    						
	</div>
</xsl:template>

<xsl:template match="dashlet_name[.='my_quarterly_forecasts']">
	<div id="my_quarterly_forecasts" align="center">
    	<xsl:call-template name="forecastsResults">
			<xsl:with-param name="period" select="'quarterly'"/>
		</xsl:call-template>
    	<xsl:call-template name="forecastsResultsChart"/>					    						
	</div>
</xsl:template>

<xsl:template match="dashlet_name[.='my_quarterly_forecasts_performances']">
	<div id="my_quarterly_forecasts_performances" align="center">
    	<xsl:call-template name="performances"/>				    	
    	<xsl:call-template name="performancesChart"/>					    						
	</div>
</xsl:template>

<xsl:template match="dashlet_name[.='my_yearly_forecasts']">
		<script type="text/javascript" src="http://www.google.com/jsapi"/>
		<script type="text/javascript">
			google.load('visualization', '1', {packages: ['corechart']});
		</script>
	<div id="my_yearly_forecasts" align="center">
		<xsl:for-each select = "/APPSHORE/APP/dashlet/my_yearly_forecasts">
     		<xsl:call-template name="forecastsResultsChart"/>					    						
		</xsl:for-each>
	</div>
</xsl:template>

<xsl:template match="dashlet_name[.='my_yearly_forecasts_performances']">
	<div id="my_yearly_forecasts_performances" align="center">
    	<xsl:call-template name="performances"/>				    	
    	<xsl:call-template name="performancesChart"/>					    						
	</div>
</xsl:template>

</xsl:stylesheet>
