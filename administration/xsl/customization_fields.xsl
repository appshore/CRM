<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name='customization_fields'>	
	<script language="JavaScript" type="text/javascript" src="administration/js/customization_fields.js"/>
	
	<div class="helpmsg">
		<xsl:value-of disable-output-escaping="yes" select="php:function('lang','administration.customization.fields.help')"/>
	</div>
	
	<div class="clearboth">

		<form id='fieldProperties' name='fieldProperties' method='post'>
		<input type='hidden' id="op" name='op' value='administration.customization_fields.edit'/>	
		<input type='hidden' id="app_name" name="app_name" value='{customization/app_name}'/>	
		<input type="hidden" id="key" name="key"/>
		<input type="hidden" id="fields_selected" name="fields_selected"/>

		<xsl:call-template name="formButtonsProperties">
    		<xsl:with-param name="thisForm" select="'fieldProperties'"/>
		</xsl:call-template>  	 		
		
	   	<table style="width:100%" cellSpacing='1' cellPadding='1' border='0'>
	   		<xsl:if test = "fields/fields_item" >
				<tr class="label" align="center" style="height:2em">
				    <td style="width:2em"></td>
					<td>
						<xsl:attribute name="title">
							<xsl:value-of select="php:function('lang','Name')"/>
						</xsl:attribute>
						<xsl:value-of select="php:function('lang','Name')"/>
					</td>
					<td>
						<xsl:attribute name="title">
							<xsl:value-of select="php:function('lang','Label')"/>
						</xsl:attribute>
						<xsl:value-of select="php:function('lang','Label')"/>
					</td>													
					<td>
						<xsl:attribute name="title">
							<xsl:value-of select="php:function('lang','Type')"/>
						</xsl:attribute>
						<xsl:value-of select="php:function('lang','Type')"/>
					</td>
					<td>
						<xsl:attribute name="title">
							<xsl:value-of select="php:function('lang','Read only')"/>
						</xsl:attribute>
						<xsl:value-of select="php:function('lang','R')"/>
					</td>
					<td>
						<xsl:attribute name="title">
							<xsl:value-of select="php:function('lang','Mandatory')"/>
						</xsl:attribute>
						<xsl:value-of select="php:function('lang','M')"/>
					</td>
					<td>
						<xsl:attribute name="title">
							<xsl:value-of select="php:function('lang','Unique')"/>
						</xsl:attribute>
						<xsl:value-of select="php:function('lang','U')"/>
					</td>
					<td>
						<xsl:attribute name="title">
							<xsl:value-of select="php:function('lang','Search filter')"/>
						</xsl:attribute>
						<xsl:value-of select="php:function('lang','S')"/>
					</td>
					<td>
						<xsl:attribute name="title">
							<xsl:value-of select="php:function('lang','Related table')"/>
						</xsl:attribute>
						<xsl:value-of select="php:function('lang','Table')"/>
					</td>													
					<td>
						<xsl:attribute name="title">
							<xsl:value-of select="php:function('lang','Related field')"/>
						</xsl:attribute>
						<xsl:value-of select="php:function('lang','Related field')"/>
					</td>					
					<td>
						<xsl:attribute name="title">
							<xsl:value-of select="php:function('lang','Display field')"/>
						</xsl:attribute>
						<xsl:value-of select="php:function('lang','Display field')"/>
					</td>					
				</tr>  
			</xsl:if>  	
			<xsl:for-each select = "fields/fields_item" >		
				<xsl:variable name="unselectedtext"><xsl:choose><xsl:when test ="record_date = 'new'">new</xsl:when><xsl:when test ="record_date = 'expired'">expired</xsl:when><xsl:otherwise>unselectedtext</xsl:otherwise></xsl:choose></xsl:variable>											
				<tr class="{$unselectedtext}" onMouseOver="this.className ='selectedtext'" onMouseOut="this.className ='{$unselectedtext}'">
				    <xsl:call-template name="checkListForm">
						<xsl:with-param name="thisForm" select="'fieldProperties'"/>
						<xsl:with-param name="thisId" select="field_name"/>
						<xsl:with-param name="scope"><xsl:if test="is_custom = 'Y'">1</xsl:if></xsl:with-param>					
					</xsl:call-template>
					<td class="custom_is_custom_{is_custom}" >
						<xsl:choose>
							<xsl:when test="string-length(field_name)">
								<input type="hidden" id="field_name_{increment}" name="field_name_{increment}" value="{field_name}" />
								<xsl:value-of select="field_name" />
							</xsl:when>
							<xsl:otherwise>
								<input type="text" name="field_name_{increment}" id="field_name_{increment}" style="width:95%" value="{field_name}" />
							</xsl:otherwise>
						</xsl:choose>					
					</td>
					<td >
						<input type="text" name="field_label_{increment}" id="field_label_{increment}" style="width:95%">
							<xsl:attribute name="value">
								<xsl:value-of select="field_label" />
							</xsl:attribute>
						</input>
					</td>
					<td >
						<xsl:variable name="fieldType" select="field_type" />		
						<xsl:choose>									
							<xsl:when test="is_custom = 'N'">
								<xsl:value-of select="php:functionString('lang',/APPSHORE/APP/field_types/field_types_item[type_id = $fieldType]/type_name)"/>
							</xsl:when>
							<xsl:otherwise>
								<select name="field_type_{increment}" id="field_type_{increment}" style="width:95%" onchange="changeType('{increment}');">
									<xsl:for-each select = "/APPSHORE/APP/field_types/field_types_item[type_custom = 'Y']">
										<option value="{type_id}">
											<xsl:if test="type_id = $fieldType">
												<xsl:attribute name="selected" value="true"/>
											</xsl:if>
											<xsl:value-of select="php:functionString('lang',type_name)"/>
										</option>
									</xsl:for-each>
								</select>
							</xsl:otherwise>
						</xsl:choose>
					</td>
					<td align="center" title="Read only">
						<xsl:if test="checkbox_is_readonly = 'true'">
							<input name="is_readonly_{increment}" id="is_readonly_{increment}" type="hidden" value="{is_readonly}" />				
							<input type="checkbox" name="checkbox_is_readonly_{increment}" id="checkbox_is_readonly_{increment}" value="{is_readonly}" onclick="boxchecked(document.fieldProperties.checkbox_is_readonly_{increment},document.fieldProperties.is_readonly_{increment});" >
								<xsl:if test="is_readonly = 'Y'">
									<xsl:attribute name="checked"/>
								</xsl:if>
							</input>	
						</xsl:if>						
					</td>		
					<td align="center" title="Mandatory">
						<xsl:if test="checkbox_is_mandatory = 'true'">
							<input name="is_mandatory_{increment}" id="is_mandatory_{increment}" type="hidden" value="{is_mandatory}" />				
							<input type="checkbox" name="checkbox_is_mandatory_{increment}" id="checkbox_is_mandatory_{increment}" value="{is_mandatory}" onclick="boxchecked(document.fieldProperties.checkbox_is_mandatory_{increment},document.fieldProperties.is_mandatory_{increment});" >
								<xsl:if test="is_mandatory = 'Y'">
									<xsl:attribute name="checked"/>
								</xsl:if>
							</input>	
						</xsl:if>						
					</td>		
					<td align="center" title="Unique">
						<xsl:if test="checkbox_is_unique = 'true'">
							<input name="is_unique_{increment}" id="is_unique_{increment}" type="hidden" value="{is_unique}" />				
							<input type="checkbox" name="checkbox_is_unique_{increment}" id="checkbox_is_unique_{increment}" value="{is_unique}" onclick="return uniqueness('{increment}');" >
								<xsl:if test="is_unique = 'Y'">
									<xsl:attribute name="checked"/>
								</xsl:if>
							</input>							
						</xsl:if>
					</td>		
					<td align="center" title="Search filter">
						<xsl:if test="checkbox_is_search = 'true'">
							<input name="is_search_{increment}" id="is_search_{increment}" type="hidden" value="{is_search}" />				
							<input type="checkbox" name="checkbox_is_search_{increment}" id="checkbox_is_search_{increment}" value="{is_search}" onclick="boxchecked(document.fieldProperties.checkbox_is_search_{increment},document.fieldProperties.is_search_{increment});" >
								<xsl:if test="is_search = 'Y'">
									<xsl:attribute name="checked"/>
								</xsl:if>
							</input>							
						</xsl:if>
					</td>		
					<td >
						<xsl:variable name="relatedTable" select="related_table" />											
						<xsl:variable name="fieldType" select="field_type" />											
						<xsl:choose>									
							<xsl:when test="is_custom = 'N'">
								<xsl:value-of select = "$relatedTable"/>
							</xsl:when>
							<xsl:otherwise>
								<select name="related_table_{increment}" id="related_table_{increment}" style="width:95%" onchange="getRelated('{increment}');" >
									<xsl:for-each select = "/APPSHORE/APP/related_tables/related_tables_item[field_type = $fieldType]">
										<option value="{table_name}">
											<xsl:if test="table_name = $relatedTable">
												<xsl:attribute name="selected" value="true"/>
											</xsl:if>
											<xsl:value-of select="table_name"/>
										</option>						
									</xsl:for-each>
								</select>
							</xsl:otherwise>
						</xsl:choose>
					</td>
					<td >
						<xsl:variable name="relatedId" select="related_id" />
						<xsl:choose>									
							<xsl:when test="is_custom = 'N'">
								<xsl:value-of select = "$relatedId"/>
							</xsl:when>
							<xsl:otherwise>
								<select name="related_id_{increment}" id="related_id_{increment}" style="width:95%">
									<xsl:for-each select = "related_fields/related_fields_item">
										<option value="{field_id}">
											<xsl:if test="field_id = $relatedId">
												<xsl:attribute name="selected" value="true"/>
											</xsl:if>
											<xsl:value-of select="field_id"/>
										</option>
									</xsl:for-each>
								</select>
							</xsl:otherwise>
						</xsl:choose>
					</td>
					<td >
						<xsl:variable name="relatedName" select="related_name" />
						<xsl:choose>									
							<xsl:when test="is_custom = 'N'">
								<xsl:value-of select = "$relatedName"/>
							</xsl:when>
							<xsl:otherwise>
								<select name="related_name_{increment}" id="related_name_{increment}" style="width:95%">
									<xsl:for-each select = "related_fields/related_fields_item">
										<option value="{field_name}">
											<xsl:if test="field_name = $relatedName">
												<xsl:attribute name="selected" value="true"/>
											</xsl:if>
											<xsl:value-of select="field_name"/>
										</option>
									</xsl:for-each>
								</select>						
							</xsl:otherwise>
						</xsl:choose>
					</td>																											
				</tr>
			</xsl:for-each>	
		</table>

		<xsl:call-template name="formButtonsProperties">
    		<xsl:with-param name="thisForm" select="'fieldProperties'"/>
		</xsl:call-template>  	 		

		</form>		
	</div> 		

</xsl:template>


<xsl:template name="formButtonsProperties">
	<xsl:param name="thisForm"/>
	<table cellSpacing='1' cellPadding='1' border='0' width="100%">
		<tr align="left" style="height:2em">
		    <xsl:call-template name="checkAllListForm">
				<xsl:with-param name="thisForm" select="'fieldProperties'"/>				
			</xsl:call-template>	
			<td>																											
				<xsl:if test="/APPSHORE/APP/scope > 0 ">   					 		                                    
					<input type="button" class="formBarButton" id="Delete"  name="Delete" onclick="toBeDeleted(document.{$thisForm}, document.{$thisForm}.fields_selected);document.{$thisForm}.key.value='Delete';document.{$thisForm}.submit();">
			            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Delete')"/></xsl:attribute>
		 	        </input>&#160;
				</xsl:if>  				            
				<input type="submit" class="formBarButton" id="Save" name="Save" onclick="document.{$thisForm}.key.value='Save'">
 		            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
		        </input>&#160;
				<input type="reset" class="formBarButton" id="Cancel" name="Cancel" onclick="document.{$thisForm}s.key.value='Cancel'">
		        	<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
		        </input>
			</td>																											
		</tr>
	</table>
</xsl:template>


</xsl:stylesheet>
