<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>


<xsl:template name="customLinked">
	<xsl:param name="masterForm"/>
	<xsl:param name="masterTableName"/>	
	<xsl:param name="masterRecordId"/>	
	<xsl:param name="masterRecordIdValue"/>	
	<xsl:param name="masterRecordNameValue"/>	
	
 	<script language="JavaScript" type="text/javascript" src="{$lib_js_path}/linked.js"/>		
    <xsl:if test = "/APPSHORE/API/tag">
		<script language="JavaScript" type="text/javascript" src="{$lib_js_path}/lists.js?language={/APPSHORE/API/current_user/language_id}"/>		
    </xsl:if>
			
	<xsl:for-each select = "linked/*" >
		<xsl:variable name="recordId" select="record_id"/>				
		<xsl:variable name="appName" select="name()"/>
		<xsl:variable name="relatedName" select="related_name"/>
		<xsl:variable name="quickadd" select="/APPSHORE/APP/quickadd" />

	    <div class="clearboth linkedFormTitle">
			<xsl:value-of select="php:functionString('lang',app_label)"/>
		</div>

		<xsl:variable name="recordsCount" select="count(/APPSHORE/APP/linked/node()[name() = $appName]/results/results_item)"/>	
	
		<form name="custom_linked_{$appName}" id="custom_linked_{$appName}" method="post" >
			<input type="hidden" name="op" value="{$appName}.base.linked"/>
			<input type="hidden" name="orderby" value="{orderby}"/>		
			<input type="hidden" name="ascdesc" value="{ascdesc}"/>	
			<input type="hidden" name="key" />	
			<input type="hidden" name="bulk_id" id="bulk_id" value="Selected"/>	
			<input type="hidden" name="selected" id="selected"/>	
			<input type="hidden" name="nbrecords" />			
			<input type="hidden" name="recordId" value="{$masterRecordId}"/>	
			<input type="hidden" name="recordIdValue" value="{$masterRecordIdValue}"/>	
			<input type="hidden" name="recordNameValue" value="{$masterRecordIdValue}"/>	

		<table class="resizable sortable searchResultsTable" border="0" style="width:100%" cellspacing="0" cellpadding="0">
			<tr class="searchResultsHeader">
			    <td class="searchResultsHeaderIcons"/>				
				<td class="searchResultsHeaderIcons"/>
				<td class="searchResultsHeaderIcons"/>
				<xsl:for-each select = "/APPSHORE/APP/linked/node()[name() = $appName]/linked_fields/linked_fields_item[field_name != $relatedName]" >
				<th>
		            <xsl:attribute name="class">searchResultsHeaderCells<xsl:if test="field_type = 'DA' or field_type = 'DT' or field_type = 'TS'"><xsl:if test="/APPSHORE/API/current_user/locale_date_id = '%m/%d/%Y'"> date-us</xsl:if></xsl:if>
					</xsl:attribute>
			        <a href="javascript:void(0)"><xsl:value-of select="php:functionString('lang',field_label)"/></a>
				</th>					
				</xsl:for-each>									
			</tr>
			
		<xsl:for-each select = "/APPSHORE/APP/linked/node()[name() = $appName]/results/results_item">
			<xsl:variable name="currentRecord" select="current()"/>					
			<xsl:variable name="recordId_value" select="*[name() = $recordId]"/>					
			<xsl:variable name="unselectedtext">
				<xsl:choose>
					<xsl:when test ="record_date = 'new'">new</xsl:when>
					<xsl:when test ="record_date = 'expired'">expired</xsl:when>
				</xsl:choose>
			</xsl:variable>											
			<tr class="{record_class}" onMouseOver="this.className ='searchResultsSelected'" onMouseOut="this.className ='{record_class}'">
				<td class="searchResultsIcons" >		
				    <xsl:call-template name="linkedCheckListForm">
						<xsl:with-param name="thisForm">custom_linked_<xsl:value-of select="$appName"/></xsl:with-param>				
						<xsl:with-param name="thisId" select="$recordId_value"/>					
						<xsl:with-param name="scope" select="/APPSHORE/APP/linked/node()[name() = $appName]/linked_scope"/>	
					</xsl:call-template>	
				</td>							
				<td class="searchResultsIcons" >		
					<xsl:if test="/APPSHORE/APP/linked/node()[name() = $appName]/linked_scope > 0"> 								
						<a href="{$baseurl}&amp;op={$appName}.base.edit&amp;{$recordId}={$recordId_value}">
	            	        <img class="image" src="{$api_image_path}/edit.png"/>
	         			</a>												
	         		</xsl:if>
				</td>									
				<td  class="searchResultsIcons" >
		            <a href="{$baseurl}&amp;op={$appName}.base.view&amp;{$recordId}={$recordId_value}" onMouseOver="popupDetails('{$baseurl}&amp;op={$appName}.popup.view&amp;{$recordId}={$recordId_value}','{app_label}','{$api_image_path}','{$appName}');" onMouseOut="return nd();"  >
	                    <img class="image" src="{$api_image_path}/view.png"/>
	         		</a>												
				</td>				
				<xsl:for-each select = "/APPSHORE/APP/linked/node()[name() = $appName]/linked_fields/linked_fields_item[field_name != $relatedName]" >
					<td class="searchResultsCells {result_class}">
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

		<xsl:variable name="fieldsCount" select="count(/APPSHORE/APP/linked/node()[name() = $appName]/linked_fields/linked_fields_item[field_name != $relatedName])+3"/>	
	    <xsl:if test="$recordsCount = 0">
	    	<tr style="text-align:center;vertical-align:middle">
	    		<td colspan="{$fieldsCount}">
				 	<H3 style="color:lightgrey;">
				 		<xsl:value-of select="php:function('lang','No entries')"/>
				 	</H3>
				</td>
			</tr>
	    </xsl:if>	
	</table>
			
	</form>
	
 	<div class="clearboth linkedFormBar">
		<xsl:if test="(/APPSHORE/APP/scope > 0) and ($recordsCount > 0)"> 								
			<div class="formBarContent">
			    <xsl:call-template name="linkedCheckAllListForm">
					<xsl:with-param name="thisForm">custom_linked_<xsl:value-of select="$appName"/></xsl:with-param>				
				</xsl:call-template>				
			</div>
		</xsl:if>
		<div class="formBarContent">
        	<xsl:variable name="quote">'</xsl:variable>
		    <xsl:call-template name="customLinkedButtons">
				<xsl:with-param name="masterForm" select="$masterForm"/>		
				<xsl:with-param name="thisForm">custom_linked_<xsl:value-of select="$appName"/></xsl:with-param>				
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="appLabel" select="translate(app_label,$quote,'')"/>					
				<xsl:with-param name="masterTableName" select="$masterTableName"/>			
				<xsl:with-param name="masterRecordId" select="$masterRecordId"/>			
				<xsl:with-param name="masterRecordIdValue" select="$masterRecordIdValue"/>			
				<xsl:with-param name="masterRecordNameValue" select="translate($masterRecordNameValue,$quote,'')"/>				
				<xsl:with-param name="recordsCount" select="$recordsCount"/>		
			</xsl:call-template>        
		</div>					
	</div>		
	
	
	</xsl:for-each>
</xsl:template>

<xsl:template name="customLinkedButtons">
	<xsl:param name="masterForm"/>								
	<xsl:param name="thisForm"/>								
	<xsl:param name="appName"/>								
	<xsl:param name="appLabel"/>								
	<xsl:param name="masterTableName"/>								
	<xsl:param name="masterRecordId"/>								
	<xsl:param name="masterRecordIdValue"/>	
	<xsl:param name="masterRecordNameValue"/>	
	<xsl:param name="recordsCount"/>	
						
    <div>							
		<xsl:if test="(/APPSHORE/APP/linked/node()[name() = $appName]/linked_scope > 0)  and ($recordsCount > 0)">   					 		                                    
			<input type="button" class="formBarButton" onclick="confirmDeleteSelectedRecords({$masterForm},{$thisForm},'{$appName}','{$masterRecordId}','{$masterRecordIdValue}','{/APPSHORE/API/current_user/confirm_delete}');">
	            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Delete')"/></xsl:attribute>
	            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Delete selection')"/></xsl:attribute>	            
	        </input>&#160;
		</xsl:if>  	
		<xsl:if test="((/APPSHORE/APP/linked/node()[name() = $appName]/linked_scope > 0) or (/APPSHORE/APP/linked/node()[name() = $appName]/scope > 0)) and ($recordsCount > 0)">   					 		                                    
			<input type="button" class="formBarButton" onclick="unlinkSelectedRecords({$masterForm},{$thisForm},'{$appName}','{$masterTableName}','{$masterRecordIdValue}');">
	            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Unlink')"/></xsl:attribute>
	            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Unlink selection')"/></xsl:attribute>	            
	        </input>&#160;
		</xsl:if>  	
		<xsl:if test="/APPSHORE/APP/linked/node()[name() = $appName]/linked_scope > 0">   					 		                                    
			<input type="button" class="formBarButton" name="Add" onclick="linkAddPopup('{$appName}','{$appLabel}','{$masterTableName}','{$masterRecordId}','{$masterRecordIdValue}','{$masterRecordNameValue}');">
	            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Add')"/></xsl:attribute>
	            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Add and link a new record')"/></xsl:attribute>	            
			</input>&#160;
		</xsl:if>  	
		<xsl:if test="/APPSHORE/APP/linked/node()[name() = $appName]/linked_scope > 0 or /APPSHORE/APP/linked/node()[name() = $appName]/scope > 0 ">   					 		                                    
			<input type="button" class="formBarButton" name="Link" onclick="linkSearchPopup('{$appName}','{$appLabel}','{$masterTableName}','{$masterRecordIdValue}');">
	            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Link')"/></xsl:attribute>
	            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Link an existing record')"/></xsl:attribute>	            
			</input>&#160;
		</xsl:if>
		
	    <xsl:if test = "/APPSHORE/API/tag">
			<script language='javascript' >
				var <xsl:value-of select="$appName"/>_list = new Lists(document.<xsl:value-of select="$thisForm"/>,document.<xsl:value-of select="$thisForm"/>);
			</script>	    
	    	<xsl:call-template name="listLinkedForm">
	    		<xsl:with-param name="appName" select="$appName"/>
	    		<xsl:with-param name="thisForm" select="$thisForm"/>
				<xsl:with-param name="targetAppName">tags</xsl:with-param>				
				<xsl:with-param name="targetAppLabel">Tag</xsl:with-param>				
				<xsl:with-param name="targetClassName">tags.ajax</xsl:with-param>				
				<xsl:with-param name="addSelectionLabel">Add a tag</xsl:with-param>				
				<xsl:with-param name="createSelectionLabel">Create a new tag</xsl:with-param>				
				<xsl:with-param name="useSelectionLabel">Use an existing tag</xsl:with-param>				
	    	</xsl:call-template>&#160;
	    </xsl:if>      
	</div>	
</xsl:template>

<xsl:template name="listLinkedForm">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>
	<xsl:param name="targetAppName"/>
	<xsl:param name="targetAppLabel"/>
	<xsl:param name="targetClassName"/>
	<xsl:param name="addSelectionLabel"/>
	<xsl:param name="createSelectionLabel"/>
	<xsl:param name="useSelectionLabel"/>

	<select class="fieldInputSelect" name="{$appName}_{$targetAppName}_list_id" id="{$appName}_{$targetAppName}_list_id" onChange="document.{$thisForm}.selected.value=getSelected(document.{$thisForm}); {$appName}_list.listSelect(this, '{$appName}', '{$targetAppName}', '{$targetAppLabel}', '{$targetClassName}');">
		<option selected="true" value="0">					
			<xsl:value-of select="php:functionString('lang',$addSelectionLabel)"/>
		</option>
		<option value="1" style="padding-left:1em">					
			<xsl:value-of select="php:functionString('lang',$createSelectionLabel)"/>
		</option>
		<option disabled="disabled" style="padding-left:1em">
			<xsl:value-of select="php:functionString('lang',$useSelectionLabel)"/>
		</option>
	</select>	
    <img border="0">
		<xsl:attribute name="src"><xsl:value-of select="$api_image_path" />/invisible.gif</xsl:attribute>
        <xsl:attribute name="onLoad"><xsl:value-of select="$appName"/>_list.getLists($('<xsl:value-of select="$appName"/>_<xsl:value-of select="$targetAppName"/>_list_id'),'<xsl:value-of select="$targetClassName"/>');</xsl:attribute>	            
	</img>			

</xsl:template>

<xsl:template name="linkedCheckAllListForm">
	<xsl:param name="thisForm"/>
	<xsl:value-of select="php:function('lang','Select')"/>:&#160;
	<a href="javascript:void(0)" onclick="linkedAllCheckbox(document.{$thisForm},true);">
		<xsl:value-of select="php:function('lang','All')"/>
	</a>,&#160;
	<a href="javascript:void(0)" onclick="linkedAllCheckbox(document.{$thisForm},false);">
		<xsl:value-of select="php:function('lang','None')"/>
	</a>
</xsl:template>

<xsl:template name="linkedCheckListForm">
	<xsl:param name="thisForm"/>
	<xsl:param name="thisId"/>
	<xsl:param name="scope"/>	
	<xsl:if test="$scope > 0 "> 		
		<input class="searchResultsCheckbox" id="{$thisId}" name="{$thisId}" onclick="checkTheBox(this);" type="checkbox" value="0"/>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
