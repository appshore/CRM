<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="dashlet_name[.='email_campaigns']">
	<xsl:call-template name="email_campaigns"/>
</xsl:template>

<xsl:template name="email_campaigns">

	<xsl:call-template name="headerPortalBox">
		<xsl:with-param name="appLabel">Email Campaigns</xsl:with-param>
		<xsl:with-param name="appName">email_campaigns</xsl:with-param>		
	</xsl:call-template>
	<div id="email_campaigns">
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<xsl:for-each select = "/APPSHORE/APP/email_campaigns/campaigns/campaigns_item">
			<tr >
				<td >
					<a href="{$baseurl}&amp;op=campaigns.base.view&amp;campaign_id={campaign_id}">
						<xsl:value-of select="substring(campaign_name, 1, 15)"/>
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

<xsl:template match="dashlet_name[.='campaigns_most_actives']">
	<xsl:call-template name="campaigns_most_actives"/>
</xsl:template>

<xsl:template name="campaigns_most_actives">

	<xsl:call-template name="headerPortalBox">
		<xsl:with-param name="appLabel">Company Most Active campaigns</xsl:with-param>
		<xsl:with-param name="appName">accounts_most_actives</xsl:with-param>		
	</xsl:call-template>
	<div id="accounts_most_actives">
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

<xsl:template name="campaigns_listing">

	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Campaigns</xsl:with-param>
	</xsl:call-template>

	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr class="label" align="center">
			<td >&#160;</td><td >&#160;</td>
			<td>
                <xsl:value-of select="php:function('lang','Campaign')"/>
			</td>	
			<xsl:if test="string-length(/APPSHORE/APP/recordset/user_id) = 0">
				<td >
	            	<xsl:value-of select="php:function('lang','Owner')"/>
				</td>
			</xsl:if>
			<td>
				<xsl:value-of select="php:function('lang','Type')"/>
			</td>								
			<td>
				<xsl:value-of select="php:function('lang','List')"/>
			</td>			
			<td>
                <xsl:value-of select="php:function('lang','Records')"/>
			</td>		
			<td>
                <xsl:value-of select="php:function('lang','Status')"/>
			</td>						
			<td>
                <xsl:value-of select="php:function('lang','Created')"/>
			</td>			
		</tr>
		<xsl:for-each select = "campaigns/campaigns_item">
			<tr class="unselectedtext" align="center" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
				<td align="center" width="2%">		
					<xsl:if test="scope > 0"> 								
						<a href="{$baseurl}&amp;op=campaigns.{type}.edit&amp;campaign_id={campaign_id}">
	            	        <img class="image" src="{$api_image_path}/edit.png"/>
	         			</a>												
	         		</xsl:if>
				</td>									
				<td align="center" width="2%">					
					<a href="{$baseurl}&amp;op=campaigns.{type}.view&amp;campaign_id={campaign_id}">
	                    <img class="image" src="{$api_image_path}/view.png"/>
	         		</a>											
				</td>												
				<td width="*" align="left">
					<a href="{$baseurl}&amp;op=campaigns.{type}.view&amp;campaign_id={campaign_id}">
						<xsl:value-of select="campaign_name"/>
					</a>
				</td>	
				<xsl:if test="string-length(/APPSHORE/APP/recordset/user_id) = 0">
					<td width="*">
						<xsl:value-of select="user_name"/>
					</td>
				</xsl:if>
				<td width="*">
					<xsl:value-of select="type_name"/>
				</td>											
				<td width="*">
					<a href="{$baseurl}&amp;op=campaigns.lists.view&amp;list_id={list_id}">
						<xsl:value-of select="list_name"/>
					</a>
				</td>				
				<td width="*">
					<xsl:value-of select="records"/>
				</td>
				<td width="*">
					<xsl:value-of select="status_name"/>
				</td>								
				<td width="*">
					<xsl:value-of select="created"/>
				</td>				
			</tr>	
		</xsl:for-each>
	</table>
</xsl:template>

</xsl:stylesheet>
