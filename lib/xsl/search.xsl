<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="custom_search">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>	

	<script type="text/javascript" src="{$lib_js_path}/form.js"/>		

	<xsl:choose>
	    <xsl:when test = "$appLabel">
		    <div class="clearboth formTitle">
				<xsl:call-template name="customSearchHeader">
					<xsl:with-param name="appLabel" select="$appLabel"/>		
				</xsl:call-template>
			</div>
		</xsl:when>
		<xsl:otherwise>
			<div style="height:10px"/>
		</xsl:otherwise>
	</xsl:choose>
		
	<form name="custom_search" id="custom_search" method="post">
		<input type="hidden" name="op" id="op" value="{$appName}.base.search"/>
		<input type="hidden" name="key" id="key" />				

	    <div class="clearboth">
			<xsl:for-each select = "/APPSHORE/APP/search_fields/search_fields_item" >
			    <div class="searchfield">
					<xsl:call-template name="searchFields">
						<xsl:with-param name="thisForm" select="'custom_search'"/>
					</xsl:call-template>
				</div>
			</xsl:for-each>
	  		<!-- for IE -->
	    	<div style="clear:both"/>
	    </div>
	  
	    <div class="clearboth">
	        <xsl:call-template name="customSearchFooter">
				<xsl:with-param name="thisForm" select="'custom_search'"/>
			</xsl:call-template>&#160;
		    <xsl:if test = "/APPSHORE/API/savedSearches">
		        <xsl:call-template name="customSearch">
					<xsl:with-param name="thisForm" select="'custom_search'"/>	
	 		  		<xsl:with-param name="appName" select="$appName"/>
	 		  		<xsl:with-param name="appLabel" select="$appLabel"/>
				</xsl:call-template>
			</xsl:if>
		</div>
	</form>
	
</xsl:template>

<xsl:template name="custom_popup_search">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>	
		
	<script type="text/javascript" src="{$lib_js_path}/form.js"/>		

    <div class="clearboth formTitle">
		<xsl:call-template name="customSearchHeader">
			<xsl:with-param name="appLabel" select="$appLabel"/>		
		</xsl:call-template>
	</div>
	
	<form name="custom_popup_search" id="custom_popup_search" method="post">
		<input type="hidden" name="op" value="{$appName}.popup.search"/>
		<input type="hidden" name="key" />		
		<input type="hidden" name="is_multiple" value="{/APPSHORE/APP/recordset/is_multiple}"/>	

	    <div class="clearboth">
			<xsl:for-each select = "/APPSHORE/APP/popup_search_fields/popup_search_fields_item" >
			    <div class="searchfield">
					<xsl:call-template name="searchFields">
						<xsl:with-param name="thisForm" select="'custom_popup_search'"/>
					</xsl:call-template>
				</div>
			</xsl:for-each>
	  		<!-- for IE -->
	    	<div style="clear:both"/>
	    </div>
	  
	    <div class="clearboth">
	        <xsl:call-template name="customSearchFooter">
				<xsl:with-param name="thisForm" select="'custom_popup_search'"/>	
			</xsl:call-template>   
		</div>
	</form>
	
</xsl:template>


<xsl:template name="customSearch">
	<xsl:param name="thisForm"/>
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>

	<script type="text/javascript" src="{$lib_js_path}/searches.js?language={/APPSHORE/API/current_user/language_id}"/>		

	<script type="text/javascript" >
		var dropdownsearch = new Searches('<xsl:value-of select="$thisForm"/>','<xsl:value-of select="$appName"/>','<xsl:value-of select="$appLabel"/>');
	</script>	    

	<select class="fieldInputSelect" name="{$appName}_search_id" id="{$appName}_search_id" onChange="dropdownsearch.menuSelect(this);">
		<option selected="true" value="">					
			<xsl:value-of select="php:function('lang','Search filters')"/>
		</option>
		<option style="padding-left:1em" value="">					
			<xsl:value-of select="php:function('lang','Save the current search filter')"/>
		</option>
		<option style="padding-left:1em" value="">					
			<xsl:value-of select="php:function('lang','Manage search filters')"/>
		</option>
		<option disabled="disabled" style="padding-left:1em" value="">
			<xsl:value-of select="php:function('lang','Load a search filter')"/>
		</option>
	</select>	
    <img border="0">
		<xsl:attribute name="src"><xsl:value-of select="$api_image_path" />/invisible.gif</xsl:attribute>
        <xsl:attribute name="onLoad">dropdownsearch.getSearches($('<xsl:value-of select="$appName"/>_search_id'));</xsl:attribute>	            
	</img>				
</xsl:template>



<xsl:template name="searchFields">
	<xsl:param name="thisForm"/>
        <xsl:value-of select="php:functionString('lang',field_label)"/><br/>
		<xsl:choose>
		
		    <xsl:when test="field_type = 'CH'">
				<input name="{field_name}" id="{field_name}" type="hidden" value="{field_current_value}" />				
				<input class="fieldInputCheckbox" id="checkbox_{field_name}" name="checkbox_{field_name}" type="checkbox" value="{field_current_value}" onclick="boxchecked(this,document.{$thisForm}.{field_name});" >
					<xsl:if test="field_current_value = 'Y'">
						<xsl:attribute name="checked"/>
					</xsl:if>
				</input>					
		    </xsl:when>		
		    	    
		    <xsl:when test="field_type = 'CU' or field_type = 'CD'">
				<input class="fieldInputCurrency" id="{field_name}" name="{field_name}" type="text" value="{field_current_value}">					
			   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Use .. to search on range ..Number, Number.., Number1..Number2')"/></xsl:attribute>
			   	</input>       
		    </xsl:when>	
		    
		    <xsl:when test="field_type = 'DA' or field_type = 'TS'">
				<input autocomplete="off" class="fieldInputDate" id="{field_name}" name="{field_name}" type="text" value="{field_current_value}">
			   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Double click to display predefined periods')"/>. <xsl:value-of select="php:function('lang','Use .. to search on date range ..date, date.., date1..date2')"/></xsl:attribute>
			   	</input>       
				<div class="auto_complete" id="{field_name}_auto_complete" name="{field_name}_auto_complete"></div>	
				<script type="text/javascript">
					params = {
						parameters: 'sid=<xsl:value-of select="/APPSHORE/API/sid" />&amp;op=<xsl:value-of select="app_name" />.ajax.getPeriods',
						paramName: 'field_value', 
						minChars: 0
						};
					new Ajax.Autocompleter('<xsl:value-of select="field_name" />','<xsl:value-of select="field_name" />_auto_complete','raw.php', params);
				</script>	
				<xsl:call-template name="calendar">
					<xsl:with-param name="field"><xsl:value-of select="field_name"/></xsl:with-param>
					<xsl:with-param name="label"><xsl:value-of select="field_label"/></xsl:with-param>
				</xsl:call-template>
		    </xsl:when>		
		    	    			    
		    <xsl:when test="field_type = 'DD' or field_type = 'MV'">
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
 			    
		    <xsl:when test="field_type = 'DF'">
				<xsl:variable name="field_value" select="field_current_value"/>
				<select class="fieldInputSelect" id="folder_id" name="folder_id">
					<option value=""></option>
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
				<input autocomplete="off" class="fieldInputDateTime" id="{field_name}" name="{field_name}" type="text" value="{field_current_value}">
			   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Double click to display predefined periods')"/></xsl:attribute>
			   	</input>       
				<div class="auto_complete" id="{field_name}_auto_complete" name="{field_name}_auto_complete"></div>	
				<script type="text/javascript">
					params = {
						parameters: 'sid=<xsl:value-of select="/APPSHORE/API/sid" />&amp;op=<xsl:value-of select="app_name" />.ajax.getPeriods',
						paramName: 'field_value', 
						minChars: 0
						};
					new Ajax.Autocompleter('<xsl:value-of select="field_name" />','<xsl:value-of select="field_name" />_auto_complete','raw.php',params);
				</script>	
				<xsl:call-template name="calendar">
					<xsl:with-param name="field" select="field_name"/>
					<xsl:with-param name="label" select="field_label"/>
					<xsl:with-param name="time" select="'true'"/>
				</xsl:call-template>
		    </xsl:when>			    			    
		    	    
		    <xsl:when test="field_type = 'NU' or field_type = 'ND'">
				<input class="fieldInputNumeric" id="{field_name}" name="{field_name}" type="text" value="{field_current_value}">			
			   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Use .. to search on range ..Number, Number.., Number1..Number2')"/></xsl:attribute>
			   	</input>       
		    </xsl:when>	
		    	    
		    <xsl:when test="field_type = 'PE' or field_type = 'PD'">
				<input class="fieldInputPercentage" id="{field_name}" name="{field_name}" type="text" value="{field_current_value}">			
			   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Use .. to search on range ..Number, Number.., Number1..Number2')"/></xsl:attribute>
			   	</input>%
		    </xsl:when>	
		    
			<xsl:when test="field_type = 'RM'">
				<xsl:variable name="field_value_nbr" select="field_current_value_nbr"/>	
				<input id="{field_name}" name="{field_name}" type="hidden" value="{field_current_value}"/>
				<select id="i_{field_name}" name="i_{field_name}" onchange="$('{field_name}').value=this.value+'.'+$('s_{field_name}').value">
					<option/>
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
				<select id="s_{field_name}" name="s_{field_name}" onchange="$('{field_name}').value=$('i_{field_name}').value+'.'+this.value">
					<option/>
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
			
		    <xsl:otherwise>
				<xsl:choose>
				    <xsl:when test="string-length(related_name) > 0">
						<input autocomplete="off" class="fieldInputAutoComplete" id="related_{field_name}" name="related_{field_name}" type="text" value="{field_current_value}">
					   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Double click to display up to 10 items')"/></xsl:attribute>
					   	</input>       
						<div class="auto_complete" id="related_{field_name}_auto_complete" name="related_{field_name}_auto_complete"></div>	
						<script type="text/javascript">
							params = {
								parameters: 'sid=<xsl:value-of select="/APPSHORE/API/sid" />&amp;op=<xsl:value-of select="app_name" />.ajax.getRelatedRecords&amp;field_name=<xsl:value-of select="field_name" />',
								paramName: 'field_value', 
								minChars: 0
								};
							new Ajax.Autocompleter('related_<xsl:value-of select="field_name" />','related_<xsl:value-of select="field_name" />_auto_complete','raw.php',params);
						</script>					    
					</xsl:when>
					<xsl:otherwise>		    
						<input autocomplete="off" class="fieldInputAutoComplete" id="{field_name}" name="{field_name}" type="text" value="{field_current_value}">
					   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Double click to display up to 10 items')"/></xsl:attribute>
					   	</input>       
						<div class="auto_complete" id="{field_name}_auto_complete" name="{field_name}_auto_complete"></div>	
						<script type="text/javascript">
							params = {
								parameters: 'sid=<xsl:value-of select="/APPSHORE/API/sid" />&amp;op=<xsl:value-of select="app_name" />.ajax.getRecords&amp;field_name=<xsl:value-of select="field_name" />',
								paramName: 'field_value', 
								minChars: 0
								};
							new Ajax.Autocompleter('<xsl:value-of select="field_name" />','<xsl:value-of select="field_name" />_auto_complete','raw.php',params);
						</script>	
					</xsl:otherwise>
				</xsl:choose>				
	   	   </xsl:otherwise>
	   	   			    		    
		</xsl:choose>											
</xsl:template>

<xsl:template name="customSearchHeader">
	<xsl:param name="appLabel"/>	
    <xsl:value-of select="php:function('lang','Search')"/>&#160;<xsl:value-of select="php:functionString('lang',$appLabel)"/>
</xsl:template>

<xsl:template name="customSearchFooter">
	<xsl:param name="thisForm"/>
	<input type="submit" class="formBarButton" onclick="document.{$thisForm}.key.value='Search'">
   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Search according filter')"/></xsl:attribute>                    
        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Search')"/></xsl:attribute>
    </input>&#160;
    <xsl:if test = "/APPSHORE/API/savedSearches">
		<input type="button" class="formBarButton" onclick="document.{$thisForm}.key.value='Default';document.{$thisForm}.submit();">
	   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Reset to the default search filter')"/></xsl:attribute>                    
		    <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Reset')"/></xsl:attribute>
		</input>&#160;
	</xsl:if>
	<input type="button" class="formBarButton" onclick="document.{$thisForm}.key.value='Clear';document.{$thisForm}.submit();">
   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Clear filter')"/></xsl:attribute>                    
        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Clear')"/></xsl:attribute>
    </input>
</xsl:template>

</xsl:stylesheet>
