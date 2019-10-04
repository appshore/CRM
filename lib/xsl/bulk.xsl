<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="headerBulkForm">
	<xsl:param name="appLabel"/>
    <table class="boxtitle" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr align="left" width="100%">
			<td align="left">
				<xsl:value-of select="php:function('lang','Apply On')"/>&#160;
			 	<select class="fieldInputSelect" name="bulk_id" id="bulk_id">
					<xsl:for-each select = "bulk/bulk_item" >
						<option value="{bulk_id}">
							<xsl:if test="bulk_id = /APPSHORE/APP/recordset/bulk_id">
								<xsl:attribute name="selected" value="true"/>
							</xsl:if>
							<xsl:value-of select="php:functionString('lang',bulk_name)"/>
						</option>
					</xsl:for-each>
				</select>
       		</td>
		</tr>	
	</table>
</xsl:template>

<xsl:template name="footerBulkForm">
	<xsl:param name="bulkForm"/>	
	<xsl:param name="selectedForm"/>	

	<input type="submit" class="formBarButton" name="Save" onclick="gridBulkSave(document.{$bulkForm}, document.{$selectedForm});">
        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
    </input>&#160;        
	<input type="button" class="formBarButton" name="Clear" onclick="gridBulkClear(document.{$bulkForm});">
        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Clear')"/></xsl:attribute>
    </input>

</xsl:template>


<xsl:template name="custom_bulk">
	<xsl:param name="appName"/>		
	<xsl:param name="nodeName"/>		
	<xsl:param name="selectedForm"/>	
	<xsl:param name="delete"/>
	<xsl:param name="remove" select="'false'"/>

    <div class="clearboth formTitle">
		<xsl:value-of select="php:function('lang','Apply on')"/>&#160;
	</div>

	<form name="custom_bulk" method="post" >
		<input type="hidden" name="op" id="op" value="{$appName}.base.search"/>
		<input type="hidden" name="orderby" id="orderby" value="{/APPSHORE/APP/recordset/orderby}"/>		
		<input type="hidden" name="ascdesc" id="ascdesc" value="{/APPSHORE/APP/recordset/ascdesc}"/>	
		<input type="hidden" name="key" id="key"/>	
		<input type="hidden" name="selected" id="selected"/>	
		<input type="hidden" name="nbrecords" id="nbrecords"/>	


		<div class="clearboth formBar">
			<xsl:call-template name="customBulkHeaderButtons">
	    		<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="bulkForm">custom_bulk</xsl:with-param>				
				<xsl:with-param name="selectedForm" select="$selectedForm"/>
				<xsl:with-param name="delete" select="$delete"/>				
				<xsl:with-param name="remove" select="$remove"/>			
			</xsl:call-template>
		</div>	
		
		<div class="clearboth">
			<xsl:call-template name="bodyBulkForm">
				<xsl:with-param name="bulkForm">custom_bulk</xsl:with-param>				
				<xsl:with-param name="selectedForm"><xsl:value-of select="$selectedForm"/></xsl:with-param>				
			</xsl:call-template>	
		</div>
	    
		<xsl:if test = "/APPSHORE/APP/bulk_fields/bulk_fields_item" >
			<div class="clearboth formBar">
				<xsl:call-template name="customBulkFooterButtons">
					<xsl:with-param name="bulkForm">custom_bulk</xsl:with-param>				
					<xsl:with-param name="selectedForm"><xsl:value-of select="$selectedForm"/></xsl:with-param>				
				</xsl:call-template>
			</div>	
		</xsl:if>
				
	</form>		

</xsl:template>


<xsl:template name="bodyBulkForm">
	<xsl:param name="appName"/>		
	<xsl:param name="nodeName"/>		
	<xsl:param name="selectedForm"/>	
	
	<table class="formTable">
		<xsl:for-each select = "bulk_blocks/bulk_blocks_item" >
			<xsl:if test="is_title = 'Y' ">   					 		                                    
				<tr>
					<td class="blockTitle" colspan="2">
						<xsl:value-of select="php:functionString('lang',block_name)"/>
					</td>
				</tr>
			</xsl:if>  				            
			<tr style="width:100%;vertical-align:top">
				<xsl:variable name="blockId"><xsl:value-of select="block_id"/></xsl:variable>
				<xsl:choose>
				    <xsl:when test="columns = '1'">
						<td style="width:100%" colspan="2">
							<xsl:for-each select = "/APPSHORE/APP/bulk_fields/bulk_fields_item[bulk_block_id = $blockId and bulk_side = 'L']" >
								<xsl:call-template name="bulkFields" >
									<xsl:with-param name="thisForm">custom_bulk</xsl:with-param>
								    <xsl:with-param name="appName" select="$appName"/>
								    <xsl:with-param name="nodeName" select="$nodeName"/>
						    	</xsl:call-template>									
							</xsl:for-each>
						</td>						
				    </xsl:when>
				    <xsl:otherwise>
						<td style="width:50%">
							<xsl:for-each select = "/APPSHORE/APP/bulk_fields/bulk_fields_item[bulk_block_id = $blockId and bulk_side = 'L']" >
								<xsl:call-template name="bulkFields" >
									<xsl:with-param name="thisForm">custom_bulk</xsl:with-param>
								    <xsl:with-param name="appName" select="$appName"/>
								    <xsl:with-param name="nodeName" select="$nodeName"/>
						    	</xsl:call-template>									
							</xsl:for-each>
						</td>
						<td style="width:50%">
							<xsl:for-each select = "/APPSHORE/APP/bulk_fields/bulk_fields_item[bulk_block_id = $blockId and bulk_side = 'R']" >
								<xsl:call-template name="bulkFields" >
									<xsl:with-param name="thisForm">custom_bulk</xsl:with-param>
								    <xsl:with-param name="appName" select="$appName"/>
								    <xsl:with-param name="nodeName" select="$nodeName"/>
						    	</xsl:call-template>									
							</xsl:for-each>
						</td>
					   </xsl:otherwise>
				</xsl:choose>
			</tr>
		</xsl:for-each>
	</table>	
</xsl:template>


<xsl:template name="bulkFields">
	<xsl:param name="thisForm"/>
	<xsl:param name="appName"/>
	<xsl:param name="nodeName"/>	

	<div class="fieldContainer">
		<div class="fieldLabel">
			<xsl:choose>
				<xsl:when test="field_type = 'ML'">
					<div class="clearboth fieldLabelContainer">
						<span class="start_float">
							<xsl:attribute name="title"><xsl:value-of select="php:functionString('lang',field_label)"/></xsl:attribute>
							<xsl:value-of select="php:functionString('lang',field_label)"/>
						</span>
						<span class="end_float">
							<a class="fieldAssociatedLink" onclick="insertTimeStamp( document.{$thisForm}.{field_name},'{/APPSHORE/API/current_user/full_name}', true);">
								<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Insert a time stamp in the field')"/></xsl:attribute>
								<img border="0" src="{$api_image_path}/clock_16.png"/>
							</a>
						</span>
					</div>
				</xsl:when>	
				<xsl:otherwise>
					<xsl:attribute name="title"><xsl:value-of select="php:functionString('lang',field_label)"/></xsl:attribute>
					<xsl:value-of select="php:functionString('lang',field_label)"/>
				</xsl:otherwise>
			</xsl:choose>
		</div>
		<div>
			<xsl:choose>
				<xsl:when test="field_type = 'ET' or field_type = 'ML' ">
					<xsl:attribute name="style">height:<xsl:value-of select="(field_height*2)+2"/>em</xsl:attribute>
			    </xsl:when>	
				<xsl:when test="field_type = 'WS' ">
					<xsl:attribute name="style">height:<xsl:value-of select="(field_height*2)-1"/>em</xsl:attribute>
			    </xsl:when>	
				<xsl:otherwise>
					<xsl:attribute name="style">height:<xsl:value-of select="(field_height*2)"/>em</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>

			<xsl:choose>		
				
			    <xsl:when test="field_type = 'CH'">
					<input id="{field_name}" name="{field_name}" type="hidden"/>
					<xsl:value-of select="php:function('lang','Yes')"/>
					<input name="radio_{field_name}" type="radio" onclick="$({field_name}).value='Y';"/>
					&#160;
					<xsl:value-of select="php:function('lang','No')"/>
					<input name="radio_{field_name}" type="radio" onclick="$({field_name}).value='N';"/>				
			    </xsl:when>	
			    			    
			    <xsl:when test="field_type = 'CU' or field_type = 'CD'">
					<xsl:value-of select="/APPSHORE/API/current_user/currency_id" />&#160;<input class="fieldInputCurrency" id="{field_name}" name="{field_name}" type="text" value="{field_current_value}" />
			    </xsl:when>		
			    		    
			    <xsl:when test="field_type = 'DA'">
					<input class="fieldInputDate" id="{field_name}" name="{field_name}" type="text" value="{field_current_value}"/>
					<xsl:call-template name="calendar">
						<xsl:with-param name="field"><xsl:value-of select="field_name"/></xsl:with-param>
						<xsl:with-param name="label"><xsl:value-of select="field_label"/></xsl:with-param>
					</xsl:call-template>
			    </xsl:when>	
			    
			    <xsl:when test="field_type = 'DD'">
					<xsl:variable name="field_value" select="field_current_value"/>
					<select class="fieldInputSelect" id="{field_name}" name="{field_name}">
							<option/>
						<xsl:for-each select = "field_options/field_options_item" >					
							<option value="{option_id}">
								<xsl:if test="option_id = $field_value">
									<xsl:attribute name="selected" value="true"/>
								</xsl:if>												
								<xsl:value-of select="php:functionString('lang',option_name)"/>
							</option>
						</xsl:for-each>																			
					</select>					
			    </xsl:when>	
			    
			    <xsl:when test="field_type = 'DF'">
					<xsl:variable name="field_value" select="field_current_value"/>
					<select class="fieldInputSelect" id="bulk_folder_id" name="bulk_folder_id">
							<option/>
					    <xsl:for-each select = "/APPSHORE/APP/folders/folders_item" >
							<option value="{document_id}">
								<xsl:if test="document_id = $field_value">
									<xsl:attribute name="selected" value="true"/>
								</xsl:if>												
		                        <xsl:call-template name="folderLoop">
		                            <xsl:with-param name="i" select="'1'"/>
		                            <xsl:with-param name="count" select="level"/>
		                        </xsl:call-template>
		                        <xsl:value-of select="document_name" />
		                    </option>
					    </xsl:for-each>	
					</select>
			    </xsl:when>	
			    							    					    							    						    					    
			    <xsl:when test="field_type = 'DT'">
					<input class="fieldInputDateTime" id="{field_name}" name="{field_name}" type="text" value="{field_current_value}"/>
					<xsl:call-template name="calendar">
						<xsl:with-param name="field"><xsl:value-of select="field_name"/></xsl:with-param>
						<xsl:with-param name="label"><xsl:value-of select="field_label"/></xsl:with-param>
						<xsl:with-param name="time">true</xsl:with-param>
					</xsl:call-template>
			    </xsl:when>
			    
				<xsl:when test="field_type = 'ML'">
						<xsl:choose>
							<xsl:when test="(is_readonly = 'Y') and (is_mandatory = 'N')">
								<input id="{field_name}" name="{field_name}" type="hidden" value="{field_current_value}"/>
								<textarea class="fieldTextarea" id="textarea_{field_name}" readonly="true" style="height:{field_height*2}em">
									<xsl:value-of select="field_current_value"/>
								</textarea>
							</xsl:when>
					
							<xsl:otherwise>
								<textarea class="fieldInputTextarea formtextarea" id="{field_name}" name="{field_name}" style="height:{field_height*2}em">
									<xsl:value-of select="field_current_value"/>
								</textarea>	
							</xsl:otherwise>
						</xsl:choose>
				</xsl:when>	
			    
		 	    <xsl:when test="field_type = 'MV'">
					<xsl:variable name="current" select="field_current_value"/>
					<xsl:variable name="options" select="field_options"/>
					<select class="fieldInputSelectMultiple" id="{field_name}" name="{field_name}" multiple="multiple" size="1" style="display:none">
						<option value=""></option>
						<xsl:choose>
							<xsl:when test="$current/field_current_value_item">
								<xsl:for-each select = "$options/field_options_item" >					
									<xsl:variable name="id" select="option_id"/>
									<option value="{option_id}">
										<xsl:for-each select = "$current/field_current_value_item" >					
											<xsl:if test="$id = node()">
												<xsl:attribute name="selected" value="true"/>
											</xsl:if>												
										</xsl:for-each>																			
										<xsl:value-of select="php:functionString('lang',option_name)"/>
									</option>
								</xsl:for-each>																			
							</xsl:when>												
							<xsl:otherwise>
								<xsl:for-each select = "$options/field_options_item" >					
									<option value="{option_id}">
										<xsl:if test="option_id = $current">
											<xsl:attribute name="selected" value="true"/>
										</xsl:if>												
										<xsl:value-of select="php:functionString('lang',option_name)"/>
									</option>
								</xsl:for-each>																			
							</xsl:otherwise>												
						</xsl:choose>
					</select>
					<script type="text/javascript">
						jQuery('#<xsl:value-of select="field_name" />').show().multiSelect({
							selectAllText: '',
							noneSelected: '',
							oneOrMoreSelected: '*'
						});
					</script>	
				</xsl:when>	
   
			    <xsl:when test="field_type = 'PE' or field_type = 'PD'">
					<input class="fieldInputPercentage" id="{field_name}" name="{field_name}" type="text" value="{field_current_value}" />%
			    </xsl:when>		
			    		    
				<xsl:when test="field_type = 'RD' or field_type = 'RM'">
					<xsl:variable name="field_value_nbr" select="field_current_value_nbr"/>	
					<input id="{field_name}" name="{field_name}" type="hidden" value="{field_current_value}"/>
					<select id="i_{field_name}" name="i_{field_name}" onchange="$('{field_name}').value=checkReminder(this, $('s_{field_name}'), '{field_type}');">
						<option value=""/>
						<xsl:for-each select = "/APPSHORE/APP/reminder_nbrs/reminder_nbrs_item" >
							<option value="{nbr}">
								<xsl:if test="nbr = $field_value_nbr">
									<xsl:attribute name="selected" value="true"/>
								</xsl:if>												
			                    <xsl:value-of select="nbr"/>
			                </option>
						</xsl:for-each>	
					</select>&#160;
					<xsl:variable name="field_value_period" select="field_current_value_period"/>	
					<select id="s_{field_name}" name="s_{field_name}" onchange="$('{field_name}').value=checkReminder($('i_{field_name}'), this, '{field_type}');">
						<option value=""/>
						<xsl:for-each select = "/APPSHORE/APP/reminder_periods/reminder_periods_item" >
							<option value="{period_id}">
								<xsl:if test="period_id = $field_value_period">
									<xsl:attribute name="selected" value="true"/>
								</xsl:if>												
			                    <xsl:value-of select="php:functionString('lang',period_name)"/>
			                </option>
						</xsl:for-each>	
					</select>
				</xsl:when>	    	
			    
			    <xsl:when test="field_type = 'RR'">
					<xsl:variable name="related_field_name_value">related_<xsl:value-of select="field_name"/></xsl:variable>
					<xsl:variable name="relatedrecord"><xsl:value-of select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $related_field_name_value]"/></xsl:variable>				    
					<input name="{field_name}" id="{field_name}" type="hidden" value="{field_current_value}" />				
					<input name="{field_name}_{related_name}" id="{field_name}_{related_name}" class="fieldInputLookup" type="text" value="{$relatedrecord}" />				
<!--					<a href="javascript:top.window.retrieve=new getBackTuple(document.{$thisForm}.{field_name}_{related_name},document.{$thisForm}.{field_name});popupIntra('{$baseurl}&amp;op={related_app_name}.popup.search&amp;{related_id}='+document.{$thisForm}.{field_name}.value+'&amp;related_name=<xsl:value-of select="related_name"/>','{field_label}');">-->
<!--						<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Open a look up window')"/></xsl:attribute>-->
<!--						<img class="icon" src="{$api_image_path}/maglass_16.png"/>-->
<!--					</a>						-->
					<a>
						<xsl:attribute name="href">javascript:;</xsl:attribute>
						<xsl:attribute name="onclick">
							top.window.retrieve=new getBackTuple(document.<xsl:value-of select="$thisForm"/>.<xsl:value-of select="field_name"/>_<xsl:value-of select="related_name"/>,document.<xsl:value-of select="$thisForm"/>.<xsl:value-of select="field_name"/>);
							popupIntra('<xsl:value-of select="$baseurl"/>&amp;op=<xsl:value-of select="related_app_name"/>.popup.search&amp;<xsl:value-of select="related_id"/>='+document.<xsl:value-of select="$thisForm"/>.<xsl:value-of select="field_name"/>.value+'&amp;related_name=<xsl:value-of select="related_name"/>','<xsl:value-of select="php:functionString('lang',field_label)"/>');
						</xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="php:functionString('lang',field_label)"/></xsl:attribute>
						<img class="icon" src="{$api_image_path}/maglass_16.png"/>
					</a> 
			    </xsl:when>		
			    	
			    <xsl:otherwise>
					<input class="fieldInputText" id="{field_name}" name="{field_name}" type="text" value="{field_current_value}"/>
		   	   </xsl:otherwise>		   	   		    		    
			</xsl:choose>				
		</div>
	</div>
</xsl:template>

<xsl:template name="customBulkHeaderButtons">
	<xsl:param name="appName"/>		
	<xsl:param name="bulkForm"/>	
	<xsl:param name="selectedForm"/>
	<xsl:param name="delete"/>
	<xsl:param name="remove"/>
			
	<select class="fieldInputSelect" name="bulk_id" id="bulk_id">
		<xsl:for-each select = "bulk/bulk_item" >
			<option value="{bulk_id}">
				<xsl:if test="bulk_id = /APPSHORE/APP/recordset/bulk_id">
					<xsl:attribute name="selected" value="true"/>
				</xsl:if>
				<xsl:value-of select="php:functionString('lang',bulk_name)"/>
			</option>
		</xsl:for-each>
	</select>&#160;	
	<xsl:if test="$delete != 'false' and (/APPSHORE/APP/scope > 0)"> 
		<input type="button" class="formBarButton" name="Delete" onclick="return gridBulkKey(document.{$bulkForm},document.{$selectedForm},this.name,'{/APPSHORE/API/current_user/confirm_delete}');">
	        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Delete')"/></xsl:attribute>
	        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Delete selection')"/></xsl:attribute>	            
	    </input>&#160; 
	</xsl:if>
	<xsl:if test="$remove != 'false'">   					 		                
		<input type="button" class="formBarButton" name="Remove" onclick="return gridBulkKey(document.{$bulkForm},document.{$selectedForm},this.name,'{/APPSHORE/API/current_user/confirm_delete}');">
	        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Remove')"/></xsl:attribute>
	        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Remove selection')"/></xsl:attribute>	            
	    </input>&#160; 
	</xsl:if>
    <xsl:if test = "/APPSHORE/API/export">	
		<input type="button" class="formBarButton" name="Export" onclick="if(gridBulkKey(document.{$bulkForm},document.{$selectedForm},this.name)==false)return false;location.href='{$baseurl}&amp;op={$appName}.export.bulk&amp;bulk_id='+document.{$bulkForm}.bulk_id.value+'&amp;selected='+document.{$bulkForm}.selected.value; return false;">
	        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Export')"/></xsl:attribute>
	        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Export to a CSV file')"/></xsl:attribute>	            
	    </input>&#160;  
    </xsl:if>   
       
    <xsl:if test = "/APPSHORE/API/tag or /APPSHORE/API/list">
<!--    	<xsl:call-template name="listBulkFormJS">-->
<!--			<xsl:with-param name="bulkForm"><xsl:value-of select="$bulkForm"/></xsl:with-param>				-->
<!--			<xsl:with-param name="selectedForm"><xsl:value-of select="$selectedForm"/></xsl:with-param>				-->
<!--    	</xsl:call-template>-->

		<script language="JavaScript" type="text/javascript" src="{$lib_js_path}/lists.js?language={/APPSHORE/API/current_user/language_id}"/>		

		<script language='javascript' >
			var dropdownlist = new Lists(document.<xsl:value-of select="$bulkForm"/>,document.<xsl:value-of select="$selectedForm"/>);
		</script>	    
    </xsl:if>      
			
    <xsl:if test = "/APPSHORE/API/tag">
    	<xsl:call-template name="listBulkForm">
    		<xsl:with-param name="appName" select="$appName"/>
			<xsl:with-param name="targetAppName">tags</xsl:with-param>				
			<xsl:with-param name="targetAppLabel">Tag</xsl:with-param>				
			<xsl:with-param name="targetClassName">tags.ajax</xsl:with-param>				
			<xsl:with-param name="addSelectionLabel">Add a tag</xsl:with-param>				
			<xsl:with-param name="createSelectionLabel">Create a new tag</xsl:with-param>				
			<xsl:with-param name="useSelectionLabel">Use an existing tag</xsl:with-param>				
    	</xsl:call-template>&#160;
    </xsl:if>      
    <xsl:if test = "/APPSHORE/API/list">
    	<xsl:call-template name="listBulkForm">
    		<xsl:with-param name="appName" select="$appName"/>
			<xsl:with-param name="targetAppName">campaigns</xsl:with-param>				
			<xsl:with-param name="targetAppLabel">List</xsl:with-param>				
			<xsl:with-param name="targetClassName">campaigns.lists_ajax</xsl:with-param>				
			<xsl:with-param name="addSelectionLabel">Add to a campaign</xsl:with-param>				
			<xsl:with-param name="createSelectionLabel">Create a new list</xsl:with-param>				
			<xsl:with-param name="useSelectionLabel">Use an existing list</xsl:with-param>				
    	</xsl:call-template>
    </xsl:if>
</xsl:template>

<xsl:template name="customBulkFooterButtons">
	<xsl:param name="bulkForm"/>	
	<xsl:param name="selectedForm"/>
			
	<input type="submit" class="formBarButton" name="Save" onclick="return gridBulkKey(document.{$bulkForm},document.{$selectedForm},this.name);">
        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Update selection with new values')"/></xsl:attribute>	            
    </input>&#160;        
	<input type="button" class="formBarButton" name="Clear" onclick="gridBulkClear(document.{$bulkForm});">
        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Clear')"/></xsl:attribute>
        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Clear all fields')"/></xsl:attribute>	            
    </input>&#160;
	<span>
        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Caution, this option applies on all fields in bulk and on all selected records')"/></xsl:attribute>	            
	    <input id="is_blank" name="is_blank" type="hidden" value="N" />				
	    <input class="fieldInputCheckbox" id="checkbox_is_blank" name="checkbox_is_blank" type="checkbox" value="N" onclick="boxchecked(document.{$bulkForm}.checkbox_is_blank, document.{$bulkForm}.is_blank);"/>
	    <xsl:value-of select="php:function('lang','Apply on blank fields')"/>&#160;
	</span>
	<span>
        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Send a notification message to the (new) owner')"/></xsl:attribute>	            
        <input id="is_notify" name="is_notify" type="hidden" value="{/APPSHORE/API/current_user/notify_owner}" />				
        <input class="fieldInputCheckbox" id="checkbox_is_notify" name="checkbox_is_notify" type="checkbox" value="{/APPSHORE/API/current_user/notify_owner}" onclick="boxchecked(document.{$bulkForm}.checkbox_is_notify, document.{$bulkForm}.is_notify);">
        	<xsl:if test="/APPSHORE/API/current_user/notify_owner = 'Y'">
				<xsl:attribute name="checked"/>	
			</xsl:if>
		</input>

        <xsl:value-of select="php:function('lang','Notify owner')"/>
    </span>
</xsl:template>

<xsl:template name="listBulkForm">
	<xsl:param name="appName"/>
	<xsl:param name="targetAppName"/>
	<xsl:param name="targetAppLabel"/>
	<xsl:param name="targetClassName"/>
	<xsl:param name="addSelectionLabel"/>
	<xsl:param name="createSelectionLabel"/>
	<xsl:param name="useSelectionLabel"/>

	<select class="fieldInputSelect" name="{$targetAppName}_list_id" id="{$targetAppName}_list_id" onChange="return dropdownlist.listSelect(this, '{$appName}', '{$targetAppName}', '{$targetAppLabel}', '{$targetClassName}');">
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
        <xsl:attribute name="onLoad">dropdownlist.getLists($('<xsl:value-of select="$targetAppName"/>_list_id'),'<xsl:value-of select="$targetClassName"/>');</xsl:attribute>	            
	</img>			

</xsl:template>

</xsl:stylesheet>
