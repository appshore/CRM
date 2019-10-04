<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name='customization_dropdown'>	

	<script LANGUAGE="JavaScript" >
	<![CDATA[

	function resetIds( MyForm)
	{
		for (var i = 0; i < MyForm.elements.length ; i++)
			if (  MyForm.elements[i].type == 'checkbox' && MyForm.elements[i].checked == true && MyForm.elements[i].name != 'check_all')
			{
			for (var j = 0; j < MyForm.elements.length ; j++)
				if (  MyForm.elements[j].type == 'text' && MyForm.elements[j].name == 'name_'+MyForm.elements[i].value)
				{
					MyForm.elements[j].value = '';
				}
			}
	}
	]]>
	</script>	
	<form name='dropdown' method='post' >
		<input type='hidden' name='op' id="op" value='administration.customization_dropdown.edit'/>
		<input type="hidden" name="key" id="key" />
		<input type="hidden" name="selected" />

	<div class="formTitleTags start_float">
    	<xsl:value-of select="php:function('lang','Drop down lists')"/>
	</div>
	
	<div class="helpmsg">
		<xsl:value-of disable-output-escaping="yes" select="php:function('lang','administration.customization.dropdown.help')"/>
	</div>
	
	<div class="clearboth fieldLabelContainer" style="padding:0px 0 10px 0">
		<div class="fieldLabel start_float">
			<xsl:value-of select="php:function('lang','Select or create a drop down list')"/>
		</div>
		<div class="clearboth fieldText" >
			<select name="table_name" onchange='dropdown.submit();return true;'>
				<option/>				
				<xsl:for-each select = "dropdownlists/dropdownlists_item" >
					<option class="custom_is_custom_{is_custom}" value="{table_name}">
						<xsl:if test="table_name = /APPSHORE/APP/customization/table_name">
					         <xsl:attribute name="selected" value="true" />
					    </xsl:if>
						<xsl:value-of select="php:functionString('lang',table_label)"/>&#160;&#160;&#160;(<xsl:value-of select="table_name" />)
					</option>
				</xsl:for-each>	
			</select>
		</div>				
	</div>
	<div class="clearboth fieldLabelContainer" style="padding:10px 0 10px 0;width:100%">
		<div class="start_float" style="width:50%">
			<div class="fieldLabel start_float">
				<xsl:value-of select="php:function('lang','List name')"/>
			</div>
			<div class="clearboth fieldText" >
				<xsl:choose>
					<xsl:when test="string-length(customization/table_name)">
						<xsl:value-of select="customization/table_name" />
					</xsl:when>
					<xsl:otherwise>
						<input type="text" name="new_table_name" size="50"  value="{customization/table_name}" />
					</xsl:otherwise>
				</xsl:choose>					
			</div>				
		</div>
		<div class="end_float" style="width:50%">
			<div class="fieldLabel start_float">
				<xsl:value-of select="php:function('lang','List label')"/>
			</div>
			<div class="clearboth fieldText" >
				<input type="text" size="50" name="table_label" value="{customization/table_label}" />
			</div>				
		</div>
	</div>

	<xsl:if test = "dropdown/dropdown_item" >		
		<xsl:if test="customization/is_custom = 'N'">  
			<div class="clearboth fieldLabelContainer" style="padding:10px 0 10px 0">
				<div class="fieldLabel start_float">
					<xsl:value-of select="php:function('lang','Comment')"/>
				</div>
				<div class="clearboth fieldText" >
					<xsl:value-of select="/APPSHORE/APP/customization/lookup_comment" />
				</div>				
			</div>
		</xsl:if>	
	</xsl:if>	
	
	<xsl:call-template name="dropdownButtons">
			<xsl:with-param name="thisForm">dropdown</xsl:with-param>
			<xsl:with-param name="isTop">true</xsl:with-param>
	</xsl:call-template> 		
	
	<xsl:if test = "dropdown/dropdown_item" >		
		<table cellSpacing="1" cellPadding="1" border="0" width="100%" >
			<tr align="center">
			    <xsl:call-template name="checkAllListForm">
					<xsl:with-param name="thisForm">dropdown</xsl:with-param>				
				</xsl:call-template>				
				<td class="mandatory_label">
					<xsl:value-of select="php:function('lang','Identifier')"/>
				</td>
				<td class="mandatory_label">
					<xsl:value-of select="php:function('lang','Label')"/>
				</td>				
				<xsl:if test = "dropdown/dropdown_item/lookup_value" >		
					<td class="mandatory_label">
						<xsl:value-of select="php:function('lang','Value')"/>
					</td>
				</xsl:if>		
			</tr> 
			<xsl:for-each select = "dropdown/dropdown_item" >		
				<tr class="field" >
				    <xsl:call-template name="checkListForm">
						<xsl:with-param name="thisForm">dropdown</xsl:with-param>
						<xsl:with-param name="thisId"><xsl:value-of select="increment"/></xsl:with-param>					
						<xsl:with-param name="scope"><xsl:value-of select="scope"/></xsl:with-param>					
					</xsl:call-template>			
					<td style="width:15em" >
						<input type="text" style="width:100%" >		
				        	<xsl:attribute name="name">id_<xsl:value-of select="increment" /></xsl:attribute>					
				        	<xsl:attribute name="value"><xsl:value-of select="lookup_id" /></xsl:attribute>
				        </input>
					</td>
					<td style="width:*" >		
						<input type="text" style="width:100%" >
				        	<xsl:attribute name="name">name_<xsl:value-of select="increment" /></xsl:attribute>					
				        	<xsl:attribute name="value"><xsl:value-of select="lookup_name" /></xsl:attribute>
				        </input>
					</td>				
					<xsl:if test = "lookup_value" >		
						<td style="width:*" >		
							<input type="text" style="width:100%" >
					        	<xsl:attribute name="name">value_<xsl:value-of select="increment" /></xsl:attribute>					
					        	<xsl:attribute name="value"><xsl:value-of select="lookup_value" /></xsl:attribute>
					        </input>
						</td>				
					</xsl:if>		
				</tr>
			</xsl:for-each>	
		</table>	
		<table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
			    <xsl:call-template name="checkAllListForm">
					<xsl:with-param name="thisForm">dropdown</xsl:with-param>
				</xsl:call-template> 
				<td>				 		                                    
					<input type="submit" class="formBarButton" name="Delete" onclick="resetIds(document.dropdown);document.dropdown.key.value='Save'">
			            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Delete records')"/></xsl:attribute>
			            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Delete records')"/></xsl:attribute>
			        </input>
				</td>
			</tr>
		</table>	        	

		<xsl:call-template name="dropdownButtons">
				<xsl:with-param name="thisForm">dropdown</xsl:with-param>
		</xsl:call-template> 		
					
	</xsl:if>   	
		
	</form>	
</xsl:template>


<xsl:template name="dropdownButtons">	
	<xsl:param name="thisForm"/>
	<xsl:param name="isTop"/>

	<xsl:if test="/APPSHORE/APP/scope > 0">  
		<div class="clearboth">
			<input type="submit" class="formBarButton" name="New" onclick="reset();document.{$thisForm}.key.value=this.name">
	            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','New list')"/></xsl:attribute>
	            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','New')"/></xsl:attribute>
	        </input>&#160;
			<input type="submit" class="formBarButton" name="Save" onclick="document.{$thisForm}.key.value=this.name">
	            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Save list')"/></xsl:attribute>
	            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
	        </input>&#160;
			<xsl:if test="customization/is_custom = 'Y'">  
				<input type="submit" class="formBarButton" name="Delete" onclick="document.{$thisForm}.key.value='Delete'">
	            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Delete list')"/></xsl:attribute>
	            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Delete')"/></xsl:attribute>
		        </input>&#160;
		    </xsl:if>
			<xsl:if test="customization/is_custom = 'N'">  
				<input type="submit" class="formBarButton" name="Restore" onclick="document.{$thisForm}.key.value=this.name">
	            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Restore list')"/></xsl:attribute>
	            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Restore')"/></xsl:attribute>
		        </input>
		    </xsl:if>
		</div>	        	
	</xsl:if>  	
</xsl:template>

</xsl:stylesheet>
