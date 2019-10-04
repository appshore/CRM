<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>
<xsl:template name="documents_listing">
	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Documents</xsl:with-param>
	</xsl:call-template>

	<table border="0" width="100%" cellpadding="1" cellspacing="1">		
		<tr class="label" align="center">
			<td>&#160;</td><td>&#160;</td>		
			<td>
                    <xsl:value-of select="php:function('lang','Document')"/>
			</td>	
			<td>
                    <xsl:value-of select="php:function('lang','Subject')"/>
			</td>					
			<td>
                    <xsl:value-of select="php:function('lang','Size')"/>
			</td>							
			<td >
                    <xsl:value-of select="php:function('lang','Owner')"/>
 			</td>	
			<td >
                    <xsl:value-of select="php:function('lang','Related to')"/>
			</td>										
			<td>
                    <xsl:value-of select="php:function('lang','Last Update')"/>
 			</td>			
		</tr>
		<xsl:for-each select = "documents/documents_item">
			<tr class="unselectedtext" align="center" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
				<td align="center" width="2%">		
					<xsl:if test="scope > 0"> 								
						<a href="{$baseurl}&amp;op=documents.base.edit&amp;document_id={document_id}">
	            	        <img class="image" src="{$api_image_path}/edit.png"/>
	         			</a>												
	         		</xsl:if>
				</td>									
				<td align="center" width="2%">						
					<a href="{$baseurl}&amp;op=documents.base.view&amp;document_id={document_id}">
	                    <img class="image" src="{$api_image_path}/view.png"/>
	         		</a>											
				</td>													
				<td width="*%" align="left">		
					<xsl:choose>
						<xsl:when test="folder = 'Y'">
	                    	<img class="image" src="{$api_image_path}/mime_folder.png"/>&#160;						
							<a href="{$baseurl}&amp;op=documents.base.search&amp;document_top_id={document_id}">
								<xsl:value-of select="document_name"/>
							</a>							
						</xsl:when>
						<xsl:otherwise>
							<a href="{$baseurl}&amp;op=documents.download.start&amp;document_id={document_id}">
								<xsl:value-of select="document_name"/>
							</a>							
						</xsl:otherwise>
					</xsl:choose>
				</td>
				<td width="*%" align="left">
					<xsl:value-of select="subject"/>
				</td>							
				<td width="*%">
					<xsl:value-of select="filesize"/>
				</td>						
				<td width="*%">
					<xsl:value-of select="user_name"/>
				</td>	
				<td width="*%">
                    <xsl:if test="related_name">
						<xsl:value-of select="app_label"/>&#160;
	        			<a href="{$baseurl}&amp;op={table_name}.base.view&amp;{record_id_name}={related_record_id}" onMouseOver="popupDetails('{$baseurl}&amp;op={table_name}.popup.view&amp;{record_id_name}={related_record_id}','{app_label} Details','{$api_image_path}','{table_name}');" onMouseOut="return nd();" >		
				    		<xsl:value-of select="related_name"/>
			    		</a>			        
                    </xsl:if>
				</td>										
				<td width="*%">
					<xsl:value-of select="updated"/>
				</td>						
			</tr>	
		</xsl:for-each>
	</table>
</xsl:template>

</xsl:stylesheet>
