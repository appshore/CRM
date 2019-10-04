<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>


<xsl:template match="dashlet_name[.='last_leads']">
	<xsl:call-template name="headerDashboardBox">
		<xsl:with-param name="appLabel">Last leads</xsl:with-param>
		<xsl:with-param name="appName">last_leads</xsl:with-param>		
	</xsl:call-template>
	<div id="last_leads-div">
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr class="label" align="center">
			<td>&#160;</td>		
			<td>
                   <xsl:value-of select="php:function('lang','Account')"/>
			</td>
			<td>
                    <xsl:value-of select="php:function('lang','First Name')"/>
 			</td>
			<td>
                    <xsl:value-of select="php:function('lang','Last Name')"/>
			</td>					
			<td>
                    <xsl:value-of select="php:function('lang','Phone')"/>
            </td>							
			<td>
                    <xsl:value-of select="php:function('lang','Email')"/>
            </td>							
			<xsl:if test="string-length(/APPSHORE/APP/recordset/status_id) = 0">
				<td>
	                    <xsl:value-of select="php:function('lang','Type')"/>
				</td>
			</xsl:if>		
			<td>
                    <xsl:value-of select="php:function('lang','State')"/>
 			</td>	
			<td>
                   <xsl:value-of select="php:function('lang','Country')"/>
			</td>	
			<xsl:if test="string-length(/APPSHORE/APP/recordset/user_id) = 0">
				<td >
	                    <xsl:value-of select="php:function('lang','Owner')"/>
				</td>
			</xsl:if>
		</tr>
		<xsl:for-each select = "/APPSHORE/APP/last_leads/leads/leads_item">
			<tr class="unselectedtext" align="center" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
				<td align="center" width="2%">		
					<xsl:if test="scope > 0"> 								
						<a href="{$baseurl}&amp;op=leads.base.edit&amp;lead_id={lead_id}">
	            	        <img class="image" src="{$api_image_path}/edit.png"/>
	         			</a>												
	         		</xsl:if>
				</td>													
				<td width="*" align="left">
					<a href="{$baseurl}&amp;op=leads.base.view&amp;lead_id={lead_id}" onMouseOver="popupDetails( '{$baseurl}&amp;op=leads.popup.view&amp;lead_id={lead_id}','Lead Details','{$api_image_path}', 'leads');" onMouseOut="return nd();"  >
						<xsl:value-of select="account_name"/>
					</a>
				</td>
				<td width="*"><xsl:value-of select="first_names"/></td>				
				<td width="*"><xsl:value-of select="last_name"/></td>				
				<td width="*%"><xsl:value-of select="phone"/></td>					
				<td width="*%"><xsl:value-of select="email"/></td>					
				<xsl:if test="string-length(/APPSHORE/APP/recordset/status_id) = 0">
					<td width="*"><xsl:value-of select="status_name"/></td>
				</xsl:if>
				<td width="*"><xsl:value-of select="state_1"/></td>	
				<td width="*"><xsl:value-of select="country_1"/></td>	
				<xsl:if test="string-length(/APPSHORE/APP/recordset/user_id) = 0">
					<td width="*"><xsl:value-of select="user_name"/></td>
				</xsl:if>
			</tr>	
		</xsl:for-each>
	</table>
	</div>
</xsl:template>

</xsl:stylesheet>
