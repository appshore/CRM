<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="dashlet_name[.='accounts_neglected']">
	<xsl:call-template name="accounts_neglected"/>
</xsl:template>

<xsl:template name="accounts_neglected">

	<xsl:call-template name="headerDashboardBox">
		<xsl:with-param name="appLabel">My Neglected Accounts</xsl:with-param>
		<xsl:with-param name="appName">accounts_neglected</xsl:with-param>		
	</xsl:call-template>
	<div id="accounts_neglected-div">
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<xsl:for-each select = "/APPSHORE/APP/accounts_neglected/accounts/accounts_item">
			<tr >
				<td >
					<a href="{$baseurl}&amp;op=accounts.base.view&amp;account_id={account_id}">
						<xsl:value-of select="substring(account_name, 1, 15)"/>
					</a>
				</td>
				<td>
					<xsl:value-of select="substring(updated, 1, 10)"/>
				</td>				
			</tr>	
		</xsl:for-each>
	</table>
	</div>
</xsl:template>


<xsl:template match="dashlet_name[.='accounts_most_opportunities']">
	<xsl:call-template name="headerDashboardBox">
		<xsl:with-param name="appLabel">My Most Active Accounts by Opportunity</xsl:with-param>
		<xsl:with-param name="appName">accounts_most_opportunities</xsl:with-param>		
	</xsl:call-template>
	<div id="accounts_most_opportunities-div">
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr class="label" align="center">
			<td>
				<xsl:value-of select="php:function('lang','Account')"/>
			</td>
			<td>
				<xsl:value-of select="php:function('lang','Opportunities')"/>
			</td>			
			<td>
				<xsl:value-of select="php:function('lang','Type')"/>
			</td>
			<td>
				<xsl:value-of select="php:function('lang','Industry')"/>
			</td>			
			<td>
				<xsl:value-of select="php:function('lang','Rating')"/>
			</td>
			<td>
				<xsl:value-of select="php:function('lang','Last Update')"/>
			</td>
		</tr>
		<xsl:for-each select = "/APPSHORE/APP/accounts_most_opportunities/accounts/accounts_item">
			<tr class="unselectedtext"  align="center" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
				<td width="*" align="left">
					<a href="{$baseurl}&amp;op=accounts.base.view&amp;account_id={account_id}">
						<xsl:value-of select="account_name"/>
					</a>
				</td>
				<td width="*">
					<a href="{$baseurl}&amp;op=opportunities.base.newsearch&amp;account_id={account_id}">
						<xsl:value-of select="count_opportunities"/>
					</a>
				</td>				
				<td width="*">
					<xsl:value-of select="status_name"/>
				</td>
				<td width="*">
					<xsl:value-of select="industry_name"/>
				</td>				
				<td width="*">
					<xsl:value-of select="rating_name"/>
				</td>
				<td >
					<xsl:value-of select="substring(updated, 1, 10)"/>
				</td>
						
			</tr>	
		</xsl:for-each>
	</table>
	</div>
</xsl:template>

<xsl:template match="dashlet_name[.='accounts_most_actives']">
	<xsl:call-template name="headerDashboardBox">
		<xsl:with-param name="appLabel">My Most Active Accounts by Date</xsl:with-param>
		<xsl:with-param name="appName">accounts_most_actives</xsl:with-param>		
	</xsl:call-template>
	<div id="accounts_most_actives-div">
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr class="label" align="center">
			<td>
				<xsl:value-of select="php:function('lang','Account')"/>
			</td>
			<td>
				<xsl:value-of select="php:function('lang','Opportunities')"/>
			</td>			
			<td>
				<xsl:value-of select="php:function('lang','Type')"/>
			</td>
			<td>
				<xsl:value-of select="php:function('lang','Industry')"/>
			</td>			
			<td>
				<xsl:value-of select="php:function('lang','Rating')"/>
			</td>
			<td>
				<xsl:value-of select="php:function('lang','Last Update')"/>
			</td>
		</tr>
		<xsl:for-each select = "/APPSHORE/APP/accounts_most_actives/accounts/accounts_item">
			<tr class="unselectedtext"  align="center" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
				<td width="*" align="left">
					<a href="{$baseurl}&amp;op=accounts.base.view&amp;account_id={account_id}">
						<xsl:value-of select="account_name"/>
					</a>
				</td>
				<td width="*">
					<a href="{$baseurl}&amp;op=opportunities.base.newsearch&amp;account_id={account_id}">
						<xsl:value-of select="count_opportunities"/>
					</a>
				</td>				
				<td width="*">
					<xsl:value-of select="status_name"/>
				</td>
				<td width="*">
					<xsl:value-of select="industry_name"/>
				</td>				
				<td width="*">
					<xsl:value-of select="rating_name"/>
				</td>
				<td >
					<xsl:value-of select="substring(updated, 1, 10)"/>
				</td>
						
			</tr>	
		</xsl:for-each>
	</table>
	</div>
</xsl:template>
</xsl:stylesheet>
