<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP[action/forecasts]">

    <script type="text/javascript" src="http://www.google.com/jsapi"/>
	<script type="text/javascript">
		google.load('visualization', '1', {packages: ['corechart']});
	</script>
    
    <table height="100%" width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
			<xsl:call-template name="leftPanel"/>
            <td id="right_panel" class="right_panel">
            	
            	<xsl:if test="count(users/users_item) = 0 ">
					<div class="helpmsg" style="margin-top:10px">
						<xsl:value-of disable-output-escaping="yes" select="php:function('lang','forecasts.base.salespeople.help')"/>
					</div>            	
            	</xsl:if>
            	
				<xsl:call-template name="submenus_chooser"/>				
				<xsl:choose>
					<xsl:when test="action/forecasts = 'monthly'">
				    	<xsl:call-template name="monthly_filter"/>					
				    	<xsl:call-template name="performances"/>				    	
				    	<xsl:call-template name="performancesChart"/>					    						
				    	<xsl:call-template name="forecastsResults">
							<xsl:with-param name="period" select="'monthly'"/>
						</xsl:call-template>
				    	<xsl:call-template name="forecastsResultsChart"/>					    						
					</xsl:when>
					<xsl:when test="action/forecasts = 'quarterly'">
				    	<xsl:call-template name="quarterly_filter"/>
				    	<xsl:call-template name="performances"/>				    						
				    	<xsl:call-template name="performancesChart"/>					    						
				    	<xsl:call-template name="forecastsResults">
							<xsl:with-param name="period" select="'quarterly'"/>
						</xsl:call-template>
				    	<xsl:call-template name="forecastsResultsChart"/>					    						
					</xsl:when>	
					<xsl:when test="action/forecasts = 'yearly'">
				    	<xsl:call-template name="yearly_filter"/>
				    	<xsl:call-template name="performances"/>					    						
				    	<xsl:call-template name="performancesChart"/>					    						
				    	<xsl:call-template name="forecastsResults">
							<xsl:with-param name="period" select="'yearly'"/>
						</xsl:call-template>
				    	<xsl:call-template name="forecastsResultsChart"/>					    						
					</xsl:when>
					<xsl:when test="action/forecasts = 'custom'">
				    	<xsl:call-template name="custom_filter"/>
				    	<xsl:call-template name="performances"/>					    						
				    	<xsl:call-template name="performancesChart"/>					    						
				    	<xsl:call-template name="forecastsResults">
							<xsl:with-param name="period" select="'custom'"/>
						</xsl:call-template>
				    	<xsl:call-template name="forecastsResultsChart"/>					    						
					</xsl:when>					
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>


<xsl:template name="performances">

    <div class="clearboth formTitle">
		<xsl:value-of select="php:functionString('lang','Performance')"/>
	</div>

	<table class="resizable sortable searchResultsTable" border="0" cellspacing="0" cellpadding="0">
		<thead>
			<tr class="searchResultsHeader ">
				<xsl:if test="string-length(/APPSHORE/APP/recordset/user_id) = 0">
					<th class="searchResultsHeaderCells">
						<xsl:value-of select="php:function('lang','Sales people')"/>
					</th>
				</xsl:if>
				<th class="searchResultsHeaderCells currency">
					<xsl:value-of select="php:function('lang','Quota')"/>
				</th>			
				<th class="searchResultsHeaderCells currency">
					<xsl:value-of select="php:function('lang','Expected amount')"/>
				</th>			
				<th class="searchResultsHeaderCells">
					<xsl:value-of select="php:function('lang','Quota vs expected')"/>
				</th>			
				<th class="searchResultsHeaderCells currency">
					<xsl:value-of select="php:function('lang','Forecasted amount')"/>
				</th>			
				<th class="searchResultsHeaderCells">
					<xsl:value-of select="php:function('lang','Quota vs forecasted')"/>
				</th>			
				<th class="searchResultsHeaderCells currency">
					<xsl:value-of select="php:function('lang','Won amount')"/>
				</th>			
				<th class="searchResultsHeaderCells">
					<xsl:value-of select="php:function('lang','Quota vs won')"/>
				</th>			
			</tr>
		</thead>
		<xsl:if test="string-length(/APPSHORE/APP/recordset/user_id) = 0">		
			<tfoot>		
				<tr class="searchResultsHeader">
					<th class="searchResultsHeaderCells">
						<xsl:value-of select="php:function('lang','Total')"/>
					</th>			
					<th class="searchResultsHeaderCells">
						<xsl:value-of select="/APPSHORE/APP/total_performances/quota"/>
					</th>			
					<th class="searchResultsHeaderCells">
						<xsl:value-of select="/APPSHORE/APP/total_performances/sum_expected_amount"/>
					</th>			
					<th class="searchResultsHeaderCells">
						<xsl:value-of select="/APPSHORE/APP/total_performances/quota_vs_expected"/>
					</th>			
					<th class="searchResultsHeaderCells">
						<xsl:value-of select="/APPSHORE/APP/total_performances/sum_forecasted_amount"/>
					</th>			
					<th class="searchResultsHeaderCells">
						<xsl:value-of select="/APPSHORE/APP/total_performances/quota_vs_forecasted"/>
					</th>			
					<th class="searchResultsHeaderCells">
						<xsl:value-of select="/APPSHORE/APP/total_performances/sum_won_amount"/>
					</th>			
					<th class="searchResultsHeaderCells">
						<xsl:value-of select="/APPSHORE/APP/total_performances/quota_vs_won"/>
					</th>			
				</tr>
			</tfoot>
		</xsl:if>		
		<xsl:for-each select = "performances/performances_item">
			<xsl:variable name="unselectedtext"><xsl:choose><xsl:when test ="record_date = 'new'">new</xsl:when><xsl:when test ="record_date = 'expired'">expired</xsl:when><xsl:otherwise>unselectedtext</xsl:otherwise></xsl:choose></xsl:variable>											
			<tr class="{$unselectedtext}" onMouseOver="this.className ='searchResultsSelected'" onMouseOut="this.className ='{$unselectedtext}'">
				<xsl:if test="string-length(/APPSHORE/APP/recordset/user_id) = 0">				
					<td class="searchResultsCells">		
						<a href="{$baseurl}&amp;op=forecasts.base.{/APPSHORE/APP/action/forecasts}&amp;user_id={user_id}">
							<xsl:value-of select="full_name"/>
						</a>					
					</td>
				</xsl:if>
				<td class="searchResultsCells">		
					<xsl:value-of select="quota"/>
				</td>					
				<td class="searchResultsCells">		
					<xsl:value-of select="sum_expected_amount"/>
				</td>	
				<td class="searchResultsCells">		
					<xsl:value-of select="quota_vs_expected"/>
				</td>							
				<td class="searchResultsCells">		
					<xsl:value-of select="sum_forecasted_amount"/>
				</td>
				<td class="searchResultsCells">		
					<xsl:value-of select="quota_vs_forecasted"/>
				</td>				
				<td class="searchResultsCells">		
					<xsl:value-of select="sum_won_amount"/>
				</td>				
				<td class="searchResultsCells">		
					<xsl:value-of select="quota_vs_won"/>
				</td>									
			</tr>	
		</xsl:for-each>
	</table>
</xsl:template>

<xsl:template name="forecastsResults">
	<xsl:param name="period"/>

    <div class="clearboth formTitle">
		<xsl:value-of select="php:functionString('lang','Forecasts')"/>
	</div>

	<xsl:variable name="thisForm"><xsl:value-of select="period"/>_forecasts</xsl:variable>							
	<form name="{$thisForm}" method="post" >
		<input type="hidden" name="op" value="forecasts.base.{$period}"/>
		<xsl:for-each select = "recordset/node()">	
			<xsl:if test="name()">	
				<input type="hidden" name="{name()}" value="{node()}" />
			</xsl:if>
		</xsl:for-each>	

	<table class="resizable sortable searchResultsTable" border="0" cellspacing="0" cellpadding="0">
		<thead>
			<tr class="searchResultsHeader">
				<th class="searchResultsHeaderCells">
		            <xsl:value-of select="php:function('lang','C')"/>
				</th>
				<th class="searchResultsHeaderCells">
		            <xsl:value-of select="php:function('lang','U')"/>
				</th>			
				<th>
					<xsl:call-template name="forecastFieldsHeader">
						<xsl:with-param name="thisForm" select="$thisForm"/>
						<xsl:with-param name="fieldName" select="'opportunity_name'"/>
						<xsl:with-param name="fieldLabel" select="'Opportunity'"/>
					</xsl:call-template>
				</th>
				<th>
					<xsl:call-template name="forecastFieldsHeader">
						<xsl:with-param name="thisForm" select="$thisForm"/>
						<xsl:with-param name="fieldName" select="'account_name'"/>
						<xsl:with-param name="fieldLabel" select="'Account'"/>
					</xsl:call-template>
				</th>
				<xsl:if test="string-length(/APPSHORE/APP/recordset/user_id) = 0">
					<th>
						<xsl:call-template name="forecastFieldsHeader">
							<xsl:with-param name="thisForm" select="$thisForm"/>
							<xsl:with-param name="fieldName" select="'full_name'"/>
							<xsl:with-param name="fieldLabel" select="'Sales people'"/>
						</xsl:call-template>
					</th>
				</xsl:if>
				<th>
					<xsl:call-template name="forecastFieldsHeader">
						<xsl:with-param name="thisForm" select="$thisForm"/>
						<xsl:with-param name="fieldName" select="'expected_amount'"/>
						<xsl:with-param name="fieldLabel" select="'Expected amount'"/>
					</xsl:call-template>
				</th>
				<th>
					<xsl:call-template name="forecastFieldsHeader">
						<xsl:with-param name="thisForm" select="$thisForm"/>
						<xsl:with-param name="fieldName" select="'forecasted_amount'"/>
						<xsl:with-param name="fieldLabel" select="'Forecasted amount'"/>
					</xsl:call-template>
				</th>
				<th>
					<xsl:call-template name="forecastFieldsHeader">
						<xsl:with-param name="thisForm" select="$thisForm"/>
						<xsl:with-param name="fieldName" select="'stage_name'"/>
						<xsl:with-param name="fieldLabel" select="'Stage'"/>
					</xsl:call-template>
				</th>
				<th>
					<xsl:call-template name="forecastFieldsHeader">
						<xsl:with-param name="thisForm" select="$thisForm"/>
						<xsl:with-param name="fieldName" select="'probability'"/>
						<xsl:with-param name="fieldLabel" select="'Probability'"/>
					</xsl:call-template>
				</th>
				<th>
					<xsl:call-template name="forecastFieldsHeader">
						<xsl:with-param name="thisForm" select="$thisForm"/>
						<xsl:with-param name="fieldName" select="'closing'"/>
						<xsl:with-param name="fieldLabel" select="'Closing date'"/>
					</xsl:call-template>
				</th>
			</tr>
		</thead>
		<tfoot>
			<tr class="searchResultsHeader">
				<th/>
				<th/>
				<th/>
				<th class="searchResultsHeaderCells">
					<xsl:value-of select="php:function('lang','Total amount')"/>
				</th>	
				<xsl:if test="string-length(/APPSHORE/APP/recordset/user_id) = 0">
					<th/>
				</xsl:if>
				<th class="searchResultsHeaderCells">
					<xsl:value-of select="/APPSHORE/APP/total/expected_amount"/>
				</th>						
				<th class="searchResultsHeaderCells">
					<xsl:value-of select="/APPSHORE/APP/total/forecasted_amount"/>
				</th>
				<th/>
				<th/>			
				<th/>
			</tr>		
		</tfoot>		
	    <xsl:if test="count(forecasts/forecasts_item) = 0">
	    	<tr style="text-align:center;vertical-align:middle">
	    		<td colspan="9">
				 	<H2 style="color:lightgrey;line-height:2em"><xsl:value-of select="php:function('lang','No entries')"/></H2>
				</td>
			</tr>
	    </xsl:if>			
		<xsl:for-each select = "forecasts/forecasts_item">
			<xsl:variable name="unselectedtext"><xsl:choose><xsl:when test ="record_date = 'new'">new</xsl:when><xsl:when test ="record_date = 'expired'">expired</xsl:when><xsl:otherwise>unselectedtext</xsl:otherwise></xsl:choose></xsl:variable>											
			<tr class="{$unselectedtext}" onMouseOver="this.className ='searchResultsSelected'" onMouseOut="this.className ='{$unselectedtext}'">
				<td class="searchResultsIcons" >		
					<xsl:if test="scope > 0"> 								
						<a href="{$baseurl}&amp;op=opportunities.base.edit&amp;opportunity_id={opportunity_id}">
	            	        <img class="image" src="{$api_image_path}/edit.png"/>
	         			</a>												
	         		</xsl:if>
				</td>									
				<td class="searchResultsIcons" >		
					<a href="{$baseurl}&amp;op=opportunities.base.view&amp;opportunity_id={opportunity_id}" onMouseOver="popupDetails( '{$baseurl}&amp;op=opportunities.popup.view&amp;opportunity_id={opportunity_id}', 'Opportunity Details', '{$api_image_path}', 'opportunities');" onMouseOut="return nd();"  >
	                    <img class="image" src="{$api_image_path}/view.png"/>
	         		</a>												
				</td>					
				<td class="searchResultsCells">		
					<a href="{$baseurl}&amp;op=opportunities.base.view&amp;opportunity_id={opportunity_id}" onMouseOver="popupDetails( '{$baseurl}&amp;op=opportunities.popup.view&amp;opportunity_id={opportunity_id}', 'Opportunity Details', '{$api_image_path}', 'opportunities');" onMouseOut="return nd();"  >
						<xsl:value-of select="opportunity_name"/>
					</a>
				</td>
				<td class="searchResultsCells">		
	               	<a href="{$baseurl}&amp;op=accounts.base.view&amp;account_id={account_id}" onMouseOver="popupDetails('{$baseurl}&amp;op=accounts.popup.view&amp;account_id={account_id}','Account Details','{$api_image_path}', 'accounts');" onMouseOut="return nd();"  >
						<xsl:value-of select="account_name"/>
					</a>				
				</td>
				<xsl:if test="string-length(/APPSHORE/APP/recordset/user_id) = 0">				
					<td class="searchResultsCells">		
						<xsl:value-of select="full_name"/>
					</td>
				</xsl:if>
				<td class="searchResultsCells">		
					<xsl:value-of select="expected_amount"/>
				</td>				
				<td class="searchResultsCells">		
					<xsl:value-of select="forecasted_amount"/>
				</td>
				<td class="searchResultsCells">		
					<xsl:value-of select="stage_name"/>
				</td>
				<td class="searchResultsCells">		
					<xsl:value-of select="probability"/>%
				</td>
				<td class="searchResultsCells">		
					<xsl:value-of select="closing"/>
				</td>						
			</tr>	
		</xsl:for-each>
	</table>
	</form>

</xsl:template>


<xsl:template name="forecastFieldsHeader">
	<xsl:param name="thisForm"/>			    
	<xsl:param name="fieldName"/>			    
	<xsl:param name="fieldLabel"/>			    
	<xsl:variable name="orderby"><xsl:value-of select="$fieldName"/></xsl:variable>							
	<xsl:choose>
		<xsl:when test="(/APPSHORE/APP/recordset/orderby = $orderby) and (/APPSHORE/APP/recordset/ascdesc = 'ASC')"> 								
            <xsl:attribute name="class">searchResultsHeaderCells sortasc currency</xsl:attribute>
		</xsl:when>						
		<xsl:when test="(/APPSHORE/APP/recordset/orderby = $orderby) and (/APPSHORE/APP/recordset/ascdesc = 'DESC')"> 								
            <xsl:attribute name="class">searchResultsHeaderCells sortdesc currency</xsl:attribute>
		</xsl:when>						
		<xsl:otherwise test="/APPSHORE/APP/recordset/orderby = $orderby"> 								
            <xsl:attribute name="class">searchResultsHeaderCells currency</xsl:attribute>
		</xsl:otherwise>
	</xsl:choose>						
<!--	<a href="javascript:gridOrderBy(document.{$thisForm},'{$orderby}');">-->
<!--        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Sort by')"/>&#160;<xsl:value-of select="php:functionString('lang',$fieldLabel)"/></xsl:attribute>-->
<!--        <xsl:value-of select="php:functionString('lang',$fieldLabel)"/>-->
<!--    </a>-->
        <xsl:value-of select="php:functionString('lang',$fieldLabel)"/>
</xsl:template>

</xsl:stylesheet>
