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
				    		<xsl:with-param name="appName"><xsl:value-of select="/APPSHORE/APP/recordset/appName"/></xsl:with-param>
				    		<xsl:with-param name="appLabel"><xsl:value-of select="/APPSHORE/APP/recordset/appLabel"/></xsl:with-param>
				    	</xsl:call-template>	
				    	<xsl:call-template name="history_grid">
				    		<xsl:with-param name="appName"><xsl:value-of select="/APPSHORE/APP/recordset/appName"/></xsl:with-param>
				    		<xsl:with-param name="appLabel"><xsl:value-of select="/APPSHORE/APP/recordset/appLabel"/></xsl:with-param>
				    		<xsl:with-param name="nodeName"><xsl:value-of select="/APPSHORE/APP/recordset/appName"/></xsl:with-param>				    		
				    		<xsl:with-param name="recordId"><xsl:value-of select="/APPSHORE/APP/recordset/appRecordId"/></xsl:with-param>		
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


<xsl:template name="history_grid">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>
	<xsl:param name="nodeName"/>		
	<xsl:param name="recordId"/>	

    <div class="clearboth formTitle">
		<xsl:value-of select="php:functionString('lang',$appLabel)"/>
	</div>
		
	<form name="history_grid" method="post" >
		<input type="hidden" name="op" value="{$appName}.base.search"/>
		<input type="hidden" name="orderby" value="{/APPSHORE/APP/recordset/orderby}"/>		
		<input type="hidden" name="ascdesc" value="{/APPSHORE/APP/recordset/ascdesc}"/>	
		<input type="hidden" name="key" />	
		<input type="hidden" name="selected" />	
		<input type="hidden" name="nbrecords" />			
	
		<table class="formBar" border="0" cellspacing="0" cellpadding="0">
			<tr class="formBarContent">
				<td class="formBarContent end_direction">
				    <xsl:call-template name="gridButtons">
						<xsl:with-param name="thisForm" select="'history_grid'"/>
					</xsl:call-template>        
				</td>
			</tr>					
		</table>						

		<xsl:variable name="fieldsCount" select="count(/APPSHORE/APP/result_fields/result_fields_item)+2"/>					

		<table class="resizable searchResultsTable" border="0" cellspacing="0" cellpadding="0">
			<tr class="searchResultsHeader">
				<xsl:for-each select = "/APPSHORE/APP/result_fields/result_fields_item" >
					<th class="searchResultsCells">
						<xsl:call-template name="gridFieldsHeader">
							<xsl:with-param name="thisForm">history_grid</xsl:with-param>
						</xsl:call-template>	
					</th>					
				</xsl:for-each>									
			</tr>
			
			<xsl:variable name="items"><xsl:value-of select="$nodeName"/>_item</xsl:variable>					
			<xsl:for-each select = "/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $items]">
				<xsl:variable name="currentRecord" select="current()"/>					
				<xsl:variable name="recordId_value" select="*[name() = $recordId]"/>					
				<xsl:variable name="unselectedtext"><xsl:choose><xsl:when test ="record_date = 'new'">new</xsl:when><xsl:when test ="record_date = 'expired'">expired</xsl:when><xsl:otherwise>unselectedtext</xsl:otherwise></xsl:choose></xsl:variable>											
				<tr class="{$unselectedtext}" onMouseOver="this.className ='selectedtext'" onMouseOut="this.className ='{$unselectedtext}'">
					<xsl:for-each select = "/APPSHORE/APP/result_fields/result_fields_item" >
						<td class="{result_class}">
							<xsl:call-template name="gridFields">
								<xsl:with-param name="appName" select="$appName"/>
								<xsl:with-param name="recordId" select="$recordId"/>
								<xsl:with-param name="recordId_value" select="$recordId_value"/>
								<xsl:with-param name="currentRecord" select="$currentRecord"/>
								<xsl:with-param name="currentField" select="current()"/>
								<xsl:with-param name="unselectedtext" select="$unselectedtext"/>
							</xsl:call-template>	
						</td>	
					</xsl:for-each>																					
				</tr>
			</xsl:for-each>
			<xsl:variable name="recordsCount" select="count(/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $items])"/>	
			<xsl:choose>
			    <xsl:when test="$recordsCount = 0">
			    	<tr style="text-align:center;vertical-align:middle"><td colspan="{$fieldsCount}">
       				 	<H2 style="color:lightgrey;line-height:4em"><xsl:value-of select="php:function('lang','No entries')"/></H2>
					</td></tr>
			    </xsl:when>	
			    <xsl:when test="(5-$recordsCount) > 0">
			    	<tr><td colspan="{$fieldsCount}" style="line-height:{8-$recordsCount}em">&#160;
 					</td></tr>
			    </xsl:when>	
			</xsl:choose>					
		</table>
	
		<table class="formBar" border="0" cellspacing="0" cellpadding="0">
			<tr class="formBarContent">
				<td class="formBarContent end_direction">
				    <xsl:call-template name="gridButtons">
						<xsl:with-param name="thisForm" select="'history_grid'"/>
					</xsl:call-template>        
				</td>
			</tr>					
		</table>						

	</form>

</xsl:template>


</xsl:stylesheet>
