<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="custom_actions">

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
	    	</xsl:call-template>
		</xsl:when>
		
		<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'view'">
	    	<xsl:call-template name="custom_view">
	    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
	    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabelSingular"/>
	    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appNameSingular"/>
	    		<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>		
	    		<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>
	    	</xsl:call-template>				    	
		</xsl:when>
		
		<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'edit'">

<!--			<xsl:if test="/APPSHORE/APP/recordset/appName = 'activities' or /APPSHORE/APP/recordset/appName = 'cases'  or /APPSHORE/APP/recordset/appName = 'opportunities'">-->
<!--		    	<xsl:call-template name="beta_period">-->
<!--	    			<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>-->
<!--	    			<xsl:with-param name="feature" select="'reminders'"/>-->
<!--	    		</xsl:call-template>-->
<!--			</xsl:if>-->
			
	    	<xsl:call-template name="custom_edit">
	    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
	    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabelSingular"/>
	    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appNameSingular"/>
	    		<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>		
	    		<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>
	    	</xsl:call-template>
		</xsl:when>
		
		<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'print'">
	    	<xsl:call-template name="custom_print">
	    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
	    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabelSingular"/>
	    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appNameSingular"/>
	    		<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>		
	    		<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>
	    	</xsl:call-template>				    	
	    	<xsl:call-template name="custom_print_view">
	    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
	    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabelSingular"/>
	    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appNameSingular"/>
	    		<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>		
	    		<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>
	    	</xsl:call-template>				    	
		</xsl:when>			
				
		<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'popup_search'">
	    	<xsl:call-template name="custom_popup_search">
	    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
	    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabel"/>
	    	</xsl:call-template>	
	    	<xsl:call-template name="custom_popup_grid">
	    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
	    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabel"/>
	    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appName"/>
	    		<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>
	    		<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>
	    		<xsl:with-param name="is_multiple" select="/APPSHORE/APP/recordset/is_multiple"/>
	    	</xsl:call-template>
		</xsl:when>
		
		<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'popup_view'">
	    	<xsl:call-template name="custom_popup_view">
	    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
	    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabelSingular"/>
	    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appNameSingular"/>
	    		<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>		
	    		<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>
	    	</xsl:call-template>				    	
		</xsl:when>		
					
		<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'popup_edit'">
	    	<xsl:call-template name="custom_popup_edit">
	    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
	    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabelSingular"/>
	    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appNameSingular"/>
	    		<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>		
	    		<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>
	    	</xsl:call-template>
		</xsl:when>
				
		<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'popup_confirm_delete'">
	    	<xsl:call-template name="custom_popup_confirm_delete"/>
		</xsl:when>
		
	</xsl:choose>
	
</xsl:template>

<xsl:template name='beta_period'>
	<xsl:param name="appName"/>
	<xsl:param name="feature"/>
	<br/>
	<div class="helpmsg">
		<xsl:variable name="template"><xsl:value-of select="$appName"/>.beta.<xsl:value-of select="$feature"/></xsl:variable>
		<xsl:value-of select="php:functionString('lang',$template, /APPSHORE/API/brand)"/>
	</div>	
</xsl:template>

</xsl:stylesheet>
