<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="custom_view">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>	
	<xsl:param name="nodeName"/>	
	<xsl:param name="recordId"/>	
	<xsl:param name="recordName"/>	
	<xsl:param name="assignedto" select="'true'"/>	
	<xsl:param name="edit" select="'true'"/>	
	<xsl:param name="delete" select="'true'"/>	
	<xsl:param name="duplicate" select="'true'"/>	
	<xsl:param name="print" select="'true'"/>	
	<xsl:param name="export" select="'true'"/>	
	<xsl:param name="tags" select="'true'"/>	
	
	<xsl:variable name="recordIdValue" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $recordId]"/>
	<xsl:variable name="recordNameValue" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $recordName]"/>

    <div class="clearboth">
		<div class="formTitleTags start_float">
			<xsl:choose>
				<xsl:when test="string-length($recordNameValue)">
					<xsl:value-of select="php:functionString('lang',$appLabel)"/>:&#160;<xsl:value-of select="$recordNameValue"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="php:functionString('lang',$appLabel)"/>
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

	<form name="custom_view" method="post" >
		<input type="hidden" name="op" id="op" value="{$appName}.base.view"/>
		<input type="hidden" name="key" id="key" />	
		<input type="hidden" name="selected" id="selected" value="{$recordIdValue}"/>	
<!--		<input type="hidden" name="bulk_id" id="bulk_id" value="Selected"/>	-->
		<input name="{$recordId}" id="{$recordId}" type="hidden" value="{$recordIdValue}" />				
			
		<div class="clearboth formBar">
			<xsl:call-template name="viewButtons">
				<xsl:with-param name="thisForm" select="'custom_view'"/>
				<xsl:with-param name="isTop" select="'true'"/>
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="recordId" select="$recordId"/>
				<xsl:with-param name="recordIdValue" select="$recordIdValue"/>
				<xsl:with-param name="assignedto" select="$assignedto"/>
				<xsl:with-param name="edit" select="$edit"/>
				<xsl:with-param name="delete" select="$delete"/>
				<xsl:with-param name="duplicate" select="$duplicate"/>		
				<xsl:with-param name="print" select="$print"/>		
				<xsl:with-param name="export" select="$export"/>		
				<xsl:with-param name="tags" select="$tags"/>		
			</xsl:call-template> 				
		</div>	
		
		<div class="clearboth">
			<xsl:call-template name="viewBody">
				<xsl:with-param name="thisForm" select="'custom_view'"/>
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="appLabel" select="$appLabel"/>
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="recordId" select="$recordId"/>
				<xsl:with-param name="recordName" select="$recordName"/>
			</xsl:call-template> 				
		</div>	

		<xsl:if test="/APPSHORE/API/Plugins/Plugins_item = 'ViewLines'">
		    <xsl:apply-templates select="/APPSHORE/API/Plugins" mode="ViewLines">
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="thisForm" select="'custom_view'"/>		
		    </xsl:apply-templates>
		</xsl:if>

		<div class="clearboth formBar">
			<xsl:call-template name="viewButtons">
				<xsl:with-param name="thisForm" select="'custom_view'"/>
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="recordId" select="$recordId"/>
				<xsl:with-param name="recordIdValue" select="$recordIdValue"/>
				<xsl:with-param name="edit" select="$edit"/>
				<xsl:with-param name="delete" select="$delete"/>
				<xsl:with-param name="duplicate" select="$duplicate"/>		
				<xsl:with-param name="print" select="$print"/>		
				<xsl:with-param name="export" select="$export"/>		
				<xsl:with-param name="tags" select="$tags"/>		
			</xsl:call-template> 				
		</div>	
			
	</form>

	<div class="clearboth">
		<br/>
		<xsl:call-template name="customLinked">
			<xsl:with-param name="masterForm" select="'custom_view'"/>
			<xsl:with-param name="masterTableName" select="$appName"/>
			<xsl:with-param name="masterRecordId" select="$recordId"/>
			<xsl:with-param name="masterRecordIdValue" select="$recordIdValue"/>
			<xsl:with-param name="masterRecordNameValue" select="$recordNameValue"/>
		</xsl:call-template> 
	</div>	

</xsl:template>


<xsl:template name="custom_popup_view">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>	
	<xsl:param name="nodeName"/>	
	<xsl:param name="recordId"/>	
	<xsl:param name="recordName"/>	
		
	<table class="popupFormTable">
		<xsl:for-each select = "popup_view_blocks/popup_view_blocks_item" >
			<xsl:if test="is_title = 'Y' ">   					 		                                    
				<tr>
					<td class="formBlockTitle" colspan="2">
						<xsl:value-of select="block_name" />
					</td>
				</tr>
			</xsl:if>  				            
			<tr class="formTr">
				<xsl:variable name="blockId" select="block_id"/>
				<xsl:choose>
				    <xsl:when test="columns = '1'">
						<td class="formTd" colspan="2">
							<xsl:for-each select = "/APPSHORE/APP/popup_view_fields/popup_view_fields_item[popup_view_block_id = $blockId and popup_view_side = 'L']" >
								<xsl:call-template name="viewFields" >
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
							<xsl:for-each select = "/APPSHORE/APP/popup_view_fields/popup_view_fields_item[popup_view_block_id = $blockId and popup_view_side = 'L']" >
								<xsl:call-template name="viewFields" >
								    <xsl:with-param name="appName" select="$appName"/>
								    <xsl:with-param name="appLabel" select="$appLabel"/>
								    <xsl:with-param name="nodeName" select="$nodeName"/>
								    <xsl:with-param name="recordId" select="$recordId"/>
								    <xsl:with-param name="recordName" select="$recordName"/>
						    	</xsl:call-template>									
							</xsl:for-each>
						</td>
						<td class="formTdRight">
							<xsl:for-each select = "/APPSHORE/APP/popup_view_fields/popup_view_fields_item[popup_view_block_id = $blockId and popup_view_side = 'R']" >
								<xsl:call-template name="viewFields" >
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

<xsl:template name="custom_print_view">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>	
	<xsl:param name="nodeName"/>	
	<xsl:param name="recordId"/>	
	<xsl:param name="recordName"/>	
		
	<table class="popupFormTable">
		<xsl:for-each select = "print_view_blocks/print_view_blocks_item" >
			<xsl:if test="is_title = 'Y' ">   					 		                                    
				<tr>
					<td class="formBlockTitle" colspan="2">
						<xsl:value-of select="block_name" />
					</td>
				</tr>
			</xsl:if>  				            
			<tr class="formTr">
				<xsl:variable name="blockId" select="block_id"/>
				<xsl:choose>
				    <xsl:when test="columns = '1'">
						<td class="formTd" colspan="2">
							<xsl:for-each select = "/APPSHORE/APP/print_view_fields/print_view_fields_item[print_view_block_id = $blockId and print_view_side = 'L']" >
								<xsl:call-template name="viewFields" >
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
							<xsl:for-each select = "/APPSHORE/APP/print_view_fields/print_view_fields_item[print_view_block_id = $blockId and print_view_side = 'L']" >
								<xsl:call-template name="viewFields" >
								    <xsl:with-param name="appName" select="$appName"/>
								    <xsl:with-param name="appLabel" select="$appLabel"/>
								    <xsl:with-param name="nodeName" select="$nodeName"/>
								    <xsl:with-param name="recordId" select="$recordId"/>
								    <xsl:with-param name="recordName" select="$recordName"/>
						    	</xsl:call-template>									
							</xsl:for-each>
						</td>
						<td class="formTdRight">
							<xsl:for-each select = "/APPSHORE/APP/print_view_fields/print_view_fields_item[print_view_block_id = $blockId and print_view_side = 'R']" >
								<xsl:call-template name="viewFields" >
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


<xsl:template name="viewBody">
	<xsl:param name="thisForm"/>
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>	
	<xsl:param name="nodeName"/>	
	<xsl:param name="recordId"/>	
	<xsl:param name="recordName"/>	
		
	<table class="formTable">
		<xsl:for-each select = "view_blocks/view_blocks_item" >
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
							<xsl:for-each select = "/APPSHORE/APP/view_fields/view_fields_item[view_block_id = $blockId and view_side = 'L']" >
								<xsl:call-template name="viewFields" >
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
							<xsl:for-each select = "/APPSHORE/APP/view_fields/view_fields_item[view_block_id = $blockId and view_side = 'L']" >
								<xsl:call-template name="viewFields" >
								    <xsl:with-param name="appName" select="$appName"/>
								    <xsl:with-param name="appLabel" select="$appLabel"/>
								    <xsl:with-param name="nodeName" select="$nodeName"/>
								    <xsl:with-param name="recordId" select="$recordId"/>
								    <xsl:with-param name="recordName" select="$recordName"/>
						    	</xsl:call-template>									
							</xsl:for-each>
						</td>
						<td class="formTdRight">
							<xsl:for-each select = "/APPSHORE/APP/view_fields/view_fields_item[view_block_id = $blockId and view_side = 'R']" >
								<xsl:call-template name="viewFields" >
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

<xsl:template name="viewFields">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>	
	<xsl:param name="nodeName"/>	
	<xsl:param name="recordId"/>	
	<xsl:param name="recordName"/>	

	<xsl:variable name="field_id_value" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $recordId]"/>	

	<div class="clearboth fieldLabelContainer" style="padding-top:10px">
		<div class="fieldLabel start_float">
			<xsl:attribute name="title"><xsl:value-of select="php:functionString('lang',field_label)"/></xsl:attribute>
			<xsl:value-of select="php:functionString('lang',field_label)"/>
		</div>
		
		<xsl:choose>
			<xsl:when test="field_type = 'EA' or field_type = 'EH'">
				<div class="end_float">
					<a class="fieldAssociatedLink" onclick="if($('{field_name}').getHeight()&#60;1000)$('{field_name}').style.height = ($('{field_name}').getHeight()+200)+'px';">
						<xsl:attribute name="title"><xsl:value-of select="php:function('lang','More lines')"/></xsl:attribute>
						<img border="0" src="{$api_image_path}/plus_16.png"/>
		   			</a>&#160;
					<a class="fieldAssociatedLink" onclick="if($('{field_name}').getHeight()&#62;250)$('{field_name}').style.height = ($('{field_name}').getHeight()-200)+'px';">
						<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Less lines')"/></xsl:attribute>
						<img border="0" src="{$api_image_path}/minus_16.png"/>
		   			</a>
				</div>
			</xsl:when>
		
			<xsl:when test="field_type = 'ML'">
				<div class="end_float">
					<xsl:choose>
						<xsl:when test ="field_name = 'address_billing'">
							<xsl:call-template name="geoLocation">
								<xsl:with-param name="full_address" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = 'full_address_billing']"/>
								<xsl:with-param name="origin_address">
									<xsl:choose>
										<xsl:when test ="string-length(/APPSHORE/API/current_user/direction_billing) > 0">
											<xsl:value-of select="/APPSHORE/API/current_user/direction_billing"/>
										</xsl:when>						
										<xsl:otherwise>
											<xsl:value-of select="/APPSHORE/API/my_company/direction_billing"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>	
						</xsl:when>
						<xsl:when test ="field_name = 'address_shipping'">	
							<xsl:call-template name="geoLocation">
								<xsl:with-param name="full_address" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = 'full_address_shipping']"/>
								<xsl:with-param name="origin_address">
									<xsl:choose>
										<xsl:when test ="string-length(/APPSHORE/API/current_user/direction_shipping) > 0">
											<xsl:value-of select="/APPSHORE/API/current_user/direction_shipping"/>
										</xsl:when>						
										<xsl:otherwise>
											<xsl:value-of select="/APPSHORE/API/my_company/direction_shipping"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>								
						</xsl:when>
						<xsl:when test ="field_name = 'address_1'">	
							<xsl:call-template name="geoLocation">
								<xsl:with-param name="full_address" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = 'full_address_1']"/>
								<xsl:with-param name="origin_address">
									<xsl:choose>
										<xsl:when test ="string-length(/APPSHORE/API/current_user/direction_billing) > 0">
											<xsl:value-of select="/APPSHORE/API/current_user/direction_billing"/>
										</xsl:when>						
										<xsl:otherwise>
											<xsl:value-of select="/APPSHORE/API/my_company/direction_billing"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>								
						</xsl:when>
						<xsl:when test ="field_name = 'address_2'">	
							<xsl:call-template name="geoLocation">
								<xsl:with-param name="full_address" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = 'full_address_2']"/>
								<xsl:with-param name="origin_address">
									<xsl:choose>
										<xsl:when test ="string-length(/APPSHORE/API/current_user/direction_shipping) > 0">
											<xsl:value-of select="/APPSHORE/API/current_user/direction_shipping"/>
										</xsl:when>						
										<xsl:otherwise>
											<xsl:value-of select="/APPSHORE/API/my_company/direction_shipping"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>								
						</xsl:when>						
					    <xsl:otherwise>
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
				</div>
			</xsl:when>
			
		</xsl:choose>
				
		<div class="clearboth fieldText" >
			<xsl:choose>

			    <xsl:when test="field_type = 'AT'">
					<xsl:for-each select = "/APPSHORE/APP/files/files_item">
						<a href="{$baseurl}&amp;op=webmail.download.attachment&amp;attachment_id={attachment_id}">
							<xsl:value-of select="filename"/>
						</a>&#160;	
					</xsl:for-each>									
					<xsl:for-each select = "/APPSHORE/APP/documents/documents_item">
						<a href="{$baseurl}&amp;op=webmail.download.document&amp;document_id={document_id}">
							<xsl:value-of select="document_name"/>
						</a>&#160;	
					</xsl:for-each>	
			    </xsl:when>		
			
			    <xsl:when test="field_type = 'CH'">
					<xsl:choose>
					    <xsl:when test="field_current_value = 'Y' or field_current_value = '1'">
							<img class="image" src="{$api_image_path}/checked.png"/>
				    	</xsl:when>	
					    <xsl:otherwise>
							<img class="image" src="{$api_image_path}/unchecked.png"/>
				   	   </xsl:otherwise>			    		    
					</xsl:choose>					
			    </xsl:when>		
			    		    			
			    <xsl:when test="field_type = 'CU'">
					<xsl:value-of select="/APPSHORE/API/current_user/currency_id" />&#160;<xsl:value-of select="format-number(field_current_value, '###,###,###')"/>
			    </xsl:when>	
			    		    			
			    <xsl:when test="field_type = 'CD'">
					<xsl:value-of select="/APPSHORE/API/current_user/currency_id" />&#160;<xsl:value-of select="format-number(field_current_value, '###,###,###.00')"/>
			    </xsl:when>	

			    <xsl:when test="field_type = 'DD'">
					<xsl:choose>
					    <xsl:when test="string-length(related_id) > 0">
							<xsl:variable name="related_field_name_value">related_<xsl:value-of select="field_name"/></xsl:variable>
							<xsl:value-of select="php:functionString('lang',/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $related_field_name_value])"/>
					    </xsl:when>	
					    <xsl:otherwise>
							<xsl:value-of select="php:functionString('lang',field_current_value)"/>
				   	   </xsl:otherwise>			    		    
					</xsl:choose>				    
		   	   </xsl:when>	
			    
			    <xsl:when test="field_type = 'DO'">
			    	<xsl:variable name="is_folder" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = 'is_folder']"/>
					<xsl:choose>
					    <xsl:when test="$is_folder = 'Y'">
					        <a target="_top" href="{$baseurl}&amp;op={$appName}.base.search&amp;folder_id={$field_id_value}">
								<xsl:value-of select="field_current_value"/>	
					        </a>							
					    </xsl:when>
					    <xsl:otherwise>
					        <a target="_top" href="{$baseurl}&amp;op={$appName}.download.start&amp;{$recordId}={$field_id_value}">
								<xsl:value-of select="field_current_value"/>	
					        </a>							
					    </xsl:otherwise>
					</xsl:choose>
			    </xsl:when>	
	
			    <xsl:when test="field_type = 'EA' or field_type = 'EH'">
					<iframe class="fieldTextarea" id="{field_name}" name="{field_name}" scroll="auto" style="height:{field_height*2}em"/>
					<input id="{field_name}_hidden" name="{field_name}_hidden" type="hidden" value="{field_current_value}"/>
					<script language="Javascript" type="text/javascript">
						var bodyframe = window.frames['<xsl:value-of select="field_name"/>'].document;
						bodyframe.open();
						bodyframe.write($('<xsl:value-of select="field_name"/>_hidden').value);
						bodyframe.close();
					</script>
			    </xsl:when>		

			    <xsl:when test="field_type = 'EM'">
					<xsl:value-of select="field_current_value"/>
				</xsl:when>				    							    					    							    						    					    

			    <xsl:when test="field_type = 'ET'">
			    	<textarea class="fieldTextarea formtextarea" readonly="true" style="height:{field_height*2}em">
						<xsl:value-of select="field_current_value"/>
					</textarea>
				</xsl:when>				    							    					    							    						    					    
	
				<xsl:when test="field_type = 'IM'">
					<img class="image fieldAssociatedLink" src="{$basepath}/lib/image.php?image_id={field_current_value}_96" style="height:{field_height}em" onclick="popupInter('{$basepath}/lib/image.php?image_id={field_current_value}','{field_label}');">
			       		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Full size')"/></xsl:attribute>                    
					</img>
				</xsl:when>			

			    <xsl:when test="field_type = 'ML'">
					<textarea class="fieldTextarea"  id="{field_name}" readonly="true" style="height:{field_height*2}em">
						<xsl:value-of select="field_current_value"/>
					</textarea>
			    </xsl:when>		

			    <xsl:when test="field_type = 'MV'">
					<xsl:for-each select = "field_current_value/field_current_value_item" >					
						<xsl:if test="position() > 1">, </xsl:if><xsl:value-of select="php:functionString('lang',.)"/>
					</xsl:for-each>																			
			    </xsl:when>		
		
			    <xsl:when test="field_type = 'NU'">
					<xsl:value-of select="format-number(field_current_value, '###,###,###')"/>
			    </xsl:when>								    	
		
			    <xsl:when test="field_type = 'ND'">
					<xsl:value-of select="format-number(field_current_value, '###,###,###.00')"/>
			    </xsl:when>								    	
		    		    				
			    <xsl:when test="field_type = 'PE'">
					<xsl:value-of select="format-number(field_current_value, '#')"/>%
			    </xsl:when>								    	
		    		    				
			    <xsl:when test="field_type = 'PD'">
					<xsl:value-of select="format-number(field_current_value, '#.00')"/>%
			    </xsl:when>								    	
		    		    			
			    <xsl:when test="field_type = 'PH'">
					<xsl:call-template name="callto">
						<xsl:with-param name="phone" select="field_current_value"/>
					</xsl:call-template>
			    </xsl:when>	
		    	
			    <xsl:when test="field_type = 'RR' or field_type = 'DF'">
					<xsl:variable name="related_field_name_value">related_<xsl:value-of select="field_name"/></xsl:variable>
		   	        <a target="_top" href="{$baseurl}&amp;op={related_app_name}.base.view&amp;{related_id}={field_current_value}" onMouseOver="popupDetails('{$baseurl}&amp;op={related_app_name}.popup.view&amp;{related_id}={field_current_value}','Details','{$api_image_path}','');" onMouseOut="return nd();"  >
						<xsl:value-of select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $related_field_name_value]"/>
					</a>
			    </xsl:when>	

			    <xsl:when test="field_type = 'RD' or field_type = 'RM'">
					<xsl:value-of select="field_current_value_nbr"/>&#160;<xsl:value-of select="php:functionString('lang',field_current_value_period)"/>
				</xsl:when>				    							    					    							    						    					    
	
			    <xsl:when test="field_type = 'TS'">
					<xsl:value-of select="field_current_value"/>				
					<xsl:variable name="related_field_name">related_<xsl:value-of select="field_name"/>_by</xsl:variable>
					<xsl:variable name="related_field_name_value" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $related_field_name]"/>
					<xsl:if test = "string-length($related_field_name_value)">&#160;<xsl:value-of select="php:function('lang','by')"/>&#160;<xsl:value-of select="$related_field_name_value"/>
					</xsl:if>
			    </xsl:when>				    			

			    <xsl:when test="field_type = 'WM'">
					<xsl:call-template name="mailto">
						<xsl:with-param name="email" select="field_current_value"/>
						<xsl:with-param name="name">
							<xsl:choose>
								<xsl:when test = "/APPSHORE/APP/node()[name() = $nodeName]/full_name"> 
									<xsl:value-of select="/APPSHORE/APP/node()[name() = $nodeName]/full_name"/>
								</xsl:when>
								<xsl:otherwise> 
									<xsl:value-of select="/APPSHORE/APP/node()[name() = $nodeName]/account_name"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="appName" select="$appName"/>
						<xsl:with-param name="recordIdValue" select="$field_id_value"/>
					</xsl:call-template>
			    </xsl:when>	

			    <xsl:when test="field_type = 'WS' and string-length(field_current_value)">
				   	<a href="javascript:;" onclick="popupInter('{field_current_value}','{field_current_value}');">
						<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Open a popup window')"/></xsl:attribute>
						<xsl:value-of select="field_current_value"/>
					</a>
					<a href="{field_current_value}" target="_new">
						<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Open a new window')"/></xsl:attribute>
						<img class="image" src="{$api_image_path}/openwindow_16.png"/>
					</a>
			    </xsl:when>	
	
			    <xsl:otherwise>
					<xsl:choose>
					    <xsl:when test="string-length(related_id) > 0">
							<xsl:variable name="related_field_name_value">related_<xsl:value-of select="field_name"/></xsl:variable>
							<xsl:value-of select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $related_field_name_value]"/>				    
					    </xsl:when>	
					    <xsl:otherwise>
							<xsl:value-of select="field_current_value"/>
				   	   </xsl:otherwise>			    		    
					</xsl:choose>				    
		   	   </xsl:otherwise>			    		    
		   	   
			</xsl:choose>
			&#160;
		</div>
	</div>
</xsl:template>


<xsl:template name="viewButtons">
	<xsl:param name="thisForm"/>
	<xsl:param name="appName"/>
	<xsl:param name="nodeName"/>
	<xsl:param name="recordId"/>	
	<xsl:param name="recordIdValue"/>	
	<xsl:param name="isTop"/>
	<xsl:param name="assignedto"/>	
	<xsl:param name="edit" select="'true'"/>	
	<xsl:param name="duplicate"/>	
	<xsl:param name="delete"/>	
	<xsl:param name="print"/>	
	<xsl:param name="export"/>	
	<xsl:param name="tags"/>	
	
    <table cellSpacing="1" cellPadding="1" width="100%" border="0">
		<tr>
			<td class="start_direction">
				<xsl:if test="/APPSHORE/APP/scope > 0 ">
					<xsl:if test="$edit = 'true'">                    
						<input type="button" class="formBarButton" name="Edit" onclick="window.location='{$baseurl}&amp;op={$appName}.base.edit&amp;{$recordId}={$recordIdValue}';">
					        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Edit')"/></xsl:attribute>
					    </input>&#160;
					</xsl:if>
					<xsl:if test="$duplicate = 'true'">                    
						<input type="button" class="formBarButton" name="Duplicate" onclick="window.location='{$baseurl}&amp;op={$appName}.base.edit&amp;key=Duplicate&amp;{$recordId}={$recordIdValue}';">
				            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Duplicate')"/></xsl:attribute>
		                </input>&#160;
					</xsl:if>
					<xsl:if test="$delete = 'true'">   					 		                
						<input type="button" class="formBarButton" name="Delete" onclick="document.{$thisForm}.key.value=this.name;confirmAction(document.{$thisForm},'{/APPSHORE/API/current_user/confirm_delete}');">
				            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Delete')"/></xsl:attribute>
		                </input>&#160;
					</xsl:if>
				</xsl:if>				
				<xsl:if test="/APPSHORE/API/Plugins">
		            <xsl:apply-templates select="/APPSHORE/API/Plugins" mode="ViewButtons">
						<xsl:with-param name="thisForm" select="'custom_view'"/>
						<xsl:with-param name="appName" select="$appName"/>
						<xsl:with-param name="nodeName" select="$nodeName"/>
						<xsl:with-param name="recordId" select="$recordId"/>
						<xsl:with-param name="recordIdValue" select="$recordIdValue"/>
		            </xsl:apply-templates>
		        </xsl:if>
			    <xsl:if test = "/APPSHORE/API/export and $export = 'true'">	
					<input type="button" class="formBarButton" name="Export" onclick="location.href='{$baseurl}&amp;op={$appName}.export.record&amp;record_id={$recordIdValue}'; return false;">
				        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Export')"/></xsl:attribute>
				        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Export to a CSV file')"/></xsl:attribute>	            
				    </input>&#160;  
			    </xsl:if>   
			    <xsl:if test = "/APPSHORE/API/tag and $tags = 'true'">
					<script language="JavaScript" type="text/javascript" src="{$lib_js_path}/lists.js?language={/APPSHORE/API/current_user/language_id}"/>		

					<script language='javascript' >
						var dropdownlist = new Lists(document.<xsl:value-of select="$thisForm"/>,document.<xsl:value-of select="$thisForm"/>);
					</script>	    
					
			    	<xsl:call-template name="listViewForm">
			    		<xsl:with-param name="appName" select="$appName"/>
						<xsl:with-param name="targetAppName">tags</xsl:with-param>				
						<xsl:with-param name="targetAppLabel">Tag</xsl:with-param>				
						<xsl:with-param name="targetClassName">tags.ajax</xsl:with-param>				
						<xsl:with-param name="addSelectionLabel">Add a tag</xsl:with-param>				
						<xsl:with-param name="createSelectionLabel">Create a new tag</xsl:with-param>				
						<xsl:with-param name="useSelectionLabel">Use an existing tag</xsl:with-param>				
			    	</xsl:call-template>&#160;
			    </xsl:if>      
                        
				<xsl:if test="$print = 'true'">   					 		                
					<xsl:variable name="title"><xsl:value-of select="php:function('lang','Print')"/></xsl:variable>				
					<input type="button" class="formBarButton" name="Print" id="Print" onclick="popupIntra('{$baseurl}&amp;op={$appName}.print.view&amp;key=Print&amp;{$recordId}={$recordIdValue}','{$title}');" >
	               		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Print the record')"/></xsl:attribute>                    
			            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Print')"/></xsl:attribute>
	                </input>&#160;
			        <!--
					<input type="submit" class="formBarButton" name="Pdf" id="Pdf" onclick="document.{$thisForm}.key.value=this.name">
			            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','PDF')"/></xsl:attribute>
	                    <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Generate the current record in a PDF file')"/></xsl:attribute>                    
			        </input>&#160;
					<input type="submit" class="formBarButton" name="Word" id="Word" onclick="document.{$thisForm}.key.value=this.name">
			            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','MS Word')"/></xsl:attribute>
	                    <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Generate the current record in a MS Word document')"/></xsl:attribute>                    
			        </input>
			        -->
	        	</xsl:if>
			</td> 
			<td class="end_direction">	
	            <xsl:if test="($assignedto = 'true') and ($isTop = 'true')">
 	               <xsl:value-of select="php:function('lang','Assigned to')"/>&#160;<xsl:value-of select="/APPSHORE/APP/node()[$nodeName]/owner_full_name"/>&#160;			
 	               <xsl:if test="recordset/currentVal = '0'">
						-&#160;
					</xsl:if>
				</xsl:if>
			    <xsl:call-template name="buttonsNavigation">
					<xsl:with-param name="thisForm" select="$thisForm"/>
				</xsl:call-template>
			</td>
		</tr>
	</table>										                    
</xsl:template>

<xsl:template name="listViewForm">
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
