<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="dashlet_name[.='last_emails']">
	<xsl:call-template name="headerDashboardBox">
		<xsl:with-param name="appLabel">Last Emails</xsl:with-param>
		<xsl:with-param name="appName">last_emails</xsl:with-param>		
	</xsl:call-template>
	<div id="last_emails-div">
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr class="label" align="center">			
			<td width="2%">&#160;</td>				
			<td width="2%">&#160;</td>				
			<td>
                <xsl:value-of select="php:function('lang','From - To')"/>
			</td>			
			<td width="*%">
                <xsl:value-of select="php:function('lang','Subject')"/>
			</td>
			<xsl:if test="folder/folder_type = 'all'">
				<td>
  	                <xsl:value-of select="php:function('lang','Folder')"/>
				</td>				
			</xsl:if>			
			<td>
                <xsl:value-of select="php:function('lang','Date')"/>
 			</td>
			<td>
                <xsl:value-of select="php:function('lang','Size')"/>
			</td>
		</tr>
		<xsl:for-each select = "/APPSHORE/APP/last_emails/webmail/webmail_item">
			<tr class="unselectedtext" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
			<xsl:if test = "is_read = 'N'">
				<xsl:attribute name="style">font-weight: bold;</xsl:attribute>		
			</xsl:if>														
				<td align="center" width="2%">		
            		<xsl:if test = "bound = 'D'">
                		<img border="0" src="{$api_image_path}/draft.gif" title="Draft message" />
					</xsl:if>
            		<xsl:if test = "bound = 'O'">
                		<img border="0" src="{$api_image_path}/sent.gif" title="Outbound message" />
					</xsl:if>
            		<xsl:if test = "bound = 'I'">
                		<img border="0" src="{$api_image_path}/inbox.gif" title="Inbound message"/>
					</xsl:if>										
				</td>					
				<td align="center" width="2%">		
            		<xsl:if test = "attachments > 0">
                		<img border="0" src="{$api_image_path}/attachment.gif" title="{attachments} attachment(s)"/>
					</xsl:if>
				</td>																			
				<td  align="left">
					<a href="{$baseurl}&amp;op=webmail.base.view&amp;mail_id={mail_id}">
           				<xsl:if test = "bound = 'O'">
	                    	<xsl:value-of select="mail_to"/>
	                    </xsl:if>           				
	                    <xsl:if test = "bound ='D'">
	                    	<xsl:value-of select="mail_to"/>
	                    </xsl:if>
           				<xsl:if test = "bound = 'I'">
	                    	<xsl:value-of select="mail_from"/>
	                    </xsl:if>	                    
	         		</a>	         								
				</td>				
				<td  width="*%">
					<a href="{$baseurl}&amp;op=webmail.base.view&amp;mail_id={mail_id}">
						<xsl:value-of select="subject"/>
					</a>
				</td>
				<xsl:if test="/APPSHORE/APP/folder/folder_type = 'all'">
					<td align="center">
						<xsl:value-of select="folder_name"/>
					</td>				
				</xsl:if>					
				<td align="center">
					<xsl:value-of select="mail_date"/>
				</td>
				<td align="center">
					<xsl:value-of select="mail_size"/>
				</td>
			</tr>
		</xsl:for-each>
	</table>
	</div>
</xsl:template>

<xsl:template match="dashlet_name[.='unread_emails']">
	<xsl:call-template name="headerDashboardBox">
		<xsl:with-param name="appLabel">Unread Emails</xsl:with-param>
		<xsl:with-param name="appName">unread_emails</xsl:with-param>		
	</xsl:call-template>
	<div id="unread_emails-div">
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr class="label" align="center">			
			<td width="2%">&#160;</td>				
			<td width="2%">&#160;</td>				
			<td>
                <xsl:value-of select="php:function('lang','From - To')"/>
			</td>			
			<td width="*%">
                <xsl:value-of select="php:function('lang','Subject')"/>
			</td>
			<xsl:if test="folder/folder_type = 'all'">
				<td>
  	                <xsl:value-of select="php:function('lang','Folder')"/>
				</td>				
			</xsl:if>			
			<td>
                <xsl:value-of select="php:function('lang','Date')"/>
 			</td>
			<td>
                <xsl:value-of select="php:function('lang','Size')"/>
			</td>
		</tr>
		<xsl:for-each select = "/APPSHORE/APP/unread_emails/webmail/webmail_item">
			<tr class="unselectedtext" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
			<xsl:if test = "is_read = 'N'">
				<xsl:attribute name="style">font-weight: bold;</xsl:attribute>		
			</xsl:if>														
				<td align="center" width="2%">		
            		<xsl:if test = "bound = 'D'">
                		<img border="0" src="{$api_image_path}/draft.gif" title="Draft message" />
					</xsl:if>
            		<xsl:if test = "bound = 'O'">
                		<img border="0" src="{$api_image_path}/sent.gif" title="Outbound message" />
					</xsl:if>
            		<xsl:if test = "bound = 'I'">
                		<img border="0" src="{$api_image_path}/inbox.gif" title="Inbound message"/>
					</xsl:if>										
				</td>					
				<td align="center" width="2%">		
            		<xsl:if test = "attachments > 0">
                		<img border="0" src="{$api_image_path}/attachment.gif" title="{attachments} attachment(s)"/>
					</xsl:if>
				</td>																			
				<td  align="left">
					<a href="{$baseurl}&amp;op=webmail.base.view&amp;mail_id={mail_id}">
           				<xsl:if test = "bound = 'O'">
	                    	<xsl:value-of select="mail_to"/>
	                    </xsl:if>           				
	                    <xsl:if test = "bound ='D'">
	                    	<xsl:value-of select="mail_to"/>
	                    </xsl:if>
           				<xsl:if test = "bound = 'I'">
	                    	<xsl:value-of select="mail_from"/>
	                    </xsl:if>	                    
	         		</a>	         								
				</td>				
				<td  width="*%">
					<a href="{$baseurl}&amp;op=webmail.base.view&amp;mail_id={mail_id}">
						<xsl:value-of select="subject"/>
					</a>
				</td>
				<xsl:if test="/APPSHORE/APP/folder/folder_type = 'all'">
					<td align="center">
						<xsl:value-of select="folder_name"/>
					</td>				
				</xsl:if>					
				<td align="center">
					<xsl:value-of select="mail_date"/>
				</td>
				<td align="center">
					<xsl:value-of select="mail_size"/>
				</td>
			</tr>
		</xsl:for-each>
	</table>
	</div>
</xsl:template>

</xsl:stylesheet>
