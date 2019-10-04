<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP[action/node()[name() = /APPSHORE/APP/recordset/appName]]">
    <table width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
			<td class="left_panel" id="left_panel" style="display:{/APPSHORE/API/cookie/left_panel}">
			    <xsl:call-template name="verticalMenus">		    
					<xsl:with-param name="appName">administration</xsl:with-param>
					<xsl:with-param name="appLabel">Administration</xsl:with-param>
				</xsl:call-template>	
			</td>
            <td id="right_panel" class="right_panel">
				<xsl:choose>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'start'">
				    	<xsl:call-template name="departments_start"/>
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'view'">
				    	<xsl:call-template name="custom_view">
				    		<xsl:with-param name="appName"><xsl:value-of select="/APPSHORE/APP/recordset/appName"/></xsl:with-param>
				    		<xsl:with-param name="appLabel"><xsl:value-of select="/APPSHORE/APP/recordset/appLabelSingular"/></xsl:with-param>
				    		<xsl:with-param name="nodeName"><xsl:value-of select="/APPSHORE/APP/recordset/appNameSingular"/></xsl:with-param>
				    		<xsl:with-param name="recordId"><xsl:value-of select="/APPSHORE/APP/recordset/appRecordId"/></xsl:with-param>		
				    		<xsl:with-param name="recordName"><xsl:value-of select="/APPSHORE/APP/recordset/appRecordName"/></xsl:with-param>					    		
							<xsl:with-param name="assignedto">false</xsl:with-param>
							<xsl:with-param name="delete">false</xsl:with-param>
							<xsl:with-param name="duplicate">false</xsl:with-param>		
							<xsl:with-param name="print">false</xsl:with-param>		
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
							<xsl:with-param name="duplicate">false</xsl:with-param>
				    	</xsl:call-template>				    					    	
					</xsl:when>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'orgchart'">
				    	<xsl:call-template name="departments_orgchart"/>
					</xsl:when>
					<xsl:otherwise>
				    	<xsl:call-template name="custom_actions"/>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name="departments_start">
	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Departments</xsl:with-param>
	</xsl:call-template>
    <div>
		<xsl:value-of disable-output-escaping="yes" select="php:function('lang','administration.departments.start')"/>
	</div>	
</xsl:template>


<xsl:template name="departments_orgchart">

	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Departments</xsl:with-param>
	</xsl:call-template>
	<table class="searchResultsTable" border="0" width="100%" cellpadding="1" cellspacing="1" style="line-height:2em">
		<tr class="searchResultsHeader">
			<td class="searchResultsHeaderCells">
				<xsl:value-of select="php:function('lang','Department')"/>
			</td>
			<td class="searchResultsHeaderCells">
				<xsl:value-of select="php:function('lang','Manager')"/>
			</td>
			<td class="searchResultsHeaderCells">
				<xsl:value-of select="php:function('lang','Assistant')"/>
			</td>			
			<td class="searchResultsHeaderCells">
				<xsl:value-of select="php:function('lang','Users')"/>
			</td>			
		</tr>		
		<xsl:for-each select = "administration_departments/administration_departments_item">
			<tr class="unselectedtext" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">					
				<td class="searchResultsCells">
					<xsl:call-template name="loop">
						<xsl:with-param name="i">1</xsl:with-param>
						<xsl:with-param name="count"><xsl:value-of select="level"/></xsl:with-param>
					</xsl:call-template>
					<a href="{$baseurl}&amp;op=administration.departments_base.view&amp;department_id={department_id}"  >
						<xsl:value-of select="department_name"/>							
					</a>					
				</td>
				<td class="searchResultsCells">
					<a href="{$baseurl}&amp;op=administration.users_base.view&amp;user_id={manager_id}">
						<xsl:value-of select="manager_full_name"/>
					</a>
				</td>				
				<td class="searchResultsCells">
					<a href="{$baseurl}&amp;op=administration.users_base.view&amp;user_id={assistant_id}">
						<xsl:value-of select="assistant_full_name"/>
					</a>
				</td>					
				<td class="searchResultsCells">
					<xsl:for-each select = "users/users_item">				
						<a href="{$baseurl}&amp;op=administration.users_base.view&amp;user_id={user_id}">
							<xsl:value-of select="full_name"/>
						</a>&#160;&#160;&#160;
					</xsl:for-each>						
				</td>				
			</tr>	
		</xsl:for-each>
	</table>
</xsl:template>

<xsl:template name="loop">
	<xsl:param name="i"/>
	<xsl:param name="count"/>
	<xsl:if test="$i &lt; $count">
<!--    body of the loop goes here    -->
		&#160;&#160;&#160;&#160;&#160;
<!--    end of body of the loop   -->
		<xsl:call-template name="loop">
			<xsl:with-param name="i">
				<xsl:value-of select="$i + 1"/>
			</xsl:with-param>
			<xsl:with-param name="count">
				<xsl:value-of select="$count"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>


</xsl:stylesheet>
