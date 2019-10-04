<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP[action/node()[name() = /APPSHORE/APP/recordset/appName]]">
    <table width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
		    <xsl:call-template name="leftPanel"/>
            <td id="right_panel" class="right_panel">
				<xsl:choose>
				
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'search'">
				    	<xsl:call-template name="custom_search">
				    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
				    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabel"/>
				    	</xsl:call-template>	
				    	<xsl:call-template name="folder">
				    		<xsl:with-param name="is_popup" select="'false'"/>
				    		<xsl:with-param name="is_multiple" select="'true'"/>					    		
				    	</xsl:call-template>
				    	<xsl:call-template name="custom_grid">
				    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
				    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabel"/>
				    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appName"/>
				    		<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>
				    	</xsl:call-template>
				    	<xsl:call-template name="custom_bulk">
				    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
				    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appName"/>
				    		<xsl:with-param name="selectedForm" select="'custom_grid'"/>				    		
				    	</xsl:call-template>
					</xsl:when>
										
					<xsl:otherwise>
				    	<xsl:call-template name="custom_actions"/>
					</xsl:otherwise>
					
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name="folder">
	<xsl:param name="is_popup"/>
	<xsl:param name="is_multiple"/>	

	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Folder</xsl:with-param>
	</xsl:call-template>
	
	<table class="clearboth" border="0" width="100%" cellpadding="1" cellspacing="1" style="line-height:2em">
        <tr class="field" align="left" width="100%">
            <td width="*%">
                <xsl:for-each select = "currentFolder/currentFolder_item">
                    <xsl:if test = "document_id != '0'">
						&#160;&gt;&#160;
                    </xsl:if>
                    <xsl:choose>
                    	<xsl:when test = "$is_popup = 'false'">
                    		<a href="{$baseurl}&amp;op=documents.base.search&amp;document_id={document_id}&amp;is_multiple={$is_multiple}">
                    			<xsl:value-of select="document_name"/>
                    		</a>
                    	</xsl:when>
                    	<xsl:otherwise>
                    		<a href="{$baseurl}&amp;op=documents.popup.search&amp;document_id={document_id}&amp;is_attachment={/APPSHORE/APP/recordset/is_attachment}&amp;is_multiple={$is_multiple}">
                    			<xsl:value-of select="document_name"/>
                    		</a>
                    	</xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>				
            </td>
            <td align="right" width="15%">
            	<xsl:value-of select="filesize"/>					
            </td>			
    	</tr>	
	</table>
</xsl:template>
</xsl:stylesheet>
