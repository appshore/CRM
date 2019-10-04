<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>
			
<xsl:template match="APP[action/node()[name() = /APPSHORE/APP/recordset/appName]]">
    <table width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
		    <xsl:call-template name="leftPanel"/>
            <td id="right_panel" class="right_panel">
				<xsl:choose>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'convert'">
						<xsl:call-template name='lead_convert_help'/>
				    	<xsl:call-template name="lead_convert">
				    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
				    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabelSingular"/>
				    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appNameSingular"/>
				    		<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>	
				    		<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>					    		
				    	</xsl:call-template>				    					    	
					</xsl:when>					
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'capture'">
				    	<xsl:call-template name="capture"/>
					</xsl:when>					
					<xsl:otherwise>
				    	<xsl:call-template name="custom_actions"/>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name='lead_convert_help'>
	<br/>
	<div class="helpmsg">
		<xsl:value-of disable-output-escaping="yes" select="php:functionString('lang','leads.convert.help')"/>
	</div>	
</xsl:template>

<xsl:template match="/APPSHORE/API/Plugins" mode="ViewButtons">
	<xsl:param name="thisForm"/>
	<xsl:param name="nodeName"/>
	<xsl:param name="appName"/>
	<xsl:param name="recordId"/>	
	<xsl:param name="recordIdValue"/>	
	<xsl:call-template name="convertButton">
		<xsl:with-param name="appName" select="$appName"/>
		<xsl:with-param name="thisForm" select="$thisForm"/>		
	</xsl:call-template>
</xsl:template>

<xsl:template match="/APPSHORE/API/Plugins" mode="EditButtons">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	
	<xsl:call-template name="convertButton">
		<xsl:with-param name="appName" select="$appName"/>
		<xsl:with-param name="thisForm" select="$thisForm"/>	
	</xsl:call-template>
</xsl:template>

<xsl:template name="convertButton">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	
	<input type="submit" class="formBarButton" name="Convert" id="Convert" onclick="document.{$thisForm}.key.value=this.name">
        <xsl:attribute name="title"><xsl:value-of select="php:function('lang','Convert the lead into an account and a contact')"/></xsl:attribute>
        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Convert')"/></xsl:attribute>
    </input>&#160;        	
</xsl:template>


<xsl:template name="lead_convert">
	<xsl:param name="appName"/>
	<xsl:param name="appLabel"/>	
	<xsl:param name="nodeName"/>	
	<xsl:param name="recordId"/>
	<xsl:param name="recordName"/>			

	<script language="JavaScript" type="text/javascript" src="{$lib_js_path}/form.js"/>		
	<script LANGUAGE="JavaScript" >
		var fieldRequired = new Array();
		var fieldDescription = new Array();
		<xsl:for-each select = "/APPSHORE/APP/edit_fields/edit_fields_item[is_mandatory = 'Y']" >
			fieldRequired[<xsl:value-of select="position()"/>] = '<xsl:value-of select="field_name"/>';
			fieldDescription[<xsl:value-of select="position()"/>] = '<xsl:value-of select="field_label"/>';
		</xsl:for-each>
	</script>

	<xsl:variable name="recordIdValue" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $recordId]"/>		
	<xsl:variable name="recordNameValue" select="/APPSHORE/APP/node()[name() = $nodeName]/node()[name() = $recordName]"/>		
	
    <div class="clearboth">
		<div class="formTitleTags start_float">
	        <xsl:value-of select="php:function('lang','Convert')"/>&#160;
	        <xsl:value-of select="php:functionString('lang',$appLabel)"/>:&#160;
			<xsl:value-of select="$recordNameValue"/>
		</div>		
		<div class="end_float">
			<xsl:call-template name="displayTags">
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="recordIdValue" select="$recordIdValue"/>
			</xsl:call-template>
		</div>
	</div>		
		
	<xsl:variable name="formName" select="'lead_convert'"/>		
	<form name="lead_convert" enctype="multipart/form-data" method="post" onsubmit="return formCheck(this, fieldRequired, fieldDescription);">
		<input type="hidden" name="op" id="op" value="{$appName}.base.convert"/>
		<input type="hidden" name="key" id="key" />	
		<input name="{$recordId}" id="{$recordId}" type="hidden" value="{$recordIdValue}" />				
		
		<div class="clearboth formBar">
			<xsl:call-template name="convertEditButtons">
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="thisForm" select="$formName"/>		
				<xsl:with-param name="isTop" select="'true'"/>		
				<xsl:with-param name="assignedto" select="'true'"/>
			</xsl:call-template>			
		</div>	
					
		<div class="clearboth">
			<xsl:call-template name="customEditBody">
				<xsl:with-param name="thisForm" select="$formName"/>		
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="appLabel" select="$appLabel"/>
				<xsl:with-param name="nodeName" select="$nodeName"/>
				<xsl:with-param name="recordId" select="$recordId"/>
				<xsl:with-param name="recordName" select="$recordName"/>
			</xsl:call-template> 				
		</div>			
	    	    
		<div class="clearboth formBar">
			<xsl:call-template name="convertEditButtons">
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="thisForm" select="$formName"/>		
			</xsl:call-template>			
		</div>	
				
	</form>
	
	<div class="clearboth">
		<br/>
		<xsl:call-template name="customLinked">
			<xsl:with-param name="masterForm" select="$formName"/>
			<xsl:with-param name="masterTableName" select="$appName"/>
			<xsl:with-param name="masterRecordId" select="$recordId"/>
			<xsl:with-param name="masterRecordIdValue" select="$recordIdValue"/>
			<xsl:with-param name="masterRecordNameValue" select="$recordNameValue"/>
		</xsl:call-template>
	</div>

</xsl:template>


<xsl:template name="convertEditButtons">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	
	<xsl:param name="isTop"/>	
	<xsl:param name="assignedto"/>	

    <table cellSpacing="1" cellPadding="1" width="100%" border="0">
		<tr>
			<td class="start_direction">
				<input type="submit" class="formBarButton" name="ConvertAC" id="ConvertAC" onclick="document.{$thisForm}.key.value=this.name">
               		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Proceed the conversion of the lead into an account and a contact')"/></xsl:attribute>                    
		            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','One account, one contact')"/></xsl:attribute>
		        </input>&#160;        	
				<input type="submit" class="formBarButton" name="ConvertA" id="ConvertA" onclick="document.{$thisForm}.key.value=this.name">
               		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Proceed the conversion of the lead into an account')"/></xsl:attribute>                    
		            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','One account')"/></xsl:attribute>
		        </input>&#160;        	
				<input type="submit" class="formBarButton" name="ConvertC" id="ConvertC" onclick="document.{$thisForm}.key.value=this.name">
               		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Proceed the conversion of the lead into a contact')"/></xsl:attribute>                    
		            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','One contact')"/></xsl:attribute>
		        </input>&#160;        	
				<input type="submit" class="formBarButton" name="Cancel" onclick="document.{$thisForm}.key.value=this.name">
		            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
		        </input>
			</td> 
			<td class="end_direction">					
				<xsl:if test = "($assignedto = 'true') and ($isTop = 'true')">
	            	<xsl:value-of select="php:function('lang','Assigned to')"/>&#160;
	        		<select class="fieldInputSelect" name="user_id" >
	        			<xsl:for-each select = "users/users_item" >
       						<option value="{user_id}">
	        					<xsl:if test="user_id = /APPSHORE/APP/node()[$appName]/user_id">
        							<xsl:attribute name="selected" value="true"/>
	        					</xsl:if>
     							<xsl:value-of select="full_name"/>
    						</option>
	        			</xsl:for-each>
	        		</select>
	        	</xsl:if>&#160;
			    <xsl:call-template name="buttonsNavigation">
					<xsl:with-param name="thisForm" select="$thisForm"/>
				</xsl:call-template>
			</td>
		</tr>
	</table>				        
</xsl:template>



</xsl:stylesheet>
