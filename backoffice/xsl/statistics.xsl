<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP[action/statistics]">
    <table height="100%" width="100%" cellSpacing="0" cellPadding="0"  bdata="0" >
		<tr width="100%" valign="top">
		    <xsl:call-template name="leftPanel"/>		    
            <td id="right_panel" class="right_panel">
 	    		<xsl:call-template name="select_agent_form"/>	
				<xsl:choose>
					<xsl:when test="action/statistics = 'view'">				
				    	<xsl:call-template name="per_edition"/>
<!--				    	<xsl:call-template name="per_month"/>-->
<!--				    	<xsl:call-template name="per_year"/>-->
					</xsl:when>				
				</xsl:choose>			
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name="select_agent_form">
	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Statistics</xsl:with-param>
	</xsl:call-template>
	<form method='post' name='selectAgent'>
	<input type='hidden' name='op' value='{/APPSHORE/API/op/opname}'/>	
	<div class="clearboth" style="padding:0 0 10px 0">
		<xsl:value-of select="php:function('lang','Agent')"/><br/>
		<select name="agent_id" onchange="submit();return true;">
				<option/>
			<xsl:for-each select = "/APPSHORE/APP/agents/agents_item" >
                <option value="{agent_id}">
					<xsl:if test="agent_id = /APPSHORE/APP/statistics/agent_id">
						<xsl:attribute name="selected" value="true"/>
					</xsl:if>
					<xsl:value-of select="php:functionString('lang',agent_name)"/>										
				</option>
			</xsl:for-each>	
		</select>
	</div>	
	</form>						 	 							
</xsl:template>

<xsl:template name="per_month">
	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Subscriptions due per month</xsl:with-param>
	</xsl:call-template>
					
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr class="label" align="center">
			<td rowspan="2"><xsl:value-of select="php:function('lang','Month')"/></td>
			<td colspan="3"><xsl:value-of select="php:function('lang','Recurring')"/></td>
			<td colspan="3"><xsl:value-of select="php:function('lang','One shoot')"/></td>
			<td colspan="3"><xsl:value-of select="php:function('lang','Total')"/></td>
		</tr>	
		<tr class="label" align="center">
			<td width="10%"><xsl:value-of select="php:function('lang','Companies')"/></td>			
			<td><xsl:value-of select="php:function('lang','Users')"/></td>			
			<td><xsl:value-of select="php:function('lang','Amount')"/></td>			
			<td width="10%"><xsl:value-of select="php:function('lang','Companies')"/></td>			
			<td><xsl:value-of select="php:function('lang','Users')"/></td>			
			<td><xsl:value-of select="php:function('lang','Amount')"/></td>			
			<td width="10%"><xsl:value-of select="php:function('lang','Companies')"/></td>			
			<td><xsl:value-of select="php:function('lang','Users')"/></td>			
			<td><xsl:value-of select="php:function('lang','Amount')"/></td>			
		</tr>	
		<xsl:for-each select = "months/months_item">
			<tr class="unselectedtext" align="right" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
				<td style="padding:5px"  align="left" ><xsl:value-of select="monthname"/></td>				
				<td><xsl:value-of select="monthly/count_companies"/></td>				
				<td><xsl:value-of select="format-number(monthly/sum_users,'###,###,###')"/></td>				
				<td><xsl:value-of select="format-number(monthly/sum_subscriptions,'###,###,###')"/></td>				
				<td><xsl:value-of select="count_companies"/></td>				
				<td><xsl:value-of select="format-number(sum_users,'###,###,###')"/></td>				
				<td><xsl:value-of select="format-number(sum_subscriptions,'###,###,###')"/></td>				
				<td><xsl:value-of select="total/count_companies"/></td>				
				<td><xsl:value-of select="format-number(total/sum_users,'###,###,###')"/></td>				
				<td><xsl:value-of select="format-number(total/sum_subscriptions,'###,###,###')"/></td>				
			</tr>			
		</xsl:for-each>
		<tr class="label" align="right">
			<td style="padding:5px"  align="center" >Year</td>				
			<td><xsl:value-of select="year/monthly/count_companies"/></td>				
			<td><xsl:value-of select="format-number(year/monthly/sum_users,'###,###,###')"/></td>				
			<td><xsl:value-of select="format-number(year/monthly/sum_subscriptions,'###,###,###')"/></td>				
			<td><xsl:value-of select="year/count_companies"/></td>				
			<td><xsl:value-of select="format-number(year/sum_users,'###,###,###')"/></td>				
			<td><xsl:value-of select="format-number(year/sum_subscriptions,'###,###,###')"/></td>				
			<td><xsl:value-of select="year/total/count_companies"/></td>				
			<td><xsl:value-of select="format-number(year/total/sum_users,'###,###,###')"/></td>				
			<td><xsl:value-of select="format-number(year/total/sum_subscriptions,'###,###,###')"/></td>				
		</tr>			
	</table>

</xsl:template>


<xsl:template name="per_year">
	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Per year</xsl:with-param>
	</xsl:call-template>
					
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr class="label" align="center">
			<td rowspan="2"><xsl:value-of select="php:function('lang','Subscriptions')"/></td>
			<td rowspan="2"><xsl:value-of select="php:function('lang','Companies')"/></td>			
			<td rowspan="2"><xsl:value-of select="php:function('lang','Amount')"/></td>			
			<td colspan="3"><xsl:value-of select="php:function('lang','Users')"/></td>			
		</tr>	
		<tr class="label" align="center">
			<td><xsl:value-of select="php:function('lang','quota')"/></td>			
			<td><xsl:value-of select="php:function('lang','created')"/></td>			
			<td><xsl:value-of select="php:function('lang','activated')"/></td>			
		</tr>
		<tr class="unselectedtext" align="right" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
			<td style="padding:5px"  align="left" ><xsl:value-of select="php:function('lang','Monthly')"/></td>				
			<td style="padding:5px" ><xsl:value-of select="year/monthly/count_companies"/></td>				
			<td style="padding:5px" ><xsl:value-of select="format-number(year/monthly/revenue,'###,###,###')"/></td>				
			<td style="padding:5px" ><xsl:value-of select="format-number(year/monthly/sum_users_quota,'###,###,###')"/></td>				
			<td style="padding:5px" ><xsl:value-of select="format-number(year/monthly/sum_users_count,'###,###,###')"/></td>				
			<td style="padding:5px" ><xsl:value-of select="format-number(year/monthly/sum_users_activated,'###,###,###')"/></td>				
		</tr>			
		<tr class="unselectedtext" align="right" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
			<td style="padding:5px"  align="left" ><xsl:value-of select="php:function('lang','Yearly')"/></td>				
			<td style="padding:5px" ><xsl:value-of select="year/yearly/count_companies"/></td>				
			<td style="padding:5px" ><xsl:value-of select="format-number(year/yearly/revenue,'###,###,###')"/></td>				
			<td style="padding:5px" ><xsl:value-of select="format-number(year/yearly/sum_users_quota,'###,###,###')"/></td>				
			<td style="padding:5px" ><xsl:value-of select="format-number(year/yearly/sum_users_count,'###,###,###')"/></td>				
			<td style="padding:5px" ><xsl:value-of select="format-number(year/yearly/sum_users_activated,'###,###,###')"/></td>				
		</tr>			
		<tr class="unselectedtext" align="right" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
			<td style="padding:5px"  align="left" ><xsl:value-of select="php:function('lang','Custom')"/></td>				
			<td style="padding:5px" ><xsl:value-of select="year/custom/count_companies"/></td>				
			<td style="padding:5px" ><xsl:value-of select="format-number(year/custom/revenue,'###,###,###')"/></td>				
			<td style="padding:5px" ><xsl:value-of select="format-number(year/custom/sum_users_quota,'###,###,###')"/></td>				
			<td style="padding:5px" ><xsl:value-of select="format-number(year/custom/sum_users_count,'###,###,###')"/></td>				
			<td style="padding:5px" ><xsl:value-of select="format-number(year/custom/sum_users_activated,'###,###,###')"/></td>				
		</tr>			
		<tr style="font-weight:bold" class="selectedtext" align="right">
			<td style="padding:5px"  align="left" ><xsl:value-of select="php:function('lang','Total')"/></td>				
			<td style="padding:5px" ><xsl:value-of select="year/total/count_companies"/></td>				
			<td style="padding:5px" ><xsl:value-of select="format-number(year/total/revenue,'###,###,###')"/></td>				
			<td style="padding:5px" ><xsl:value-of select="format-number(year/total/sum_users_quota,'###,###,###')"/></td>				
			<td style="padding:5px" ><xsl:value-of select="format-number(year/total/sum_users_count,'###,###,###')"/></td>				
			<td style="padding:5px" ><xsl:value-of select="format-number(year/total/sum_users_activated,'###,###,###')"/></td>				
		</tr>		
	</table>	

</xsl:template>


<xsl:template name="per_edition">
	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Per edition</xsl:with-param>
	</xsl:call-template>
					
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr class="label" align="center">
			<td rowspan="2"><xsl:value-of select="php:function('lang','Edition')"/></td>
			<td rowspan="2"><xsl:value-of select="php:function('lang','Companies')"/></td>			
			<td colspan="2"><xsl:value-of select="php:function('lang','Revenue')"/></td>
			<td colspan="3"><xsl:value-of select="php:function('lang','Users')"/></td>			
			<td rowspan="2"><xsl:value-of select="php:function('lang','Disk quota')"/></td>			
			<td colspan="2"><xsl:value-of select="php:function('lang','Database')"/></td>			
			<td colspan="2"><xsl:value-of select="php:function('lang','Documents')"/></td>			
		</tr>	
		<tr class="label" align="center">
			<td><xsl:value-of select="php:function('lang','month')"/></td>			
			<td><xsl:value-of select="php:function('lang','year')"/></td>			
			<td><xsl:value-of select="php:function('lang','quota')"/></td>			
			<td><xsl:value-of select="php:function('lang','created')"/></td>			
			<td><xsl:value-of select="php:function('lang','activated')"/></td>			
			<td><xsl:value-of select="php:function('lang','size')"/></td>			
			<td><xsl:value-of select="php:function('lang','records')"/></td>			
			<td><xsl:value-of select="php:function('lang','size')"/></td>			
			<td><xsl:value-of select="php:function('lang','count')"/></td>			
		</tr>
		<xsl:for-each select = "edition/edition_item">
			<tr class="unselectedtext" align="right" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
				<td style="padding:5px"  align="left" ><xsl:value-of select="edition_name"/></td>				
				<td style="padding:5px" ><xsl:value-of select="count_companies"/></td>				
				<td style="padding:5px" ><xsl:value-of select="format-number(sum_subscription_price,'###,###,###')"/></td>				
				<td style="padding:5px" ><xsl:value-of select="format-number(sum_subscription_price_year,'###,###,###')"/></td>				
				<td style="padding:5px" ><xsl:value-of select="format-number(sum_users_quota,'###,###,###')"/></td>				
				<td style="padding:5px" ><xsl:value-of select="format-number(sum_users_count,'###,###,###')"/></td>				
				<td style="padding:5px" ><xsl:value-of select="format-number(sum_users_activated,'###,###,###')"/></td>				
				<td style="padding:5px" ><xsl:value-of select="sum_disk_quota"/></td>				
				<td style="padding:5px" ><xsl:value-of select="sum_db_size"/></td>				
				<td style="padding:5px" ><xsl:value-of select="format-number(sum_db_records,'###,###,###')"/></td>				
				<td style="padding:5px" ><xsl:value-of select="sum_documents_size"/></td>				
				<td style="padding:5px" ><xsl:value-of select="format-number(sum_documents_count,'###,###,###')"/></td>				
			</tr>	
		</xsl:for-each>
		<tr class="unselectedtext" align="right" style="font-weight:bold">
			<td style="padding:5px;font-weight:bold" align="left" ><xsl:value-of select="php:function('lang','Total')"/></td>				
			<td style="padding:5px;font-weight:bold" ><xsl:value-of select="total/count_companies"/></td>				
			<td style="padding:5px;font-weight:bold" ><xsl:value-of select="format-number(total/sum_subscription_price,'###,###,###')"/></td>				
			<td style="padding:5px;font-weight:bold" ><xsl:value-of select="format-number(total/sum_subscription_price_year,'###,###,###')"/></td>				
			<td style="padding:5px;font-weight:bold" ><xsl:value-of select="format-number(total/sum_users_quota,'###,###,###')"/></td>				
			<td style="padding:5px;font-weight:bold" ><xsl:value-of select="format-number(total/sum_users_count,'###,###,###')"/></td>				
			<td style="padding:5px;font-weight:bold" ><xsl:value-of select="format-number(total/sum_users_activated,'###,###,###')"/></td>				
			<td style="padding:5px;font-weight:bold" ><xsl:value-of select="total/sum_disk_quota"/></td>				
			<td style="padding:5px;font-weight:bold" ><xsl:value-of select="total/sum_db_size"/></td>				
			<td style="padding:5px;font-weight:bold" ><xsl:value-of select="format-number(total/sum_db_records,'###,###,###')"/></td>				
			<td style="padding:5px;font-weight:bold" ><xsl:value-of select="total/sum_documents_size"/></td>				
			<td style="padding:5px;font-weight:bold" ><xsl:value-of select="format-number(total/sum_documents_count,'###,###,###')"/></td>				
		</tr>	
	</table>	

</xsl:template>

</xsl:stylesheet>
