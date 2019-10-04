<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>
		
<xsl:template match="APP[action/node()[name() = /APPSHORE/APP/recordset/appName]]">
    <table width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
		    <xsl:call-template name="leftPanel"/>
            <td id="right_panel" class="right_panel">
				<xsl:choose>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'view'">
					    	<xsl:call-template name="custom_view">
				    		<xsl:with-param name="appName"><xsl:value-of select="/APPSHORE/APP/recordset/appName"/></xsl:with-param>
				    		<xsl:with-param name="appLabel"><xsl:value-of select="/APPSHORE/APP/recordset/appLabelSingular"/></xsl:with-param>
				    		<xsl:with-param name="nodeName"><xsl:value-of select="/APPSHORE/APP/recordset/appNameSingular"/></xsl:with-param>
				    		<xsl:with-param name="recordId"><xsl:value-of select="/APPSHORE/APP/recordset/appRecordId"/></xsl:with-param>		
				    		<xsl:with-param name="recordName"><xsl:value-of select="/APPSHORE/APP/recordset/appRecordName"/></xsl:with-param>					    		
							<xsl:with-param name="assignedto">false</xsl:with-param>
				    	</xsl:call-template>				    					    	
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'edit'">
				    	<xsl:call-template name="custom_edit">
				    		<xsl:with-param name="appName"><xsl:value-of select="/APPSHORE/APP/recordset/appName"/></xsl:with-param>
				    		<xsl:with-param name="appLabel"><xsl:value-of select="/APPSHORE/APP/recordset/appLabelSingular"/></xsl:with-param>
				    		<xsl:with-param name="nodeName"><xsl:value-of select="/APPSHORE/APP/recordset/appNameSingular"/></xsl:with-param>
				    		<xsl:with-param name="recordId"><xsl:value-of select="/APPSHORE/APP/recordset/appRecordId"/></xsl:with-param>		
				    		<xsl:with-param name="recordName"><xsl:value-of select="/APPSHORE/APP/recordset/appRecordName"/></xsl:with-param>					    		
							<xsl:with-param name="assignedto">false</xsl:with-param>
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
			
