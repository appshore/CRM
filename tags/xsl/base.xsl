<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP[action/tags]">
    <table width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
		    <xsl:call-template name="leftPanel"/>
            <td id="right_panel" class="right_panel">
			    <div class="clearboth formTitle">
		            <xsl:value-of select="php:function('lang','Tag')"/>:&#160;
					<span id="tagName"><xsl:value-of select="tag_name"/></span>
				</div>		
				<div id="tag_{tag_id}_div">
				    <div class="clearboth">
				    	<xsl:call-template name="tagButtons">			    	
			    			<xsl:with-param name="tagId"><xsl:value-of select="tag_id"/></xsl:with-param>
			    			<xsl:with-param name="tagName"><xsl:value-of select="tag_name"/></xsl:with-param>				    		
				    	</xsl:call-template>
					</div>		
					<xsl:for-each select = "/APPSHORE/APP/apps/apps_item">
				    	<xsl:call-template name="tagGrid">			    	
			    			<xsl:with-param name="appName"><xsl:value-of select="app_name"/></xsl:with-param>
			    			<xsl:with-param name="appLabel"><xsl:value-of select="app_label"/></xsl:with-param>					    		
			    			<xsl:with-param name="nodeName"><xsl:value-of select="app_name"/></xsl:with-param>				    		
			    			<xsl:with-param name="recordId"><xsl:value-of select="field_name"/></xsl:with-param>		
			    			<xsl:with-param name="tagId"><xsl:value-of select="/APPSHORE/APP/tag_id"/></xsl:with-param>
				    	</xsl:call-template>
				    </xsl:for-each>
			    </div>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name="tagButtons">
	<xsl:param name="tagId"/>	
	<xsl:param name="tagName"/>
	
	<script language="JavaScript" type="text/javascript" src="{$lib_js_path}/tags.js"/>		

	<script language='javascript' >
		var tag = new Tags();
	</script>	    
	
	<input type="button" class="formBarButton" name="Rename" onclick="tag.renameTag('{$tagId}');">
        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Rename')"/></xsl:attribute>
        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Rename tag')"/></xsl:attribute>	            
    </input>&#160; 
           
	<input type="button" class="formBarButton" name="Delete" onclick="tag.confirmDeleteTag('{$tagId}','{/APPSHORE/API/current_user/confirm_delete}');">
        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Delete')"/></xsl:attribute>
        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Delete tag')"/></xsl:attribute>	            
    </input>
	    
</xsl:template>

<xsl:template name="tagGridButtons">
	<xsl:param name="thisForm"/>								
	<xsl:param name="tagId"/>	
	<xsl:if test="/APPSHORE/APP/scope > 0 ">   					 		                				
		<input type="button" class="formBarButton" name="Remove" onclick="tag.removeSelected(document.{$thisForm},'{$tagId}',null);">
	        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Remove')"/></xsl:attribute>
	        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Remove tag from the selected records')"/></xsl:attribute>	            
	    </input> 
	</xsl:if>
</xsl:template>


<xsl:template name="tagGrid">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>
	<xsl:param name="nodeName"/>		
	<xsl:param name="recordId"/>	
	<xsl:param name="tagId"/>	

<div id="tagGrid_{$appName}_div">

    <div class="clearboth linkedFormTitle">
		<xsl:value-of select="php:functionString('lang',$appLabel)"/>
	</div>

	<form name="tagGrid_{$appName}" id="tagGrid_{$appName}" method="post" >
		<input type="hidden" name="selected" id="selected" />	
	
	<table class="resizable sortable searchResultsTable" id="tagGrid_{$appName}_table" border="0" style="width:100%" cellspacing="0" cellpadding="0">
		<tr class="searchResultsHeader">
			<xsl:if test="(/APPSHORE/APP/node()[name() = $nodeName]/results/results_item/scope > 0)"> 								
			    <td class="searchResultsHeaderIcons"/>				
				<td class="searchResultsHeaderIcons"/>
			</xsl:if>
			<td class="searchResultsHeaderIcons"/>
			<xsl:for-each select = "/APPSHORE/APP/node()[name() = $nodeName]/result_fields/result_fields_item" >
				<th>
		            <xsl:attribute name="class">searchResultsHeaderCells<xsl:if test="field_type = 'DA' or field_type = 'DT' or field_type = 'TS'"><xsl:if test="/APPSHORE/API/current_user/locale_date_id = '%m/%d/%Y'"> date-us</xsl:if></xsl:if>
					</xsl:attribute>
			        <a href="javascript:void(0)"><xsl:value-of select="php:functionString('lang',field_label)"/></a>
				</th>					
			</xsl:for-each>									
		</tr>

		<xsl:for-each select = "/APPSHORE/APP/node()[name() = $nodeName]/results/results_item">
			<xsl:variable name="currentRecord" select="current()"/>					
			<xsl:variable name="recordId_value" select="*[name() = $recordId]"/>					
				<xsl:variable name="unselectedtext">
					<xsl:choose>
						<xsl:when test ="record_date = 'new'">new</xsl:when>
						<xsl:when test ="record_date = 'expired'">expired</xsl:when>
					</xsl:choose>
				</xsl:variable>											
			<tr class="{record_class}" id="tagGrid_{$appName}_{$recordId_value}" onMouseOver="this.className ='searchResultsSelected'" onMouseOut="this.className ='{record_class}'">
				<xsl:if test="scope > 0"> 								
					<td class="searchResultsIcons" >		
					    <xsl:call-template name="gridCheckListForm">
							<xsl:with-param name="thisForm">tagGrid_<xsl:value-of select="$appName"/></xsl:with-param>				
							<xsl:with-param name="thisId"><xsl:value-of select="$recordId_value"/></xsl:with-param>					
							<xsl:with-param name="scope"><xsl:value-of select="/APPSHORE/APP/scope + scope"/></xsl:with-param>					
						</xsl:call-template>	
					</td>							
					<td class="searchResultsIcons" >		
						<a href="{$baseurl}&amp;op={$appName}.base.edit&amp;{$recordId}={$recordId_value}">
	            	        <img class="image" src="{$api_image_path}/edit.png"/>
	         			</a>												
					</td>									
				</xsl:if>
				<td  class="searchResultsIcons" >
		            <a href="{$baseurl}&amp;op={$appName}.base.view&amp;{$recordId}={$recordId_value}" onMouseOver="popupDetails('{$baseurl}&amp;op={$appName}.popup.view&amp;{$recordId}={$recordId_value}','{app_label}','{$api_image_path}','{$appName}');" onMouseOut="return nd();"  >
	                    <img class="image" src="{$api_image_path}/view.png"/>
	         		</a>												
				</td>				
				<xsl:for-each select = "/APPSHORE/APP/node()[name() = $nodeName]/result_fields/result_fields_item" >
					<td class="searchResultsCells">		
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
	</table>
	</form>

		
	<div class="clearboth linkedFormBar">
		<xsl:if test="/APPSHORE/APP/scope > 0"> 								
			<div class="formBarContent">
			    <xsl:call-template name="gridCheckAllListForm">
					<xsl:with-param name="thisForm">tagGrid_<xsl:value-of select="$appName"/></xsl:with-param>				
				</xsl:call-template>				
			</div>
		</xsl:if>
		<div class="formBarContent">
			<xsl:call-template name="tagGridButtons">
				<xsl:with-param name="thisForm">tagGrid_<xsl:value-of select="$appName"/></xsl:with-param>				
				<xsl:with-param name="tagId"><xsl:value-of select="$tagId"/></xsl:with-param>				
			</xsl:call-template>        
		</div>
	</div>

</div>	
</xsl:template>


</xsl:stylesheet>
