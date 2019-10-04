<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="custom_edit">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>	
	<xsl:param name="nodeName"/>	
	<xsl:param name="recordId"/>
	<xsl:param name="recordName"/>			
	<xsl:param name="assignedto" select="'true'"/>	
	<xsl:param name="duplicate"  select="'true'"/>	
	<xsl:param name="delete"  select="'true'"/>	

	<script type="text/javascript" src="{$lib_js_path}/form.js"/>		
	<script type="text/javascript">
		var fieldRequired = new Array();
		var fieldDescription = new Array();
		var	fieldInc = 0;
	</script>

	<xsl:variable name="recordIdValue" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $recordId]"/>		
	<xsl:variable name="recordNameValue" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $recordName]"/>		
		
    <div class="clearboth">
		<div class="formTitleTags start_float">
			<xsl:choose>
				<xsl:when test="string-length($recordIdValue) and string-length($recordNameValue)">
					<xsl:value-of select="php:functionString('lang',$appLabel)"/>:&#160;<xsl:value-of select="$recordNameValue"/>
				</xsl:when>
				<xsl:when test="string-length($recordIdValue) and not(string-length($recordNameValue))">
					<xsl:value-of select="php:functionString('lang',$appLabel)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="php:functionString('lang',$appLabel)"/>:&#160;<span style="color:black;font-weight:normal;font-style:italic"><xsl:value-of select="php:function('lang','New')"/></span>
				</xsl:otherwise>
			</xsl:choose>
		</div>
		<div class="end_float">
			<xsl:call-template name="displayTags">
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="recordIdValue" select="$recordIdValue"/>
			</xsl:call-template>
		</div>
	</div>	
		
	<form enctype="multipart/form-data" id="custom_edit" method="post" name="custom_edit" onsubmit="return formCheck(this, fieldRequired, fieldDescription);">
		<input type="hidden" name="op" id="op" value="{$appName}.base.edit"/>
		<input type="hidden" name="isreload" id="isreload" value="false"/>	
		<input type="hidden" name="key" id="key"/>	
		<input name="{$recordId}" id="{$recordId}" type="hidden" value="{$recordIdValue}"/>				
	
		<div class="clearboth formBar">
			<xsl:call-template name="editButtons">
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="thisForm" select="'custom_edit'"/>		
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="recordId" select="$recordId"/>
				<xsl:with-param name="recordIdValue" select="$recordIdValue"/>
				<xsl:with-param name="isTop" select="'true'"/>		
				<xsl:with-param name="assignedto" select="$assignedto"/>
				<xsl:with-param name="duplicate" select="$duplicate"/>		
				<xsl:with-param name="delete" select="string-length($recordIdValue) and $delete = 'true'"/>		
			</xsl:call-template>			
		</div>	
		
		<div class="clearboth">
			<xsl:call-template name="customEditBody">
				<xsl:with-param name="thisForm" select="'custom_edit'"/>
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="appLabel" select="$appLabel"/>
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="recordId" select="$recordId"/>
				<xsl:with-param name="recordName" select="$recordName"/>
			</xsl:call-template> 				
		</div>			

		<xsl:if test="/APPSHORE/API/Plugins/Plugins_item = 'EditLines'">
		    <xsl:apply-templates select="/APPSHORE/API/Plugins" mode="EditLines">
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="thisForm" select="'custom_edit'"/>		
		    </xsl:apply-templates>
		</xsl:if>

		<div class="clearboth formBar">
			<xsl:call-template name="editButtons">
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="thisForm" select="'custom_edit'"/>		
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="recordId" select="$recordId"/>
				<xsl:with-param name="recordIdValue" select="$recordIdValue"/>
				<xsl:with-param name="duplicate" select="$duplicate"/>		
				<xsl:with-param name="delete" select="string-length($recordIdValue) and $delete = 'true'"/>		
			</xsl:call-template>			
		</div>	
				
	</form>
	
	<div class="clearboth">
		<br/>
		<xsl:call-template name="customLinked">
			<xsl:with-param name="masterForm" select="'custom_edit'"/>
			<xsl:with-param name="masterTableName" select="$appName"/>
			<xsl:with-param name="masterRecordId" select="$recordId"/>
			<xsl:with-param name="masterRecordIdValue" select="$recordIdValue"/>
			<xsl:with-param name="masterRecordNameValue" select="$recordNameValue"/>
		</xsl:call-template>
	</div> 	

</xsl:template>


<xsl:template name="customEditBody">
	<xsl:param name="thisForm"/>
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>	
	<xsl:param name="nodeName"/>	
	<xsl:param name="recordId"/>	
	<xsl:param name="recordName"/>	
		
	<table class="formTable">
		<xsl:for-each select = "edit_blocks/edit_blocks_item" >
			<xsl:if test="is_title = 'Y' ">   					 		                                    
				<tr>
					<td class="formBlockTitle" colspan="2">
						<xsl:value-of select="php:functionString('lang',block_name)"/>
					</td>
				</tr>
			</xsl:if>  				            
			<tr class="formTr">
				<xsl:variable name="blockId" select="block_id"/>
				<xsl:choose>
				    <xsl:when test="columns = '1'">
						<td class="formTd" colspan="2">
							<xsl:for-each select = "/APPSHORE/APP/edit_fields/edit_fields_item[edit_block_id = $blockId and edit_side = 'L']" >
								<xsl:call-template name="editFields" >
									<xsl:with-param name="thisForm" select="$thisForm"/>
								    <xsl:with-param name="appName" select="$appName"/>
								    <xsl:with-param name="appLabel" select="$appLabel"/>
								    <xsl:with-param name="nodeName" select="$nodeName"/>
								    <xsl:with-param name="recordId" select="$recordId"/>
								    <xsl:with-param name="recordName" select="$recordName"/>
						    	</xsl:call-template>									
							</xsl:for-each>
						</td>						
				    </xsl:when>
				    <xsl:otherwise>
						<td class="formTdLeft">
							<xsl:for-each select = "/APPSHORE/APP/edit_fields/edit_fields_item[edit_block_id = $blockId and edit_side = 'L']" >
								<xsl:call-template name="editFields" >
									<xsl:with-param name="thisForm" select="$thisForm"/>
								    <xsl:with-param name="appName" select="$appName"/>
								    <xsl:with-param name="appLabel" select="$appLabel"/>
								    <xsl:with-param name="nodeName" select="$nodeName"/>
								    <xsl:with-param name="recordId" select="$recordId"/>
								    <xsl:with-param name="recordName" select="$recordName"/>
						    	</xsl:call-template>									
							</xsl:for-each>
						</td>
						<td class="formTdRight">
							<xsl:for-each select = "/APPSHORE/APP/edit_fields/edit_fields_item[edit_block_id = $blockId and edit_side = 'R']" >
								<xsl:call-template name="editFields" >
									<xsl:with-param name="thisForm" select="$thisForm"/>
								    <xsl:with-param name="appName" select="$appName"/>
								    <xsl:with-param name="appLabel" select="$appLabel"/>
								    <xsl:with-param name="nodeName" select="$nodeName"/>
								    <xsl:with-param name="recordId" select="$recordId"/>
								    <xsl:with-param name="recordName" select="$recordName"/>
						    	</xsl:call-template>									
							</xsl:for-each>
						</td>
					   </xsl:otherwise>
				</xsl:choose>
			</tr>
		</xsl:for-each>
	</table>	
</xsl:template>

<xsl:template name="setFieldLabel">
	<xsl:attribute name="class">
		fieldLabel
		<xsl:if test="(is_readonly = 'N') and (is_unique = 'Y')"> fieldLabelUnique</xsl:if>
		<xsl:if test="(is_readonly = 'N') and (is_mandatory = 'Y')"> fieldLabelMandatory</xsl:if>
	</xsl:attribute>
	<xsl:attribute name="title">
		<xsl:value-of select="php:functionString('lang',field_label)"/>
		<xsl:if test="(is_readonly = 'N') and (is_mandatory = 'Y')">&#160;-&#160;<xsl:value-of select="php:function('lang','This field is mandatory')"/></xsl:if>
		<xsl:if test="(is_readonly = 'N') and (is_unique = 'Y')">&#160;-&#160;<xsl:value-of select="php:function('lang','This value must be unique')"/></xsl:if>
	</xsl:attribute>
	<xsl:value-of select="php:functionString('lang',field_label)"/>
</xsl:template>

<xsl:template name="editFields">
	<xsl:param name="thisForm"/>
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>	
	<xsl:param name="nodeName"/>	
	<xsl:param name="recordId"/>	
	<xsl:param name="recordName"/>	

	<xsl:variable name="field_id_value" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $recordId]"/>	

	<xsl:if test="is_mandatory = 'Y'">
 		<script language="JavaScript" >
			fieldRequired[fieldInc] = '<xsl:value-of select="field_name"/><xsl:if test="field_type = 'RR'">_<xsl:value-of select="related_name"/></xsl:if>';
			fieldDescription[fieldInc++] = "<xsl:value-of select="php:functionString('lang',field_label)"/>";
		</script>
	</xsl:if>

	<!-- common Field label for all field types -->
	<xsl:choose>		
		<xsl:when test ="field_type = 'AT'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
				</span>
			</div>		
			<div class="clearboth fieldContainer">
				<div class="start_float" style="width:50%">
					<div class="fieldLabel">
						<xsl:value-of select="php:function('lang','Files')"/>
					</div>				
					<input id="my_file_element" name="files[0]" class="formBarButton" type="file"/>
					<div id="filesList" name="filesList">
						<xsl:for-each select = "/APPSHORE/APP/files/files_item">
							<div id="file-{filename}">
								<input name="file_ids" id="file_ids" type="checkbox" checked="true" value="{attachment_id}" onclick="this.parentNode.remove();"/>&#160;<xsl:value-of select="filename"/>
							</div>
						</xsl:for-each>									
					</div>
					<script language="JavaScript" type="text/javascript">
						var multi_selector = new MultiSelector($('filesList'),10);
						multi_selector.addElement($('my_file_element'));
					</script>
				</div>
				<div class="end_float" style="width:50%">
					<div class="fieldLabel">
						<xsl:value-of select="php:function('lang','Documents')"/>
					</div>				
					<xsl:variable name="title"><xsl:value-of select="php:function('lang','Documents')"/></xsl:variable>				
					<input type="button" class="formBarButton" id="documentsAdd" name="documentsAdd" onclick="top.window.thisDocument=document;popupIntra('{$baseurl}&amp;op=documents.popup.search&amp;is_attachment=true&amp;is_multiple=true','{$title}');" >
				        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Add')"/></xsl:attribute>
				        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Add Documents')"/></xsl:attribute>                    
				    </input>				    		
					<div id="documentsList" name="documentsList">
						<xsl:for-each select = "/APPSHORE/APP/documents/documents_item">
							<div id="doc-{document_id}">
								<input name="document_ids" id="document_ids" type="checkbox" checked="true" value="{document_id}" onclick="this.parentNode.remove();"/>&#160;<xsl:value-of select="document_name"/>
							</div>
						</xsl:for-each>						
					</div>						    
				</div>
			</div>	
		</xsl:when>

		<xsl:when test="field_type = 'CH'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<input id="{field_name}" name="{field_name}" type="hidden" value="{field_current_value}"/>				
				<input class="fieldInputCheckbox" id="checkbox_{field_name}" name="checkbox_{field_name}" onclick="boxchecked(document.{$thisForm}.checkbox_{field_name}, document.{$thisForm}.{field_name});" type="checkbox" value="{field_current_value}" >
					<xsl:if test="(is_readonly = 'Y') and (is_mandatory = 'N')">
						<xsl:attribute name="disabled" value="true"/>
					</xsl:if>
					<xsl:if test="field_current_value = 'Y' or field_current_value = '1'">
						<xsl:attribute name="checked"/>
					</xsl:if>
				</input>
			</div>
    	</xsl:when>	
    			    			    	    		    
		<xsl:when test="field_type = 'CU'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<xsl:choose>
					<xsl:when test="(is_readonly = 'Y') and (is_mandatory = 'N')">
						<input class="fieldInputCurrency" id="{field_name}" name="{field_name}" type="hidden" value="{field_current_value}"/>
						<xsl:value-of select="/APPSHORE/API/current_user/currency_id" />&#160;<xsl:value-of select="format-number(field_current_value, '###,###,###')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="/APPSHORE/API/current_user/currency_id"/>&#160;<input class="fieldInputCurrency" id="{field_name}" name="{field_name}" type="text" value="{field_current_value}"/>
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</xsl:when>	
    			    			    	    		    
		<xsl:when test="field_type = 'CD'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<xsl:choose>
					<xsl:when test="(is_readonly = 'Y') and (is_mandatory = 'N')">
						<input class="fieldInputCurrency" id="{field_name}" name="{field_name}" type="hidden" value="{field_current_value}"/>
						<xsl:value-of select="/APPSHORE/API/current_user/currency_id" />&#160;<xsl:value-of select="format-number(field_current_value, '###,###,###.00')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="/APPSHORE/API/current_user/currency_id"/>&#160;<input class="fieldInputCurrency" id="{field_name}" name="{field_name}" type="text" value="{field_current_value}"/>
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</xsl:when>	
    				    
		<xsl:when test="field_type = 'DA'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<xsl:choose>
					<xsl:when test="(is_readonly = 'Y') and (is_mandatory = 'N')">
						<input id="{field_name}" name="{field_name}" type="hidden" value="{field_current_value}"/>
						<xsl:value-of select="field_current_value"/>&#160;
					</xsl:when>
					<xsl:otherwise>
						<input class="fieldInputDate" id="{field_name}" name="{field_name}" type="text" value="{field_current_value}"/>
						<xsl:call-template name="calendar">
							<xsl:with-param name="field" select="field_name"/>
							<xsl:with-param name="label" select="field_label"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</xsl:when>	
    
		<xsl:when test="field_type = 'DD'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">		
				<xsl:variable name="field_value" select="field_current_value"/>	
				<xsl:choose>
					<xsl:when test="(is_readonly = 'Y') and (is_mandatory = 'N')">
						<input name="{field_name}" id="{field_name}" type="hidden" value="{field_current_value}"/>
						<xsl:value-of select="field_options/field_options_item[option_id = $field_value]/option_name"/>&#160;
					</xsl:when>
					<xsl:otherwise>
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
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</xsl:when>	
    
		<xsl:when test="field_type = 'DF'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<xsl:variable name="field_value" select="field_current_value"/>	
				<select class="fieldInputSelect" id="folder_id" name="folder_id">
					<xsl:for-each select = "/APPSHORE/APP/folders/folders_item" >
						<option value="{document_id}">
							<xsl:if test="document_id = $field_value">
								<xsl:attribute name="selected" value="true"/>
							</xsl:if>												
		                    <xsl:call-template name="folderLoop">
		                        <xsl:with-param name="i" select="'1'"/>
		                        <xsl:with-param name="count" select="level"/>
		                    </xsl:call-template>
		                    <xsl:value-of select="document_name"/>
		                </option>
					</xsl:for-each>	
				</select>
			</div>
		</xsl:when>	
    							    					    							    						    					    
		<xsl:when test="field_type = 'DO'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<xsl:choose>
					<xsl:when test="string-length(field_current_value) = 0">
		             	<input class="fieldInputFile" id="userfile" name="userfile" onchange="$('{field_name}').value=extractFilename(this.value);" type="file"/>
		            	&#160;<xsl:value-of select="php:function('lang','Max size')"/>&#160;10MB
				    	<input id="{field_name}" name="{field_name}" type="hidden" value="{field_current_value}"/>
					</xsl:when>
					<xsl:otherwise>
						<input class="fieldInputText" id="{field_name}" name="{field_name}" type="text" value="{field_current_value}"/>
					</xsl:otherwise>
				</xsl:choose>
			</div>
    	</xsl:when>			
    					    					    							    						    					    
    	<xsl:when test="field_type = 'DS'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<xsl:value-of select="field_current_value"/>
			</div>
    	</xsl:when>	
    
    	<xsl:when test="field_type = 'DT'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<xsl:choose>
					<xsl:when test="(is_readonly = 'Y') and (is_mandatory = 'N')">
						<input id="{field_name}" name="{field_name}" type="hidden" value="{field_current_value}"/>
						<xsl:value-of select="field_current_value"/>&#160;
					</xsl:when>
					<xsl:otherwise>
						<input class="fieldInputDateTime" id="{field_name}" name="{field_name}" type="text" value="{field_current_value}"/>
						<xsl:call-template name="calendar">
							<xsl:with-param name="field" select="field_name"/>
							<xsl:with-param name="label" select="field_label"/>
							<xsl:with-param name="time" select="'true'"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</div>
    	</xsl:when>	
    
    	<xsl:when test="field_type = 'DY'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<xsl:value-of select="field_current_value"/>
			</div>
    	</xsl:when>	
    
    	<xsl:when test="field_type = 'EA'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<script type="text/javascript" src="includes/tiny_mce/tiny_mce.js"/>
				<script type="text/javascript" src="lib/js/tinymce_adv.js"/>
				<div class="fieldInputEditor">
					<textarea class="mceEditor" id="{field_name}" name="{field_name}" style="height:{field_height*2}em;width:100%;">
						<xsl:value-of select="field_current_value"/>
					</textarea>
				</div>
			</div>
    	</xsl:when>		
    
    	<xsl:when test="field_type = 'EH'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<script type="text/javascript" src="includes/tiny_mce/tiny_mce.js"/>
				<script type="text/javascript" src="lib/js/tinymce.js"/>
				<div class="fieldInputEditor">
					<textarea class="mceEditor" id="{field_name}" name="{field_name}" style="height:{field_height*2}em;width:100%;">
						<xsl:value-of select="field_current_value"/>
					</textarea>
				</div>
			</div>
    	</xsl:when>		

		<xsl:when test ="field_type = 'EM'">			
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
				<span class="end_float">
					<a class="fieldAssociatedLink" onclick="if($('{field_name}').getHeight()&#60;210)$('{field_name}').style.height = ($('{field_name}').getHeight()+30)+'px';">
						<xsl:attribute name="title"><xsl:value-of select="php:function('lang','More lines')"/></xsl:attribute>
						<img border="0" src="{$api_image_path}/plus_16.png"/>
		   			</a>&#160;
					<a class="fieldAssociatedLink" onclick="if(($('{field_name}').getHeight()-30)&#62;30)$('{field_name}').style.height = ($('{field_name}').getHeight()-30)+'px';else $('{field_name}').style.height='30px'">
						<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Less lines')"/></xsl:attribute>
						<img border="0" src="{$api_image_path}/minus_16.png"/>
		   			</a>
				</span>
			</div>
			<div id="container_{field_name}" class="clearboth fieldContainer">
				<xsl:choose>
					<xsl:when test="(is_readonly = 'Y') and (is_mandatory = 'N')">
						<input id="{field_name}" name="{field_name}" type="hidden" value="{field_current_value}"/>
						<xsl:value-of select="field_current_value"/>&#160;
					</xsl:when>
					<xsl:otherwise>
						<textarea class="fieldInputTextareaEmail formtextarea" autocomplete="off" id="{field_name}" name="{field_name}" style="height:30px;">
					   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Double click to display up to 10 items')"/></xsl:attribute>
							<xsl:value-of select="field_current_value"/>
						</textarea>
						<div class="auto_complete" id="{field_name}_auto_complete"></div>	
						<script type="text/javascript">
							params = {
								parameters: 'sid='+sid+'&amp;op=webmail.ajax.getEmailAddresses',
								tokens: [',',';',' ','\n'], 
								paramName: 'recipient', 
								minChars: 0
								};
							new Ajax.Autocompleter('<xsl:value-of select="field_name"/>','<xsl:value-of select="field_name"/>_auto_complete','raw.php', params);
						</script>																										
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</xsl:when>

		<xsl:when test="field_type = 'ET'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
				<span class="end_float">
					<a class="fieldAssociatedLink" onclick="document.{$thisForm}.{field_name}.value = stripHTML(tinyMCE.activeEditor.getContent());">
						<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Copy from HTML')"/></xsl:attribute>
						<xsl:value-of select="php:function('lang','Copy from HTML')"/>
					</a>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<textarea class="fieldInputTextarea formtextarea" id="{field_name}" name="{field_name}" nowrap="true" style="height:{field_height*2}em">
					<xsl:value-of select="field_current_value"/>
				</textarea>
			</div>	    	
		</xsl:when>	
		
		<xsl:when test="field_type = 'IM'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer" >
				<div class="start_float">
					<xsl:choose>
						<xsl:when test="string-length(field_current_value)">
							<img class="image fieldAssociatedLink" id="{field_name}_img" src="{$basepath}/lib/image.php?image_id={field_current_value}_96" style="height:{field_height}em" onclick="popupInter('{$basepath}/lib/image.php?image_id={field_current_value}','{field_label}');">
						   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Full size')"/></xsl:attribute>                    
							</img>
						</xsl:when>
						<xsl:otherwise>
							<img class="image" id="{field_name}_img" src="{$api_image_path}/people.png"/>
						</xsl:otherwise>
					</xsl:choose>	
					&#160;
				</div>
				<div class="start_float">
		         	<input class="fieldInputFile" id="{field_name}_file" name="{field_name}_file" size="15" onchange="$('{field_name}').value='{$appName}_{$field_id_value}_{field_name}';" type="file"/>
					<input id="{field_name}" name="{field_name}" type="hidden" value="{field_current_value}"/>
			     	<br/>
					<a class="fieldAssociatedLink" onclick="$('{field_name}').value='';$('{field_name}_img').src='{$api_image_path}/people.png';$('{field_name}_img').style.width=$('{field_name}_img').style.height='96px'">
						<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Remove image')"/></xsl:attribute>
						<xsl:value-of select="php:function('lang','Remove image')"/>
		   			</a>
		    	</div>
			</div>
		</xsl:when>			
		
		<xsl:when test="field_type = 'ML'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
				<span class="end_float">
			
					<xsl:choose>							
						<xsl:when test ="field_name = 'address_billing'">							
							<xsl:if test="/APPSHORE/APP/edit_fields/edit_fields_item[field_name = 'address_shipping']/edit_sequence">
								<a class="fieldAssociatedLink" >
						            <xsl:attribute name="onclick">
						                $('address_billing').value = $('address_shipping').value;
						                $('city_billing').value = $('city_shipping').value;
						                $('zipcode_billing').value = $('zipcode_shipping').value;
						                $('state_billing').value = $('state_shipping').value;
						                $('country_billing').value = $('country_shipping').value;
						            </xsl:attribute>
									<xsl:value-of select="php:function('lang','Copy from shipping address')"/>
						        </a>
							</xsl:if>						        				
						</xsl:when>
				
						<xsl:when test ="field_name = 'address_shipping'">	
							<xsl:if test="/APPSHORE/APP/edit_fields/edit_fields_item[field_name = 'address_billing']/edit_sequence">
								<a class="fieldAssociatedLink">
						            <xsl:attribute name="onclick">
							            $('address_shipping').value = $('address_billing').value;
							            $('city_shipping').value = $('city_billing').value;
							            $('zipcode_shipping').value = $('zipcode_billing').value;
							            $('state_shipping').value = $('state_billing').value;
							            $('country_shipping').value = $('country_billing').value;
						            </xsl:attribute>
									<xsl:value-of select="php:function('lang','Copy from billing address')"/>
						        </a> 				
							</xsl:if>						        				
						</xsl:when>
				
						<xsl:when test ="field_name = 'address_1'">	
							<xsl:if test="/APPSHORE/APP/edit_fields/edit_fields_item[field_name = 'address_2']/edit_sequence">
								<a class="fieldAssociatedLink">
						            <xsl:attribute name="onclick">
							            $('address_1').value = $('address_2').value;
							            $('city_1').value = $('city_2').value;
							            $('zipcode_1').value = $('zipcode_2').value;
							            $('state_1').value = $('state_2').value;
							            $('country_1').value = $('country_2').value;
						            </xsl:attribute>
									<xsl:value-of select="php:function('lang','Copy from secondary address')"/>
						        </a> 				
							</xsl:if>						        				
						</xsl:when>
				
						<xsl:when test ="field_name = 'address_2'">	
							<xsl:if test="/APPSHORE/APP/edit_fields/edit_fields_item[field_name = 'address_1']/edit_sequence">
								<a class="fieldAssociatedLink">
						            <xsl:attribute name="onclick">
							            $('address_2').value = $('address_1').value;
							            $('city_2').value = $('city_1').value;
							            $('zipcode_2').value = $('zipcode_1').value;
							            $('state_2').value = $('state_1').value;
							            $('country_2').value = $('country_1').value;
						            </xsl:attribute>
									<xsl:value-of select="php:function('lang','Copy from primary address')"/>
						        </a> 				
							</xsl:if>						        				
						</xsl:when>		
						
						<xsl:otherwise>
							<a class="fieldAssociatedLink" onclick="insertTimeStamp( document.{$thisForm}.{field_name},'{/APPSHORE/API/current_user/full_name}', true);">
								<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Insert a time stamp in the field')"/></xsl:attribute>
								<img border="0" src="{$api_image_path}/clock_16.png"/>
				   			</a>&#160;
							<a class="fieldAssociatedLink" onclick="if($('{field_name}').getHeight()&#60;1000)$('{field_name}').style.height = ($('{field_name}').getHeight()+200)+'px';">
								<xsl:attribute name="title"><xsl:value-of select="php:function('lang','More lines')"/></xsl:attribute>
								<img border="0" src="{$api_image_path}/plus_16.png"/>
				   			</a>&#160;
							<a class="fieldAssociatedLink" onclick="if($('{field_name}').getHeight()&#62;250)$('{field_name}').style.height = ($('{field_name}').getHeight()-200)+'px';">
								<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Less lines')"/></xsl:attribute>
								<img border="0" src="{$api_image_path}/minus_16.png"/>
				   			</a>
						</xsl:otherwise>										
				
					</xsl:choose>
			
				</span>
			</div>
			<div class="clearboth fieldContainer">
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
			</div>
    	</xsl:when>	

	    <xsl:when test="field_type = 'MV'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
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
			</div>
	    </xsl:when>	
    
    	<xsl:when test="field_type = 'NU'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<xsl:choose>
					<xsl:when test="(is_readonly = 'Y') and (is_mandatory = 'N')">
						<input name="{field_name}" id="{field_name}" type="hidden" value="{field_current_value}"/>
						<xsl:value-of select="format-number(field_current_value, '###,###,###')"/>
					</xsl:when>
					<xsl:otherwise>
						<input name="{field_name}" id="{field_name}" class="fieldInputNumeric" type="text" value="{field_current_value}"/>
					</xsl:otherwise>
				</xsl:choose>
			</div>
    	</xsl:when>	
    
    	<xsl:when test="field_type = 'ND'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<xsl:choose>
					<xsl:when test="(is_readonly = 'Y') and (is_mandatory = 'N')">
						<input name="{field_name}" id="{field_name}" type="hidden" value="{field_current_value}"/>
						<xsl:value-of select="format-number(field_current_value, '###,###,###.00')"/>
					</xsl:when>
					<xsl:otherwise>
						<input name="{field_name}" id="{field_name}" class="fieldInputNumeric" type="text" value="{field_current_value}"/>
					</xsl:otherwise>
				</xsl:choose>
			</div>
    	</xsl:when>	
   
    	<xsl:when test="field_type = 'PE'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<xsl:choose>
					<xsl:when test="(is_readonly = 'Y') and (is_mandatory = 'N')">
						<input name="{field_name}" id="{field_name}" type="hidden" value="{field_current_value}"/>
						<xsl:value-of select="format-number(field_current_value, '#')"/>%
					</xsl:when>
					<xsl:otherwise>
						<input name="{field_name}" id="{field_name}" class="fieldInputPercentage" type="text" value="{field_current_value}"/>%
					</xsl:otherwise>
				</xsl:choose>
			</div>
    	</xsl:when>	
 
    	<xsl:when test="field_type = 'PD'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<xsl:choose>
					<xsl:when test="(is_readonly = 'Y') and (is_mandatory = 'N')">
						<input name="{field_name}" id="{field_name}" type="hidden" value="{field_current_value}"/>
						<xsl:value-of select="format-number(field_current_value, '#.00')"/>%
					</xsl:when>
					<xsl:otherwise>
						<input name="{field_name}" id="{field_name}" class="fieldInputPercentage" type="text" value="{field_current_value}"/>%
					</xsl:otherwise>
				</xsl:choose>
			</div>
    	</xsl:when>	
    	    	
		<xsl:when test="field_type = 'PW'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">				
				<input id="{field_name}" name="{field_name}" type="hidden" value=""/>				
				<input class="fieldInputPassword" id="pwd1_{field_name}" name="pwd1_{field_name}" type="password" value="" >
					<xsl:if test="(is_readonly = 'Y') and (is_mandatory = 'N')">
						<xsl:attribute name="disabled" value="true"/>
					</xsl:if>
					<xsl:if test="field_current_value = 'Y' or field_current_value = '1'">
						<xsl:attribute name="checked"/>
					</xsl:if>
				</input>&#160;			
				<input class="fieldInputPassword" id="pwd2_{field_name}" name="pwd2_{field_name}" onchange="$('{field_name}').value = checkPassword($('pwd1_{field_name}').value,$('pwd2_{field_name}').value);" type="password" value="" >
					<xsl:if test="(is_readonly = 'Y') and (is_mandatory = 'N')">
						<xsl:attribute name="disabled" value="true"/>
					</xsl:if>
					<xsl:if test="field_current_value = 'Y' or field_current_value = '1'">
						<xsl:attribute name="checked"/>
					</xsl:if>
				</input>
			</div>
    	</xsl:when>

		<xsl:when test="field_type = 'RD' or field_type = 'RM'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
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
			</div>
		</xsl:when>	    	

    	<xsl:when test="field_type = 'RR'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<xsl:variable name="related_field_name_value">related_<xsl:value-of select="field_name"/></xsl:variable>
				<xsl:variable name="relatedrecord" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $related_field_name_value]"/>				    
				<input name="{field_name}" id="{field_name}" type="hidden" value="{field_current_value}"/>				
				<xsl:choose>
					<xsl:when test="(is_readonly = 'Y') and (is_mandatory = 'N')">
			   	        <a target="_top" href="{$baseurl}&amp;op={related_app_name}.base.view&amp;{related_id}={field_current_value}" onMouseOver="popupDetails('{$baseurl}&amp;op={related_app_name}.popup.view&amp;{related_id}={field_current_value}','Details','{$api_image_path}','');" onMouseOut="return nd();"  >
							<xsl:value-of select="$relatedrecord"/>&#160;
						</a>
					</xsl:when>
					<xsl:otherwise>
						<a>
							<xsl:attribute name="href">javascript:;</xsl:attribute>
							<xsl:attribute name="onclick">
								top.window.retrieve=new getBackTuple(document.<xsl:value-of select="$thisForm"/>.<xsl:value-of select="field_name"/>_<xsl:value-of select="related_name"/>,document.<xsl:value-of select="$thisForm"/>.<xsl:value-of select="field_name"/>);
								popupIntra('<xsl:value-of select="$baseurl"/>&amp;op=<xsl:value-of select="related_app_name"/>.popup.search&amp;<xsl:value-of select="related_id"/>='+document.<xsl:value-of select="$thisForm"/>.<xsl:value-of select="field_name"/>.value+'&amp;related_name=<xsl:value-of select="related_name"/>','<xsl:value-of select="php:functionString('lang',field_label)"/>');
							</xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="php:functionString('lang',field_label)"/></xsl:attribute>
							<input name="{field_name}_{related_name}" id="{field_name}_{related_name}" class="fieldInputLookup" type="text" value="{$relatedrecord}"/>				
							<img border="0" src="{$api_image_path}/maglass_16.png"/>
						</a>
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</xsl:when>		
    	
    	<xsl:when test="field_type = 'TI'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<input class="fieldInputTime" name="{field_name}" id="{field_name}" type="text" value="{field_current_value}"/>&#160;<xsl:value-of select="php:function('lang','hh:mm')"/>
			</div>
    	</xsl:when>	

    	<xsl:when test="field_type = 'TS'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<xsl:value-of select="field_current_value"/>				
				<xsl:variable name="related_field_name">related_<xsl:value-of select="field_name"/>_by</xsl:variable>
				<xsl:variable name="related_field_name_value" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $related_field_name]"/>
				<xsl:if test = "string-length($related_field_name_value)">
					&#160;<xsl:value-of select="php:function('lang','by')"/>&#160;<xsl:value-of select="$related_field_name_value"/>
				</xsl:if>
			</div>
    	</xsl:when>	
    			    			
    	<xsl:when test="field_type = 'WS'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<input class="fieldInputUrl" id="{field_name}" name="{field_name}" type="text" value="{field_current_value}"/>	
				<a href="javascript:;" onclick="popupInter('{field_current_value}','{field_current_value}');">
					<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Open a popup window')"/></xsl:attribute>
					<xsl:value-of select="field_current_value"/>
				</a>
				<a href="{field_current_value}" target="_new">
					<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Open a new window')"/></xsl:attribute>
					<img class="image" src="{$api_image_path}/openwindow_16.png"/>
				</a>
			</div>
    	</xsl:when>	
 
	    <xsl:when test="field_type = 'WM'">
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<xsl:choose>
					<xsl:when test="(is_readonly = 'Y') and (is_mandatory = 'N')">
						<input id="{field_name}" name="{field_name}" type="hidden" value="{field_current_value}"/>
						<xsl:value-of select="field_current_value"/>&#160;
					</xsl:when>
					<xsl:otherwise>
						<input class="fieldInputMailto" id="{field_name}" name="{field_name}" type="text" value="{field_current_value}"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:call-template name="mailto">
					<xsl:with-param name="email" select="field_current_value"/>
					<xsl:with-param name="name">
						<xsl:choose>
							<xsl:when test = "/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = 'full_name']"> 
								<xsl:value-of select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = 'full_name']"/>
							</xsl:when>
							<xsl:otherwise> 
								<xsl:value-of select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = 'account_name']"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="src"><xsl:value-of select="$api_image_path"/>/webmail_16.png</xsl:with-param>
					<xsl:with-param name="appName" select="$appName"/>
					<xsl:with-param name="recordIdValue" select="$field_id_value"/>
				</xsl:call-template>
			</div>
    	</xsl:when>	
			   
    	<xsl:otherwise>
			<div class="clearboth fieldLabelContainer">
				<span class="start_float">
					<xsl:call-template name="setFieldLabel"/>
				</span>
			</div>
			<div class="clearboth fieldContainer">
				<xsl:choose>
					<xsl:when test="(is_readonly = 'Y') and (is_mandatory = 'N')">
						<input id="{field_name}" name="{field_name}" type="hidden" value="{field_current_value}"/>
						<xsl:value-of select="field_current_value"/>&#160;
					</xsl:when>
					<xsl:otherwise>
						<input class="fieldInputText" id="{field_name}" name="{field_name}" type="text" value="{field_current_value}"/>
					</xsl:otherwise>
				</xsl:choose>
			</div>	
		</xsl:otherwise>

	</xsl:choose>

</xsl:template>


<xsl:template name="editButtons">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	
	<xsl:param name="nodeName"/>	
	<xsl:param name="recordId"/>
	<xsl:param name="recordIdValue"/>
	<xsl:param name="recordName"/>			
	<xsl:param name="isTop"/>	
	<xsl:param name="assignedto"/>	
	<xsl:param name="duplicate"/>	
	<xsl:param name="delete"/>	
	
	<xsl:variable name="recordNameValue" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $recordName]"/>		
	
    <table cellSpacing="1" cellPadding="1" width="100%" border="0">
		<tr>
			<td class="start_direction">
				<input type="submit" class="formBarButton" name="Save" onclick="document.{$thisForm}.key.value=this.name">
		            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
		        </input>&#160;       
				<xsl:if test="string-length($recordIdValue) and $duplicate = 'true'">                    
					<input type="button" class="formBarButton" name="Duplicate" onclick="window.location='{$baseurl}&amp;op={$appName}.base.edit&amp;key=Duplicate&amp;{$recordId}={$recordIdValue}';">
			            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Duplicate')"/></xsl:attribute>
	                </input>&#160;
				</xsl:if>		         	
				<xsl:if test="string-length($recordIdValue) and $delete = 'true'">   					 		                
					<input type="button" class="formBarButton" name="Delete" onclick="document.{$thisForm}.key.value=this.name;confirmAction(document.{$thisForm},'{/APPSHORE/API/current_user/confirm_delete}');">
			            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Delete')"/></xsl:attribute>
	                </input>&#160;
				</xsl:if>
				<xsl:if test="/APPSHORE/API/Plugins">
		            <xsl:apply-templates select="/APPSHORE/API/Plugins" mode="EditButtons">
	 					<xsl:with-param name="appName" select="$appName"/>
						<xsl:with-param name="thisForm" select="$thisForm"/>		
		            </xsl:apply-templates>
		        </xsl:if>
                <xsl:choose>
                	<xsl:when test="string-length($recordIdValue) = 0">
						<input type="button" class="formBarButton" name="Cancel" onclick="window.location='{$baseurl}&amp;op={$appName}.base.search';">
				            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Cancel and search results')"/></xsl:attribute>
				            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
				        </input>
                	</xsl:when>
                	<xsl:otherwise>
						<input type="button" class="formBarButton" name="Cancel" onclick="window.location='{$baseurl}&amp;op={$appName}.base.view&amp;{$recordId}={$recordIdValue}';">
				            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Cancel and view record')"/></xsl:attribute>
				            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
				        </input>
                	</xsl:otherwise>
                </xsl:choose>
<!--				<input type="button" class="formBarButton" name="Cancel" onclick="if( document.{$thisForm}.{$recordId}.value=='')window.location='{$baseurl}&amp;op={$appName}.base.search';else window.location='{$baseurl}&amp;op={$appName}.base.view&amp;{$recordId}='+document.{$thisForm}.{$recordId}.value;">-->
<!--		            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>-->
<!--		        </input>-->
			</td> 
			<td class="end_direction">					
				<xsl:if test = "($assignedto = 'true') and ($isTop = 'true')">
	            	<xsl:value-of select="php:function('lang','Assigned to')"/>&#160;
	        		<select class="fieldInputSelect" name="user_id" >
			            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Owner')"/></xsl:attribute>
	        			<xsl:for-each select = "users/users_item" >
       						<option value="{user_id}">
	        					<xsl:if test="user_id = /APPSHORE/APP/node()[name() = $nodeName]/user_id">
        							<xsl:attribute name="selected" value="true"/>
	        					</xsl:if>
     							<xsl:value-of select="full_name"/> - <xsl:value-of select="user_name"/>
    						</option>
	        			</xsl:for-each>
	        		</select>
				    <xsl:if test = "string-length($recordIdValue) and /APPSHORE/API/assignAll">
		        		<span>
				            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Assign all related records')"/></xsl:attribute>
							&#160;<input class="fieldInputCheckbox" id="assign_all" name="assign_all" type="checkbox" value="N">
					            <xsl:attribute name="onclick">checkAssignAll($('assign_all'));</xsl:attribute>
							</input><xsl:value-of select="php:function('lang','Assign related')"/>
						</span>
					</xsl:if>
               		<span>
                        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Send a notification message to the (new) owner')"/></xsl:attribute>	            
			            &#160;<input id="is_notify" name="is_notify" type="hidden" value="{/APPSHORE/API/current_user/notify_owner}" />				
                        <input class="fieldInputCheckbox" id="checkbox_is_notify" name="checkbox_is_notify" type="checkbox" value="{/APPSHORE/API/current_user/notify_owner}" onclick="boxchecked(document.{$thisForm}.checkbox_is_notify, document.{$thisForm}.is_notify);" >
				        	<xsl:if test="/APPSHORE/API/current_user/notify_owner = 'Y'">
								<xsl:attribute name="checked"/>	
							</xsl:if>
                        </input><xsl:value-of select="php:function('lang','Notify owner')"/>	
					</span>&#160;
	        	</xsl:if>
	        	<xsl:if test="string-length($recordIdValue)">
					<xsl:call-template name="buttonsNavigation">
						<xsl:with-param name="thisForm" select="$thisForm"/>
					</xsl:call-template>
				</xsl:if>
			</td>
		</tr>
	</table>				        

</xsl:template>


<xsl:template name="custom_popup_edit">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>	
	<xsl:param name="nodeName"/>	
	<xsl:param name="recordId"/>
	<xsl:param name="recordName"/>			
	<xsl:param name="delete"  select="'true'"/>	

	<script language="JavaScript" type="text/javascript" src="{$lib_js_path}/form.js"/>		
	<script type="text/javascript">
		var fieldRequired = new Array();
		var fieldDescription = new Array();
		var	fieldInc = 0;
	</script>
	
	<xsl:variable name="recordIdValue" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $recordId]"/>		
		
	<form enctype="multipart/form-data" id="custom_popup_edit" method="post" name="custom_popup_edit" onsubmit="return formCheck(this, fieldRequired, fieldDescription);">
		<input type="hidden" name="op" id="op" value="{$appName}.popup.edit"/>
		<input type="hidden" name="key" id="key"/>	
		<input name="{$recordId}" id="{$recordId}" type="hidden" value="{$recordIdValue}"/>				

		<div class="clearboth formBar">
			<xsl:call-template name="customPopupEditButtons">
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="thisForm" select="'custom_popup_edit'"/>		
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="isTop" select="'true'"/>		
				<xsl:with-param name="delete" select="string-length($recordIdValue) and $delete = 'true'"/>		
			</xsl:call-template>			
		</div>	

		<div class="clearboth">
			<xsl:call-template name="customPopupEditBody">
				<xsl:with-param name="thisForm" select="'custom_popup_edit'"/>
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="appLabel" select="$appLabel"/>
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="recordId" select="$recordId"/>
				<xsl:with-param name="recordName" select="$recordName"/>
			</xsl:call-template> 				
		</div>			

		<xsl:if test="/APPSHORE/API/Plugins">
		    <xsl:apply-templates select="/APPSHORE/API/Plugins" mode="EditLines">
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="thisForm" select="'custom_popup_edit'"/>		
		    </xsl:apply-templates>
		</xsl:if>
		       
		<div class="clearboth formBar">
			<xsl:call-template name="customPopupEditButtons">
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="thisForm" select="'custom_popup_edit'"/>		
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="delete" select="string-length($recordIdValue) and $delete = 'true'"/>		
			</xsl:call-template>
		</div>	
				
	</form>

</xsl:template>


<xsl:template name="customPopupEditBody">
	<xsl:param name="thisForm"/>
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>	
	<xsl:param name="nodeName"/>	
	<xsl:param name="recordId"/>	
	<xsl:param name="recordName"/>	
		
	<table class="formTable">
		<xsl:for-each select = "popup_edit_blocks/popup_edit_blocks_item" >
			<xsl:if test="is_title = 'Y' ">   					 		                                    
				<tr>
					<td class="formBlockTitle" scolspan="2">
						<xsl:value-of select="block_name"/>
					</td>
				</tr>
			</xsl:if>  				            
			<tr class="formTr">
				<xsl:variable name="blockId" select="block_id"/>
				<xsl:choose>
				    <xsl:when test="columns = '1'">
						<td class="formTd" colspan="2">
							<xsl:for-each select = "/APPSHORE/APP/popup_edit_fields/popup_edit_fields_item[popup_edit_block_id = $blockId and popup_edit_side = 'L']" >
								<xsl:call-template name="editFields" >
									<xsl:with-param name="thisForm" select="$thisForm"/>
								    <xsl:with-param name="appName" select="$appName"/>
								    <xsl:with-param name="appLabel" select="$appLabel"/>
								    <xsl:with-param name="nodeName" select="$nodeName"/>
								    <xsl:with-param name="recordId" select="$recordId"/>
								    <xsl:with-param name="recordName" select="$recordName"/>
						    	</xsl:call-template>									
							</xsl:for-each>
						</td>						
				    </xsl:when>
				    <xsl:otherwise>
						<td class="formTdLeft">
							<xsl:for-each select = "/APPSHORE/APP/popup_edit_fields/popup_edit_fields_item[popup_edit_block_id = $blockId and popup_edit_side = 'L']" >
								<xsl:call-template name="editFields" >
									<xsl:with-param name="thisForm" select="$thisForm"/>
								    <xsl:with-param name="appName" select="$appName"/>
								    <xsl:with-param name="appLabel" select="$appLabel"/>
								    <xsl:with-param name="nodeName" select="$nodeName"/>
								    <xsl:with-param name="recordId" select="$recordId"/>
								    <xsl:with-param name="recordName" select="$recordName"/>
						    	</xsl:call-template>									
							</xsl:for-each>
						</td>
						<td class="formTdRight">
							<xsl:for-each select = "/APPSHORE/APP/popup_edit_fields/popup_edit_fields_item[popup_edit_block_id = $blockId and popup_edit_side = 'R']" >
								<xsl:call-template name="editFields" >
									<xsl:with-param name="thisForm" select="$thisForm"/>
								    <xsl:with-param name="appName" select="$appName"/>
								    <xsl:with-param name="appLabel" select="$appLabel"/>
								    <xsl:with-param name="nodeName" select="$nodeName"/>
								    <xsl:with-param name="recordId" select="$recordId"/>
								    <xsl:with-param name="recordName" select="$recordName"/>
						    	</xsl:call-template>									
							</xsl:for-each>
						</td>
					   </xsl:otherwise>
				</xsl:choose>
			</tr>
		</xsl:for-each>
	</table>	
</xsl:template>


<xsl:template name="customPopupEditButtons">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	
	<xsl:param name="nodeName"/>	
	<xsl:param name="isTop"/>	
	<xsl:param name="delete"/>	
	
    <table cellSpacing="1" cellPadding="1" width="100%" border="0">
		<tr>
			<td align="left" width="45%">
				<input type="submit" class="formBarButton" name="Save" id="Save" onclick="top.window.winReload=true;document.{$thisForm}.key.value=this.name">
		            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
		        </input>&#160;
				<xsl:if test="$delete = 'true'">   					 		                
					<input type="button" class="formBarButton" name="Delete" onclick="document.{$thisForm}.key.value=this.name;confirmAction(document.{$thisForm},'{/APPSHORE/API/current_user/confirm_delete}');">
			            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Delete')"/></xsl:attribute>
	                </input>&#160;
				</xsl:if>
		        <input type='button' class="formBarButton" onclick="popupClose2('custom_edit');">
               		<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Close')"/></xsl:attribute>                    
	    		</input>
			</td> 
			<td align="center" width="10%">					
			</td>
			<td align="right" width="45%">	
				<xsl:if test = "users/users_item and $isTop">
	            	<xsl:value-of select="php:function('lang','Assigned to')"/>&#160;
	        		<select class="fieldInputSelect" name="user_id" >
	        			<xsl:for-each select = "users/users_item" >
       						<option value="{user_id}">
	        					<xsl:if test="user_id = /APPSHORE/APP/node()[name() = $nodeName]/user_id">
        							<xsl:attribute name="selected" value="true"/>
	        					</xsl:if>
     							<xsl:value-of select="full_name"/> - <xsl:value-of select="user_name"/>
    						</option>
	        			</xsl:for-each>
	        		</select>
	        	</xsl:if>
			</td>
		</tr>
	</table>				        
</xsl:template>


<xsl:template name="custom_popup_confirm_delete">
	<script type="text/javascript">
		popupClose();
	</script>
</xsl:template>


</xsl:stylesheet>
