<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP[action/node()[name() = /APPSHORE/APP/recordset/appName]]">
    <table width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
			<td class="left_panel" id="left_panel" style="display:{/APPSHORE/API/cookie/left_panel}">
			    <xsl:call-template name="verticalMenus">		    
					<xsl:with-param name="appName">preferences</xsl:with-param>
					<xsl:with-param name="appLabel">Preferences</xsl:with-param>
				</xsl:call-template>	
			</td>
            <td id="right_panel" class="right_panel">
				<xsl:choose>
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'view'">
				    	<xsl:call-template name="custom_view">
				    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
				    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabelSingular"/>
				    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appNameSingular"/>
				    		<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>	
				    		<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>				    		
							<xsl:with-param name="delete">false</xsl:with-param>
							<xsl:with-param name="duplicate">false</xsl:with-param>		
							<xsl:with-param name="print">false</xsl:with-param>		
							<xsl:with-param name="assignedto">false</xsl:with-param>
				    	</xsl:call-template>				    					    	
					</xsl:when>
					
					<xsl:when test="action/node()[name() = /APPSHORE/APP/recordset/appName] = 'edit'">
						<br/>
						<div class="helpmsg">
							<xsl:value-of disable-output-escaping="yes" select="php:function('lang','preferences.lookandfeel.edit.help')"/>
						</div>
				    	<xsl:call-template name="custom_edit">
				    		<xsl:with-param name="appName" select="/APPSHORE/APP/recordset/appName"/>
				    		<xsl:with-param name="appLabel" select="/APPSHORE/APP/recordset/appLabelSingular"/>
				    		<xsl:with-param name="nodeName" select="/APPSHORE/APP/recordset/appNameSingular"/>
				    		<xsl:with-param name="recordId" select="/APPSHORE/APP/recordset/appRecordId"/>		
				    		<xsl:with-param name="recordName" select="/APPSHORE/APP/recordset/appRecordName"/>				    		
							<xsl:with-param name="delete">false</xsl:with-param>
							<xsl:with-param name="duplicate">false</xsl:with-param>
							<xsl:with-param name="assignedto">false</xsl:with-param>
				    	</xsl:call-template>				    					    	
					</xsl:when>
					
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>


<xsl:template match="/APPSHORE/API/Plugins" mode="EditButtons">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	
</xsl:template>

<xsl:template match="/APPSHORE/API/Plugins" mode="EditLines">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	
	<xsl:call-template name="edit_lines">
		<xsl:with-param name="appName" select="$appName"/>
		<xsl:with-param name="thisForm" select="$thisForm"/>	
	</xsl:call-template>
</xsl:template>

<xsl:template name="edit_lines">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	
	<style>
		.out { 
				display:block;   
				background:#bbb; 
				border:1px solid #ddd; 
				position:relative;
				margin:1em 0;
			}
		.in {	
				text-align:center; 
				background:#fff; 
				border:1px solid #555; 
				position:relative; 
				padding:5px;
				font-weight:normal;
			}
		.ltin {	left:-5px; }
		.tpin { top:-5px; }
		.narrow {width:134px;} /* change to suit */
		h4 {font-weight:bold; color:#000;}
	</style>
	
	<script language="JavaScript" type="text/javascript">
	<![CDATA[
		function setSelect( thisObj, selection) 
		{
	  		for( var i = 0 ; i < thisObj.length ; i++) 
	   			if(thisObj[i].value == selection)
	     			thisObj.selectedIndex = i;
		}
	]]>
	</script>	
	<div style="height:1px" />
	<table class="field" border="0" width="100%">
		<xsl:variable name="nbThemes"><xsl:value-of select="count(/APPSHORE/APP/themes)"/></xsl:variable> 
		<tr class="field" align="left" width="100%" >
			<xsl:for-each select = "/APPSHORE/APP/themes/themes_item" >
				<xsl:call-template name="col_icon">
					<xsl:with-param name="i"><xsl:value-of select="position()" /></xsl:with-param>
					<xsl:with-param name="count"><xsl:value-of select="$nbThemes" /></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</tr>
	</table>	
</xsl:template>

<xsl:template name="col_icon">
	<xsl:param name="i"/>
	<xsl:param name="count"/>
		
	<td align="center">
		<div class="out narrow">
			<div class="in ltin tpin" onMouseOver="this.className ='in'" onMouseOut="this.className ='in ltin tpin'">	
				<img class="image link" id="{theme_id}" name="{theme_id}" title="{theme_name}" src="{$basepath}/api/css/images/{theme_id}.jpg" onclick="setSelect($('theme_id'), this.id);"/>
			</div>
		</div>
	</td>

	<xsl:if test="( $i mod 5 ) = 0 " >
		<xsl:text disable-output-escaping="yes">
			&lt;/tr&gt;
			&lt;tr class="field" &gt;
		</xsl:text>
	</xsl:if>	
</xsl:template>


</xsl:stylesheet>
