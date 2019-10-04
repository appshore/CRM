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
				    		<xsl:with-param name="remove" select="'true'"/>				    		
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

</xsl:stylesheet>
