<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP">
    <table width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
			<td class="left_panel" id="left_panel" style="display:{/APPSHORE/API/cookie/left_panel}">
			    <xsl:call-template name="verticalMenus">		    
					<xsl:with-param name="appName">administration</xsl:with-param>
					<xsl:with-param name="appLabel">Administration</xsl:with-param>
				</xsl:call-template>	
			</td>
            <td id="right_panel" class="right_panel">
				<xsl:call-template name="headerCustomizationForm">
					<xsl:with-param name="appLabel">Applications</xsl:with-param>
					</xsl:call-template>
 	    		<xsl:call-template name="select_application_form"/>	
				<xsl:choose>
				<!--
					<xsl:when test="action/customization = 'properties'">
				    	<xsl:call-template name="customization_properties"/>
					</xsl:when>	
				-->	
					<xsl:when test="action/customization = 'fields'">
				    	<xsl:call-template name="customization_fields"/>
					</xsl:when>		

					<xsl:when test="action/customization = 'bulk'">
				    	<xsl:call-template name="customization_view_edit_bulk">
							<xsl:with-param name="thisForm">bulk</xsl:with-param>
							<xsl:with-param name="appName" select="/APPSHORE/APP/customization/app_name"/>
							<xsl:with-param name="copyFrom">Copy from the template Edit form</xsl:with-param>
						</xsl:call-template>   		
					</xsl:when>

					<xsl:when test="action/customization = 'edit'">
				    	<xsl:call-template name="customization_view_edit_bulk">
							<xsl:with-param name="thisForm">edit</xsl:with-param>
							<xsl:with-param name="appName" select="/APPSHORE/APP/customization/app_name"/>
							<xsl:with-param name="copyFrom">Copy from the template View form</xsl:with-param>
						</xsl:call-template>   		
					</xsl:when>	
					<xsl:when test="action/customization = 'popup_edit'">
				    	<xsl:call-template name="customization_view_edit_bulk">
							<xsl:with-param name="thisForm">popup_edit</xsl:with-param>
							<xsl:with-param name="appName" select="/APPSHORE/APP/customization/app_name"/>
							<xsl:with-param name="copyFrom">Copy from the template Edit form</xsl:with-param>
						</xsl:call-template>   		
					</xsl:when>	

					<xsl:when test="action/customization = 'view'">
				    	<xsl:call-template name="customization_view_edit_bulk">
							<xsl:with-param name="thisForm">view</xsl:with-param>
							<xsl:with-param name="appName" select="/APPSHORE/APP/customization/app_name"/>
							<xsl:with-param name="copyFrom">Copy from the template Edit form</xsl:with-param>
						</xsl:call-template>   		
					</xsl:when>						
					<xsl:when test="action/customization = 'popup_view'">
				    	<xsl:call-template name="customization_view_edit_bulk">
							<xsl:with-param name="thisForm">popup_view</xsl:with-param>
							<xsl:with-param name="appName" select="/APPSHORE/APP/customization/app_name"/>
							<xsl:with-param name="copyFrom">Copy from the template View form</xsl:with-param>
						</xsl:call-template>   		
					</xsl:when>	

					<xsl:when test="action/customization = 'searches'">
				    	<xsl:call-template name="customization_searches">
							<xsl:with-param name="thisForm">searches</xsl:with-param>
							<xsl:with-param name="appName" select="/APPSHORE/APP/customization/app_name"/>
							<xsl:with-param name="copyFrom">Copy from the template Popup search filters</xsl:with-param>
						</xsl:call-template>   		
					</xsl:when>			
					<xsl:when test="action/customization = 'popup_searches'">
				    	<xsl:call-template name="customization_searches">
							<xsl:with-param name="thisForm">popup_searches</xsl:with-param>
							<xsl:with-param name="appName" select="/APPSHORE/APP/customization/app_name"/>
							<xsl:with-param name="copyFrom">Copy from the template Search filters</xsl:with-param>
						</xsl:call-template>   		
					</xsl:when>			

					<xsl:when test="action/customization = 'results'">
				    	<xsl:call-template name="customization_results">
							<xsl:with-param name="thisForm">results</xsl:with-param>
							<xsl:with-param name="appName" select="/APPSHORE/APP/customization/app_name"/>
							<xsl:with-param name="copyFrom">Copy from the template Popup search results</xsl:with-param>
						</xsl:call-template>   		
					</xsl:when>	
					<xsl:when test="action/customization = 'popup_results'">
				    	<xsl:call-template name="customization_results">
							<xsl:with-param name="thisForm">popup_results</xsl:with-param>
							<xsl:with-param name="appName" select="/APPSHORE/APP/customization/app_name"/>
							<xsl:with-param name="copyFrom">Copy from the template Search results</xsl:with-param>
						</xsl:call-template>   		
					</xsl:when>	

					<xsl:when test="action/customization = 'linked'">
				    	<xsl:call-template name="customization_linked">
							<xsl:with-param name="thisForm">linked</xsl:with-param>
							<xsl:with-param name="appName" select="/APPSHORE/APP/customization/app_name"/>
						</xsl:call-template>   		
					</xsl:when>						
					<xsl:when test="action/customization = 'linked_view'">
				    	<xsl:call-template name="customization_results">
							<xsl:with-param name="thisForm">linked_view</xsl:with-param>
							<xsl:with-param name="appName" select="/APPSHORE/APP/customization/app_name"/>
							<xsl:with-param name="copyFrom">Copy from the template Search results</xsl:with-param>
						</xsl:call-template>   		
					</xsl:when>						

				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name="select_application_form">
	<form method='post' name='selectAppOp'>
	<input type='hidden' name='op' value='{/APPSHORE/API/op/opname}'/>
	
   	<div style="clear:both;height:4em">
		<div class="start_float" style="padding-right:10px">
			<xsl:value-of select="php:function('lang','Application')"/><br/>
			<select name="app_name" onchange="submit();return true;">
				<xsl:for-each select = "/APPSHORE/APP/applications/applications_item" >
	                <option value="{app_name}">
						<xsl:if test="app_name = /APPSHORE/APP/customization/app_name">
							<xsl:attribute name="selected" value="true"/>
						</xsl:if>
						<xsl:value-of select="php:functionString('lang',app_label)"/>										
					</option>
				</xsl:for-each>	
			</select>
		</div>	
		
		<div class="start_float">
			<xsl:value-of select="php:function('lang','Form')"/><br/>
			<select name="tab_id" onchange="document.selectAppOp.op.value='administration.customization_'+this.value+'.edit';submit();return true;">
				<xsl:for-each select = "/APPSHORE/APP/tabs/tabs_item" >
	                <option value="{tab_id}">
						<xsl:if test="tab_id = /APPSHORE/APP/customization/tab_id">
							<xsl:attribute name="selected" value="true"/>
						</xsl:if>
						<xsl:value-of select="php:functionString('lang',tab_name)"/>
					</option>
				</xsl:for-each>	
			</select>
		</div>	
		
	</div>
	</form>						 	 							
</xsl:template>


<xsl:template name="customizationAjax">
	<script language="JavaScript" type="text/javascript" src="administration/js/customization.js"/>			
</xsl:template>

<xsl:template name='customization_view_edit_bulk'>
	<xsl:param name="thisForm"/>
	<xsl:param name="appName"/>
	<xsl:param name="copyFrom"/>

	<xsl:call-template name="customizationAjax"/>  	 		

		
	<div class="helpmsg">
		<xsl:value-of disable-output-escaping="yes" select="php:function('lang','administration.customization.help.drag')"/>
		<br/>
		<xsl:value-of select="php:function('lang','Deleting a block will set associated fields as available.')"/>
	</div>
		
	<form id='{$thisForm}' method='post'>
		<input type='hidden' id="op" name="op" value='administration.customization_{$thisForm}.edit'/>	
		<input type='hidden' id="app_name" name="app_name" value='{$appName}'/>	
	</form>
		
	<div style="width:65%" >
		<xsl:call-template name="blockForm">  	 
			<xsl:with-param name="thisForm" select="$thisForm"/>
			<xsl:with-param name="appName" select="$appName"/>
		</xsl:call-template>  
	</div>

	<div style="padding-top:10px">
		<div class="start_float" style="width:65%;margin-right:20px" >
			<div class="formTitleTags">
				<xsl:value-of select="php:function('lang','Form layout')"/>
			</div>	
			<xsl:call-template name="formButtons">  	 		
				<xsl:with-param name="thisForm" select="$thisForm"/>
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="copyFrom" select="$copyFrom"/>
			</xsl:call-template>  
			<xsl:call-template name="bodyCustomizationForm">
				<xsl:with-param name="thisForm" select="$thisForm"/>
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="appLabel" select="'Form layout'"/>
			</xsl:call-template>  
			<xsl:call-template name="formButtons">  	 		
				<xsl:with-param name="thisForm" select="$thisForm"/>
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="copyFrom" select="$copyFrom"/>
			</xsl:call-template>  
		</div>
			
		<div  class="end_float" style="margin-right:1em;width:30%">
			<div class="formTitleTags">
				<xsl:value-of select="php:function('lang','Fields available')"/>
			</div>
			<div id="available" class="blocks" style="padding-top:10px;overflow-x:hidden;">
				<xsl:for-each select = "available_fields/available_fields_item">
					<xsl:call-template name="fieldBox"/>				
				</xsl:for-each>
			</div>		
		</div>	
	</div>	
			
	<script language="JavaScript" type="text/javascript">		
	
		// to drag and drop the fields
		Sortable.create('available',{tag:'div',dropOnEmpty:true,constraint:false,containment:$$('.blocks'),only:'fieldContainer'});
		<xsl:for-each select = "blocks/blocks_item" >
			<xsl:variable name="blockId" select="block_id"/>
			Sortable.create('lside_<xsl:value-of select="block_id" />',{tag:'div',dropOnEmpty:true,constraint:false,containment:$$('.blocks'),only:'fieldContainer',onUpdate:function(elt){resizeBlock(elt);}});
		    <xsl:if test="columns = '2'">
				Sortable.create('rside_<xsl:value-of select="block_id" />',{tag:'div',dropOnEmpty:true,constraint:false,containment:$$('.blocks'),only:'fieldContainer',onUpdate:function(elt){resizeBlock(elt);}});
			</xsl:if>
		</xsl:for-each>

		// to Drag and Drop the blocks
		Sortable.create('layout',{tag:'fieldset',dropOnEmpty:true,containment:'layout',only:'fieldDesignBlock'});

		$('available').setStyle({
//			height: (document.body.scrollHeight-$('available').cumulativeOffset().top)+'px'
			height: (window.innerHeight-50)+'px'
			});
		$$('.used').each( function(elt){resizeBlock(elt);});
			
	</script>
	

</xsl:template>


<xsl:template name='customization_results'>
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

	<xsl:call-template name="headerCustomizationForm">
		<xsl:with-param name="appLabel" select="'Fields available'"/>
	</xsl:call-template>			

	<div id="available" style="width:100%;min-height:6em">
		<xsl:for-each select = "available_fields/available_fields_item">
			<xsl:call-template name="fieldBoxResults"/>
		</xsl:for-each>
	</div>			

	<xsl:call-template name="headerCustomizationForm">
		<xsl:with-param name="appLabel" select="'Results grid'"/>
	</xsl:call-template>		

	<table style="width:100%" border="0" cellspacing="0" cellpadding="0">
		<tr style="line-height:2em;vertical-align:top;width:100%">
			<td style="text-align:center;width:25px">
				<div class="custom_box" style="padding:3px 1px 2px 1px">
					<div class="searchResultsHeader">&#160;&#160;</div>
					<div class="searchResultsIcons"><input type="checkbox"/></div>
				</div>
			</td>
			<td style="text-align:center;width:25px">
				<div class="custom_box" style="padding:3px 1px 2px 1px">
					<div class="searchResultsHeader">C</div>
					<div class="searchResultsIcons"><img class="image" src="{$api_image_path}/edit.png"/></div>
				</div>
			</td>
			<td style="text-align:center;width:25px">
				<div class="custom_box" style="padding:3px 1px 2px 1px">
					<div class="searchResultsHeader">U</div>
					<div class="searchResultsIcons"><img class="image" src="{$api_image_path}/view.png"/></div>
				</div>
			</td>
			<td width="*">
				<div id="used" class="fieldDesignBlock used" style="width:99%;overflow:auto;text-align:left">
					<xsl:for-each select = "used_fields/used_fields_item" >
						<xsl:call-template name="fieldBoxResults"/>
					</xsl:for-each>
				</div>
			</td>
		</tr>
	</table>

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

<xsl:template name="fieldBoxResults">
	<div id="{field_name}" class="custom_box_dotted" style="cursor:move;width:100px;line-height:2em" title="{field_label}">
		<div class="searchResultsHeader searchResultsCellsDesign">
			<xsl:value-of select="field_label"/>
		</div>
		<div class="searchResultsCellsDesign">
			<xsl:choose>
			    <xsl:when test="field_type = 'CH'">
					&#160;<img class="image" src="{$api_image_path}/checked.gif"/>&#160;																												
			    </xsl:when>								    					    
			    <xsl:when test="field_type = 'CU'">
					<xsl:value-of select="/APPSHORE/API/current_user/currency_id" />&#160;<xsl:value-of select="field_label"/>																									
			    </xsl:when>								    					    
			    <xsl:when test="field_type = 'RR'">
					<a href="javascript:;;"><xsl:value-of select="field_label"/></a>																									           
			    </xsl:when>	
			    <xsl:when test="field_type = 'VF'">
					<a href="javascript:;;"><xsl:value-of select="field_label"/></a>																									           
			    </xsl:when>		
			    <xsl:when test="field_type = 'WM'">
					<a href="javascript:;;"><xsl:value-of select="field_label"/></a>																									           
			    </xsl:when>				    	
			    <xsl:otherwise>
					<xsl:value-of select="field_label"/>																									
		   	   </xsl:otherwise>			    		    
			</xsl:choose>
		</div>		
	</div>
</xsl:template>


<xsl:template name="headerCustomizationForm">
	<xsl:param name="appLabel"/>	

    <div class="clearboth formTitle">
		<xsl:value-of select="php:functionString('lang',$appLabel)"/>
	</div>
	
</xsl:template>


<xsl:template name="bodyCustomizationForm">
	<xsl:param name="thisForm"/>	
	<xsl:param name="appName"/>	
	<xsl:param name="appLabel"/>	
	
	<div id="layout" class="clearboth" style="width:100%" >
		<xsl:for-each select = "blocks/blocks_item" >
			<xsl:variable name="blockId" select="block_id"/>
			<fieldset class="fieldDesignBlock" id="block_{block_id}" valign="top">
				<legend>
					<span class="custom_is_title_{is_title}"><xsl:value-of select="block_name" /></span>
				</legend>
				<xsl:choose>
				    <xsl:when test="columns = '1'">
						<div id="lside_{block_id}" class="blocks used">
							<xsl:for-each select = "/APPSHORE/APP/lside_fields/lside_fields_item[current_block_id = $blockId]" >
								<xsl:call-template name="fieldBox"/>				
							</xsl:for-each>
						</div>
				    </xsl:when>
				    <xsl:otherwise>
						<div class="start_float" style="padding:5px;width:48%">
							<div id="lside_{block_id}" class="blocks used">
								<xsl:for-each select = "/APPSHORE/APP/lside_fields/lside_fields_item[current_block_id = $blockId]" >
									<xsl:call-template name="fieldBox"/>				
								</xsl:for-each>
							</div>
						</div>
						<div class="start_float" style="padding:5px;width:48%">
							<div id="rside_{block_id}" class="blocks used">
								<xsl:for-each select = "/APPSHORE/APP/rside_fields/rside_fields_item[current_block_id = $blockId]" >
									<xsl:call-template name="fieldBox"/>				
								</xsl:for-each>
							</div>
						</div>
					</xsl:otherwise>
				</xsl:choose>
			</fieldset>
		</xsl:for-each>
	</div>
</xsl:template>

<xsl:template name="formButtons">
	<xsl:param name="thisForm"/>
	<xsl:param name="appName"/>
	<xsl:param name="copyFrom"/>

	<div class="clearboth" style="padding:5px 0 5px 0">
		<input type="button" class="formBarButton" name="Save" onclick="saveForm('{$thisForm}','{$appName}');">
            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
        </input>&#160;
        <xsl:if test="not($copyFrom = '')">
			<input type="button" class="formBarButton" name="Copy" onclick="copyForm('{$thisForm}','{$appName}');">
	            <xsl:attribute name="value"><xsl:value-of select="php:functionString('lang',$copyFrom)"/></xsl:attribute>
	            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Copy from another template')"/></xsl:attribute>	            
	        </input>&#160;
	    </xsl:if>
		<input type="button" class="formBarButton" name="Restore" onclick="restoreForm('{$thisForm}','{$appName}');">
            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Restore')"/></xsl:attribute>
            <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Restore default layout')"/></xsl:attribute>	            
        </input>	        	
	</div>  
		 		
</xsl:template>

<xsl:template name="blockForm">
	<xsl:param name="thisForm"/>	
	<xsl:param name="appName"/>
	
	<div class="formTitleTags start_float">
    	<xsl:value-of select="php:function('lang','Blocks')"/>
	</div>
	
	<div class="clearboth fieldLabelContainer">
		<div class="start_float" style="width:50%">
			<div class="fieldLabel start_float">
				<xsl:value-of select="php:function('lang','Select or create a block')"/>
			</div>
			<div class="clearboth fieldText" >
				<select name="block_id" id="block_id" style="min-width:10em" onChange="getBlock('{$thisForm}','{$appName}');">
					<option/>				
					<xsl:for-each select = "blocks/blocks_item" >
						<option value="{block_id}">
							<xsl:if test="block_id = /APPSHORE/APP/block/block_id">
						         <xsl:attribute name="selected" value="true"/>
						    </xsl:if>
					         <xsl:value-of select="block_name" />
						</option>
					</xsl:for-each>	
				</select>
			</div>
		</div>
		<div class="end_float" style="width:50%">
			<div class="fieldLabel start_float">
				<xsl:value-of select="php:function('lang','Name')"/>
			</div>
			<div class="clearboth fieldText" >
				<input type="text" size="20" name="block_name" id="block_name" value="{block/block_name}" />
			</div>				
		</div>
	</div>
	
	<div class="clearboth fieldLabelContainer" style="padding:10px 0 0 0">
		<div class="start_float" style="width:50%">
			<div class="fieldLabel start_float">
				<xsl:value-of select="php:function('lang','Name is title')"/>
			</div>
			<div class="clearboth fieldText" >
				<input name="is_title" id="is_title" type="checkbox" value="{block/is_title}" onclick="boxchecked($('is_title'),$('is_title'));" >
					<xsl:if test="block/is_title = 'Y'">
						<xsl:attribute name="checked"/>
					</xsl:if>
				</input>									
			</div>				
		</div>
		<div class="end_float" style="width:50%">
			<div class="fieldLabel start_float">
				<xsl:value-of select="php:function('lang','Columns')"/>
			</div>
			<div class="clearboth fieldText" >
				<xsl:value-of select="php:function('lang','One')"/>
				<input type='radio' name='columns' id='columns1' value='1'>
					<xsl:if test="block/columns = '1'"><xsl:attribute name="checked"/></xsl:if>
		    	</input>
				&#160;<xsl:value-of select="php:function('lang','Two')"/>
				<input type='radio' name='columns' id='columns2' value='2'>
					<xsl:if test="block/columns = '2'"><xsl:attribute name="checked"/></xsl:if>
				</input>
			</div>				
		</div>
	</div>	
	 
	<div class="clearboth">
		<input type="button" class="formBarButton" name="New" onClick="newBlock();">
            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','New block')"/></xsl:attribute>
        </input>&#160;
		<input type="button" class="formBarButton" name="Save" onClick="saveBlock('{$thisForm}','{$appName}');">
            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save block')"/></xsl:attribute>
        </input>&#160;
        <input type="button" class="formBarButton" name="Delete" onClick="deleteBlock('{$thisForm}','{$appName}');">
            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Delete block')"/></xsl:attribute>
        </input>	
 	</div> 	
 	 		 		
</xsl:template>

</xsl:stylesheet>
