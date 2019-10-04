<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name='customization_searches'>
	<xsl:param name="thisForm"/>
	<xsl:param name="appName"/>
	<xsl:param name="copyFrom"/>

	<xsl:call-template name="customizationAjax"/>
		
	<div class="helpmsg">
		<xsl:value-of disable-output-escaping="yes" select="php:function('lang','administration.customization.help.drag')"/>
	</div>

	<form id='{$thisForm}' method='post'>
		<input type='hidden' id="op" name="op" value='administration.customization_{$thisForm}.edit'/>	
		<input type='hidden' id="app_name" name="app_name" value='{$appName}'/>	
	</form>

	<xsl:call-template name="formButtons">
		<xsl:with-param name="thisForm" select="$thisForm"/>
		<xsl:with-param name="appName" select="$appName"/>
		<xsl:with-param name="copyFrom" select="$copyFrom"/>
	</xsl:call-template>
	
	<br/>
	<xsl:call-template name="headerCustomizationForm">
		<xsl:with-param name="appLabel">Fields available</xsl:with-param>
	</xsl:call-template>
	
	<div id="available" style="width:100%;min-height:6em">
		<xsl:for-each select = "available_fields/available_fields_item">
			<xsl:call-template name="fieldBoxSearch"/>
		</xsl:for-each>
	</div>
	
	<br/>
	<xsl:call-template name="headerCustomizationForm">
		<xsl:with-param name="appLabel">Search filters</xsl:with-param>
	</xsl:call-template>
		
	<div id="used" class="fieldDesignBlock used" style="width:99%;min-height:3.5em;overflow:auto;text-align:left">
		<xsl:for-each select = "used_fields/used_fields_item" >
			<xsl:call-template name="fieldBoxSearch"/>
		</xsl:for-each>
	</div>

	<br/>
	<xsl:call-template name="formButtons">
		<xsl:with-param name="thisForm" select="$thisForm"/>
		<xsl:with-param name="appName" select="$appName"/>
		<xsl:with-param name="copyFrom" select="$copyFrom"/>
	</xsl:call-template>

	<script language="JavaScript" type="text/javascript">
		Sortable.create('available',{tag:'div',containment:['available','used'],overlap:'horizontal',dropOnEmpty:true,constraint:false});
		Sortable.create('used',{tag:'div',containment:['available','used'],overlap:'horizontal',dropOnEmpty:true,constraint:false});
	</script>

</xsl:template>

<xsl:template name="fieldBoxSearch">
	<div id="{field_name}" style="height:40px" class="custom_box_dotted custom_is_custom_{is_custom}" title="{field_label}">
		<div >
			<div style="overflow:hidden"><xsl:value-of select="field_label"/></div>
			<xsl:choose>
			
			    <xsl:when test="field_type = 'CH'">
					<input type="checkbox" />
			    </xsl:when>
			    
		    	<xsl:when test="field_type = 'CU'">
					<input type="text" size="10" />
		    	</xsl:when>
			    
		    	<xsl:when test="field_type = 'PE'">
					<input class="fieldInputPercentage" type="text"/>%
		    	</xsl:when>
		    			    	
		    	<xsl:when test="field_type = 'DA' or field_type = 'DT'">
		    		<input type="text" size="10" />&#160;
					<img class="image" src="{$api_image_path}/cal.gif"/>
		    	</xsl:when>
		    	
			    <xsl:when test="field_type = 'DD'">
					<select>
						<option/>
						<option><xsl:value-of select="field_label" /></option>
						<option><xsl:value-of select="field_label" /></option>
						<option><xsl:value-of select="field_label" /></option>
						<option><xsl:value-of select="field_label" /></option>
					</select>
			    </xsl:when>
			
				<xsl:when test="field_type = 'RD'">
					<select>
						<option/>
						<option>0</option>
						<option>1</option>
						<option>2</option>
						<option>3</option>
						<option>4</option>
						<option>5</option>
						<option>6</option>
					</select>&#160;
					<select>
						<option/>
						<option><xsl:value-of select="php:function('lang','days')"/></option>
						<option><xsl:value-of select="php:function('lang','weeks')"/></option>
					</select>
				</xsl:when>
				
				<xsl:when test="field_type = 'RM'">
					<select>
						<option/>
						<option>1</option>
						<option>2</option>
						<option>3</option>
						<option>4</option>
						<option>5</option>
						<option>10</option>
						<option>15</option>
						<option>20</option>
						<option>30</option>
						<option>45</option>
					</select>&#160;
					<select>
						<option/>
						<option><xsl:value-of select="php:function('lang','minutes')"/></option>
						<option><xsl:value-of select="php:function('lang','hours')"/></option>
						<option><xsl:value-of select="php:function('lang','days')"/></option>
						<option><xsl:value-of select="php:function('lang','weeks')"/></option>
					</select>
				</xsl:when>			    
			    
			    <xsl:otherwise>
					<input type="text" style="width:10em"/>	
		   	   </xsl:otherwise>
		   	   
			</xsl:choose>
		</div>
	</div>
</xsl:template>

</xsl:stylesheet>
