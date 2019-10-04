<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP[action/node()[name() = /APPSHORE/APP/recordset/appName]]">
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
				    	<xsl:if test="/APPSHORE/API/my_company/company_alias = 'backoffice'">
					    	<xsl:call-template name="custom_bulk">
					    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>	    		
					    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appName"/>	    		
					    		<xsl:with-param name="selectedForm">custom_grid</xsl:with-param>				    		
					    		<xsl:with-param name="delete">true</xsl:with-param>				    		
					    	</xsl:call-template>
					    </xsl:if>
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'view'">
				    	<xsl:call-template name="custom_view">
				    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
				    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabelSingular"/>
				    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appNameSingular"/>
				    		<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>
				    		<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>	    		
							<xsl:with-param name="assignedto">false</xsl:with-param>
				    		<xsl:with-param name="delete">
				    			<xsl:choose>
				    				<xsl:when test="/APPSHORE/API/my_company/company_alias = 'backoffice'">true</xsl:when>
									<xsl:otherwise>false</xsl:otherwise>
								</xsl:choose>
						    </xsl:with-param>
							<xsl:with-param name="duplicate">false</xsl:with-param>		
							<xsl:with-param name="print">false</xsl:with-param>		
				    	</xsl:call-template>				    					    	
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'edit'">
				    	<xsl:call-template name="custom_edit">
				    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
				    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabelSingular"/>
				    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appNameSingular"/>
				    		<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>
				    		<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>  		
							<xsl:with-param name="assignedto">false</xsl:with-param>
							<xsl:with-param name="duplicate">false</xsl:with-param>
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
