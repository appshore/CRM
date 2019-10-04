<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="leftPanel">
	<xsl:if test="not(/APPSHORE/API/popup)">
		<td id="left_panel" style="display:{/APPSHORE/API/cookie/left_panel};width:160px">		
		    <xsl:call-template name="panelets"/>
		</td>
	</xsl:if>	
</xsl:template>

<xsl:template name="panelets">
	<script language="JavaScript" type="text/javascript" src="base/js/panelets.js"></script>	
	<script type="text/javascript" >
		var panel = new Panelets();
	</script>	
	<div id="panel" class="panelets">
		<xsl:choose>
			<xsl:when test="count(/APPSHORE/API/panelets/used/used_item) = 0">
				<div class="panelet_help">
					<xsl:value-of disable-output-escaping="yes" select="php:function('lang','base.panelets.help.addbox')"/>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select = "/APPSHORE/API/panelets/used/used_item">
					<xsl:apply-templates select="panelet_name"/>
				</xsl:for-each>			
			</xsl:otherwise>
		</xsl:choose>
	</div>
	<div style="padding:10px 0 0 5px">
		<form id="panelets-form">
		<select class="fieldInputSelect" id="panelets-select" onchange="panel.addPanelet($F(this));" style="width:142px">
			<option><xsl:value-of select="php:function('lang','Add a box')"/></option>
			<xsl:for-each select = "/APPSHORE/API/panelets/available/available_item" >
				<option value="{panelet_name}" class="fieldInputSelectOptionIndent">
					<xsl:value-of select="php:functionString('lang',panelet_label)"/>
				</option>
			</xsl:for-each>
		</select>
		</form>
	</div>
	<script language="JavaScript" type="text/javascript">		
		document.observe("dom:loaded", function() {
			Sortable.create('panel',{tag:'div',containment:$$('.panelets'),only:'panelet',onUpdate:function(){panel.movePanelet();}});
		});
	</script>							
</xsl:template>

<xsl:template name="headerleftPanelBox">
	<xsl:param name="appLabel"/>
	<xsl:param name="appName"/>		
	<xsl:param name="isOpen"/>
    <table class="panelet_header" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td style="vertical-align:top;width:16px">
				<img border="0" id="{$appName}-img" src="{$api_image_path}/arr-{$isOpen}.gif" onClick="panel.openClosePanelet('{$appName}','{$isOpen}')" style="cursor:pointer"/>
			</td>
			<td class="start_direction" id="{$appName}-label"><xsl:value-of select="php:functionString('lang',$appLabel)"/></td>
			<td class="end_direction dashlet_button_hide" onClick="panel.removePanelet(this,'{$appName}');" onMouseOver="this.className ='end_direction link dashlet_button_show'" onMouseOut="this.className ='end_direction dashlet_button_hide'" style="padding:0 4px 0 2px;vertical-align:top">
				<xsl:value-of select="php:function('lang','x')"/>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template match="panelet_name[.='history']">
	<xsl:variable name="paneletName" select="'history'" />
	<xsl:variable name="panelet" select="/APPSHORE/API/panelets/used/used_item[panelet_name=$paneletName]" />
	<div id="panelet_{$panelet/panelet_sequence}" class="panelet">
		<xsl:call-template name="headerleftPanelBox">
			<xsl:with-param name="appLabel" select="$panelet/panelet_label"/>
			<xsl:with-param name="appName" select="$paneletName"/>
			<xsl:with-param name="isOpen" select="$panelet/is_open"/>
		</xsl:call-template>
		<div class="panelet_body" id="{$paneletName}" style="display:{$panelet/is_open}" >
			<xsl:variable name="transView"><xsl:value-of select="php:function('lang','View')"/></xsl:variable>
			<xsl:variable name="transEdit"><xsl:value-of select="php:function('lang','Edit')"/></xsl:variable>
			<xsl:for-each select = "/APPSHORE/API/histories/histories_item">
				<div class="panelet_bodyline">
					<img class="icon" src="{$api_image_path}/{name}_16.png"/>
					<a href="{$baseurl}&amp;op={opname}&amp;{filter}" onMouseOver="contextualMenu('{$baseurl}&amp;op={opname}&amp;{filter_slash}','{label_slash}', '{$transView}', '{$transEdit}');" onMouseOut="return nd(500);">
						<xsl:value-of select="label_short"/>
					</a>
				</div>	
			</xsl:for-each>		
		</div>
	</div>
</xsl:template>

<xsl:template match="panelet_name[.='quickadd']">
	<xsl:variable name="paneletName" select="'quickadd'" />
	<xsl:variable name="panelet" select="/APPSHORE/API/panelets/used/used_item[panelet_name=$paneletName]" />
	<div id="panelet_{$panelet/panelet_sequence}" class="panelet">
		<xsl:call-template name="headerleftPanelBox">
			<xsl:with-param name="appLabel" select="$panelet/panelet_label"/>
			<xsl:with-param name="appName" select="$paneletName"/>
			<xsl:with-param name="isOpen" select="$panelet/is_open"/>
		</xsl:call-template>
		<div class="panelet_body" id="{$paneletName}" style="display:{$panelet/is_open}" >
			<xsl:variable name="quickadd"><xsl:value-of select="/APPSHORE/APP/quickadd" /></xsl:variable>
			<xsl:for-each select = "/APPSHORE/API/apps/apps_item[quickadd='Y']">
				<div class="panelet_bodyline">
					<img class="icon" src="{$api_image_path}/{name}_16.png"/>
					<a href="{$baseurl}&amp;op={name}.base.edit{$quickadd}">
						<xsl:value-of select="title"/>
					</a>
				</div>
			</xsl:for-each>	
		</div>
	</div>
</xsl:template>

<xsl:template match="panelet_name[.='appshore_twitter']">
	<xsl:variable name="paneletName" select="'appshore_twitter'" />
	<xsl:variable name="panelet" select="/APPSHORE/API/panelets/used/used_item[panelet_name=$paneletName]" />
	<div id="panelet_{$panelet/panelet_sequence}" class="panelet">
		<xsl:call-template name="headerleftPanelBox">
			<xsl:with-param name="appLabel" select="$panelet/panelet_label"/>
			<xsl:with-param name="appName" select="$paneletName"/>
			<xsl:with-param name="isOpen" select="$panelet/is_open"/>
		</xsl:call-template>
		<div class="panelet_body" id="{$paneletName}" style="display:{$panelet/is_open}" >
			<xsl:for-each select = "/APPSHORE/API/panelets/node()[name()=$paneletName]/items/items_item">
				<div class="panelet_bodyline">
					<xsl:value-of select="title" />
				</div>
			</xsl:for-each>
		</div>
	</div>
</xsl:template>

</xsl:stylesheet>
