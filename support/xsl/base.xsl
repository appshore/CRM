<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP">
    <table width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
			<td class="left_panel" id="left_panel" style="display:{/APPSHORE/API/cookie/left_panel}">
			    <xsl:call-template name="verticalMenus">		    
					<xsl:with-param name="appName">support</xsl:with-param>
					<xsl:with-param name="appLabel">Support</xsl:with-param>
				</xsl:call-template>	
			</td>
            <td id="right_panel" class="right_panel">
				<xsl:choose>
				
					<xsl:when test="action/support = 'documentation'">
						<xsl:call-template name="documentation"/>
					</xsl:when>			
							
					<xsl:when test="action/support = 'newfeatures'">
						<xsl:call-template name="newfeatures"/>
					</xsl:when>			
							
					<xsl:otherwise>
						<xsl:call-template name="support_start"/>
					</xsl:otherwise>
					
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template> 

<xsl:template name="support_start">
	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Customer support</xsl:with-param>
	</xsl:call-template>
	<xsl:value-of disable-output-escaping="yes" select="php:function('lang','support.base.start')"/>
	<xsl:if test="not(/APPSHORE/API/current_user/language_id = 'ja')">
		<div>
			<p>
				<xsl:value-of select="php:function('lang','From this account:')"/>
			</p>
			<ul style="line-height:2em">
				<li>
				  	<a href="{$baseurl}&amp;op=support.tickets_base.start">
						<xsl:value-of select="php:function('lang','Ticket to report issues, to request services or new features.')"/>
					</a>
				</li>
			  	<li>
			  		<xsl:value-of select="php:function('lang','Email support:')"/>&#160;
					<xsl:call-template name="mailto">
						<xsl:with-param name="email"><xsl:value-of select="php:function('lang','support@appshore.com')"/></xsl:with-param>
						<xsl:with-param name="name"><xsl:value-of select="php:function('lang','Technical support')"/></xsl:with-param>
						<xsl:with-param name="subject"><xsl:value-of select="/APPSHORE/API/my_company/company_name" />, <xsl:value-of select="/APPSHORE/API/current_user/full_name" />: Support request</xsl:with-param>
					</xsl:call-template>
				</li>
				<li>
				  	<a href="{$baseurl}&amp;op=support.faqs_base.start">
						<xsl:value-of select="php:function('lang','Technical frequently asked questions.')"/>
					</a>
				</li>
			</ul>
			<p>
				<xsl:value-of select="php:function('lang','From the AppShore web site:')"/>&#160;
				<a href="http://www.appshore.com/?&amp;op=customercare.base.start" target="_new">www.appshore.com</a>
			</p>
			<ul style="line-height:2em">
				<li>
				  	<a href="http://www.appshore.com/?&amp;op=customercare.ticket.start" target="_new">
				  		<xsl:value-of select="php:function('lang','Contact the technical support team in case your account is inaccessible.')"/>
				  	</a>
				</li>
				<li>
				  	<a href="http://www.appshore.com/?&amp;op=customercare.contact.start" target="_new">
				  		<xsl:value-of select="php:function('lang','Contact the sales team regarding your subscription or our services.')"/>
				  	</a>
				</li>
				<li>
					<a href="http://www.appshore.com/?&amp;op=customercare.base.faq" target="_new">
						<xsl:value-of select="php:function('lang','Sales and technical frequently asked questions')"/>
					</a>
				</li>
				<li>
					<a href="http://www.appshore.com/?&amp;op=customercare.base.professional_services" target="_new">
						<xsl:value-of select="php:function('lang','AppShore professional services')"/>
					</a>
				</li>
			</ul>
		</div>
	</xsl:if>
</xsl:template>

<xsl:template name="documentation">
	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Documentation</xsl:with-param>
	</xsl:call-template>
	<div>
		<xsl:value-of disable-output-escaping="yes" select="php:function('lang','support.base.documentation')"/>
	</div>
</xsl:template>


<xsl:template name="newfeatures">
	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">New features</xsl:with-param>
	</xsl:call-template>
   	<div class="textcontent">
		<xsl:for-each select = "newfeatures/newfeatures_item">
			<div class="mediumTextBlueDark">
				<xsl:value-of select="title"/>
			</div>
			<div style="color:grey">
				<xsl:value-of select="nice_date"/>
			</div>
			<div style="padding:0 0 20px 0">
				<xsl:value-of disable-output-escaping="yes" select="php:functionString('lang',content)"/>
			</div>
		</xsl:for-each>
	</div>
</xsl:template>

</xsl:stylesheet>
