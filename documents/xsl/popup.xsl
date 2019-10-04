<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP[action/node()[name() = /APPSHORE/APP/recordset/appName]]">
    <table width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
		    <xsl:call-template name="leftPanel"/>
            <td id="right_panel" class="right_panel">
				<xsl:choose>
									
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'popup_search'">
				    	<xsl:call-template name="custom_popup_search">
				    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
				    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabel"/>
				    	</xsl:call-template>	
				    	<xsl:call-template name="folder">
				    		<xsl:with-param name="is_popup" select="'true'"/>
				    		<xsl:with-param name="is_multiple" select="/APPSHORE/APP/recordset/is_multiple"/>
				    	</xsl:call-template>
						<xsl:choose>
							<xsl:when test="/APPSHORE/APP/recordset/is_attachment = 'true'">
						    	<xsl:call-template name="documents_popup_grid">
						    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
						    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabel"/>
						    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appName"/>
						    		<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>
						    		<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>
						    		<xsl:with-param name="is_multiple" select="/APPSHORE/APP/recordset/is_multiple"/>
						    	</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
						    	<xsl:call-template name="custom_popup_grid">
						    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
						    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabel"/>
						    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appName"/>
						    		<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>	
						    		<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>
						    		<xsl:with-param name="is_multiple" select="/APPSHORE/APP/recordset/is_multiple"/>
						    	</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					
					<xsl:otherwise>
				    	<xsl:call-template name="custom_actions"/>
					</xsl:otherwise>
					
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name='documents_popup_grid'>
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>
	<xsl:param name="nodeName"/>		
	<xsl:param name="recordId"/>	
	<xsl:param name="recordName"/>	
	<xsl:param name="is_multiple"/>	

	<script LANGUAGE="JavaScript" >
	<![CDATA[
		function passBackSelected( MyForm)
		{
			var myDoc = top.window.thisDocument;
				
			var docList = myDoc.getElementById('documentsList');
		
			for (var i = 0; i < MyForm.elements.length; i++)
				if (  MyForm.elements[i].type == 'checkbox' && MyForm.elements[i].checked == true && MyForm.elements[i].value != '0' && MyForm.elements[i].name != 'check_all')
				{
					if( divCount(docList) >= 10 )
					{
						return false;
					}
				
		            selected = MyForm.elements[i].value.split('/');

					// not twice the same document
					if( myDoc.getElementById('doc-'+selected[0]) )
						continue;
					
					var new_row = myDoc.createElement( 'div' );		
					new_row.name = 'rows';		
					new_row.id = 'doc-'+selected[0];
												
					// Hidden button			
					var new_row_input = myDoc.createElement( 'input' );
					new_row_input.type = 'checkbox';
					new_row_input.name = 'document_ids';	
					new_row_input.value = selected[0];						
					new_row_input.onclick = function(){
						this.parentNode.remove();
					};
					new_row.appendChild( new_row_input );			
							
					// Add text
					var new_row_text = myDoc.createElement( 'text' );		
					new_row_text.innerHTML = '&#160;'+selected[1];		
					new_row.appendChild( new_row_text );

					// Add it to the list
					docList.appendChild( new_row );	
		
					// for IE must be checked once the row is added to the list	
					new_row_input.checked = true;
				}			
		}
		
		function divCount(element)
		{
	    	var count = 0;
	    	var child = element.firstChild;

	    	while (child)
	    	{
	        	if (child.nodeName=="DIV") 
	        		count++;
	        	child = child.nextSibling;
	    	}
	    	return count;    
		}

	]]>
	</script>	
	
	<xsl:variable name="formName">document_popup_grid</xsl:variable>	
	<form name="{$formName}" method="post" >
		<input type="hidden" name="op" id="op" value="{$appName}.popup.search"/>
		<input type="hidden" name="orderby" id="orderby" value="{/APPSHORE/APP/recordset/orderby}"/>		
		<input type="hidden" name="ascdesc" id="ascdesc" value="{/APPSHORE/APP/recordset/ascdesc}"/>	
		<input type="hidden" name="readonly" id="readonly" value="{/APPSHORE/APP/recordset/readonly}"/>	
		<input type="hidden" name="is_multiple" id="is_multiple" value="{$is_multiple}"/>	
		<input type="hidden" name="key" id="key"/>	
		<input type="hidden" name="selected" id="selected"/>	

		<!-- popup_results list -->
	
		<div class="clearboth formBar">
			<xsl:if test="(/APPSHORE/APP/scope > 0) and ($is_multiple = 'true')"> 								
				<div class="formBarContent start_float">
				    <xsl:call-template name="gridCheckAllListForm">
						<xsl:with-param name="thisForm" select="$formName"/>				
					</xsl:call-template>				
				</div>
			</xsl:if>
			<div class="formBarContent end_float">
			    <xsl:call-template name="gridButtons">
					<xsl:with-param name="thisForm" select="$formName"/>				
				</xsl:call-template>        
			</div>					
		</div>										
		

		<xsl:variable name="fieldsCount" select="count(/APPSHORE/APP/popup_result_fields/popup_result_fields_item)"/>	
		
		<table class="resizable searchResultsTable" border="0" cellspacing="0" cellpadding="0">
			<tr class="searchResultsHeader">
			    <td class="searchResultsCells"/>				
				<xsl:for-each select = "/APPSHORE/APP/popup_result_fields/popup_result_fields_item" >
					<th class="searchResultsCells">
						<xsl:call-template name="gridFieldsHeader">
							<xsl:with-param name="thisForm" select="$formName"/>
						</xsl:call-template>	
					</th>					
				</xsl:for-each>									
			</tr>
		
			<xsl:variable name="items"><xsl:value-of select="$nodeName"/>_item</xsl:variable>					
			<xsl:for-each select = "/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $items]">
				<xsl:variable name="currentRecord" select="current()"/>					
				<xsl:variable name="recordId_value" select="*[name() = $recordId]"/>
				<xsl:variable name="recordName_value">					
					<xsl:choose>
					    <xsl:when test="$currentRecord/last_name">
							<xsl:value-of select="$currentRecord/first_names"/>&#160;<xsl:value-of select="$currentRecord/last_name"/>
					    </xsl:when>
					    <xsl:otherwise>
							<xsl:value-of select="*[name() = $recordName]"/>
				   	   </xsl:otherwise>			    		    
					</xsl:choose>
				</xsl:variable>					
				<xsl:variable name="unselectedtext">
					<xsl:choose>
						<xsl:when test ="record_date = 'new'">new</xsl:when>
						<xsl:when test ="record_date = 'expired'">expired</xsl:when>
					</xsl:choose>
				</xsl:variable>											
				<tr class="{record_class}" onMouseOver="this.className ='searchResultsSelected'" onMouseOut="this.className ='{record_class}'">
					<td class="searchResultsIcons" >		
					    <xsl:call-template name="gridCheckListForm">
							<xsl:with-param name="thisForm" select="'document_popup_grid'"/>
							<xsl:with-param name="thisId"><xsl:value-of select="document_id"/>/<xsl:value-of select="document_name"/></xsl:with-param>					
							<xsl:with-param name="scope" select="scope"/>				
						</xsl:call-template>
					</td>
					<xsl:for-each select = "/APPSHORE/APP/popup_result_fields/popup_result_fields_item" >
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
			
		<div class="clearboth formBar">
			<xsl:if test="(/APPSHORE/APP/scope > 0) and ($is_multiple = 'true')"> 								
				<div class="formBarContent start_float">
				    <xsl:call-template name="gridCheckAllListForm">
						<xsl:with-param name="thisForm" select="$formName"/>				
					</xsl:call-template>				
				</div>
			</xsl:if>
			<div class="formBarContent end_float">
			    <xsl:call-template name="gridButtons">
					<xsl:with-param name="thisForm" select="$formName"/>				
				</xsl:call-template>        
			</div>					
		</div>										

	</form>
	  
    <div class="boxtitle buttonbar clearboth">
		<input type="button" class="formBarButton" name="Attach"  onclick="passBackSelected(document.document_popup_grid);">
	        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Attach selection')"/></xsl:attribute>	            
	        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Attach')"/></xsl:attribute>
	    </input>&#160;        
		<input type='button' class="formBarButton" onClick="popupClose();">
       		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
        	<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
    	</input>
	</div>			

</xsl:template>
</xsl:stylesheet>
