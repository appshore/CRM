<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name='customization_linked'>
	<xsl:param name="thisForm"/>
	<xsl:param name="appName"/>

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
	</xsl:call-template>  

	<br/>	
	<xsl:call-template name="headerCustomizationForm">
		<xsl:with-param name="appLabel">Applications available</xsl:with-param>
	</xsl:call-template>			
	
	<div id="available" style="width:99%;min-height:5em">
		<xsl:for-each select = "available_apps/available_apps_item">
			<xsl:call-template name="fieldBox"/>
		</xsl:for-each>
	</div>			
	
	<br/>	
	<xsl:call-template name="headerCustomizationForm">
		<xsl:with-param name="appLabel">Applications linked</xsl:with-param>
	</xsl:call-template>		
	
	<div class="fieldDesignBlock" style="min-height:5em;overflow:auto;text-align:left">
		<div id="used" class="start_float used" style="min-height:5em;padding-bottom:10px;width:99.5%">
			<xsl:for-each select = "used_apps/used_apps_item" >
				<xsl:call-template name="fieldBox"/>
			</xsl:for-each>
		</div>	
	</div>	

	<xsl:call-template name="formButtons">
		<xsl:with-param name="thisForm" select="$thisForm"/>
		<xsl:with-param name="appName" select="$appName"/>
	</xsl:call-template>

	
	<script type="text/javascript">		
		Sortable.create('available',{tag:'div',containment:['available','used'],overlap:'vertical',dropOnEmpty:true,constraint:false});					
		Sortable.create('used',{tag:'div',containment:['available','used'],overlap:'vertical',dropOnEmpty:true,constraint:false});
	</script>	
						
</xsl:template>


<xsl:template name="fieldBox">
	<div id="{linked_table_name}.{linked_record_name}" class="custom_box_dotted" style="clear:both;width:100%;cursor:move" title="{linked_app_label}">
		<br/>
		<xsl:value-of select="php:functionString('lang',linked_app_label)"/>
		<table style="width:100%;height:2em;line-height:1em">
			<tr class="searchResultsHeader searchResultsCells">
				<td style="width:2%">&#160;</td>
				<td style="width:2%">&#160;</td>
				<td style="width:2%">&#160;</td>
				<td style="width:20%">&#160;</td>
				<td >&#160;</td>
				<td style="width:15%">&#160;</td>
				<td style="width:25%">&#160;</td>
				<td style="width:15%">&#160;</td>
			</tr>
			<tr class="searchResultsCells">
				<td ><input type="checkbox"/></td>
				<td ><img class="image" src="{$api_image_path}/edit.png"/></td>
				<td ><img class="image" src="{$api_image_path}/view.png"/></td>
				<td >&#160;</td>									
				<td >&#160;</td>																					
				<td >&#160;</td>
				<td >&#160;</td>
				<td >&#160;</td>
			</tr>
		</table>
	</div>
</xsl:template>

</xsl:stylesheet>
