<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="no"/>

<xsl:template match="APP[action/dashboard]">
	<xsl:choose>	
		<xsl:when test="action/dashboard = 'dashboard'">
			<xsl:call-template name="drawDashboard"/>
		</xsl:when>
		<xsl:when test="action/dashboard = 'dashlet'">
			<xsl:call-template name="drawDashlet"/>
		</xsl:when>
	</xsl:choose>	
</xsl:template>

<xsl:template name="drawDashlet">
	<xsl:choose>
		<xsl:when test="dashlet/is_custom = 'Y'">
			<xsl:call-template name="customDashboard">
				<xsl:with-param name="appName" select="dashlet/dashlet_label"/>
				<xsl:with-param name="dashletName" select="dashlet/dashlet_name"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="dashlet/dashlet_name"/>
		</xsl:otherwise>
	</xsl:choose>			
</xsl:template>

<xsl:template name="drawDashboard">
	<script language="JavaScript" type="text/javascript" src="dashboards/js/dashboards.js"></script>	
	<script type="text/javascript" >
		var dash = new Dashboards();
	</script>	

 	<table style="height:100%;width:100%" cellSpacing="10" cellPadding="0" border="0" >
		<tr style="width:100%" valign="top">		
			<td width="50%">
	    		<select class="fieldInputSelect" id="dash1" onchange="dash.addDashlet(1,$F('dash1'));">
    				<option><xsl:value-of select="php:function('lang','Add a box')"/></option>
	    			<xsl:for-each select = "dashlets_available/dashlets_available_item" >
   						<option  class="fieldInputSelectOptionIndent" value="{dashlet_name}">
 							<xsl:value-of select="php:functionString('lang',dashlet_label)"/>
						</option>
	    			</xsl:for-each>
	    		</select>
			</td>
			<td width="50%">
	    		<select class="fieldInputSelect" id="dash2"  onchange="dash.addDashlet(2,$F('dash2'));">
	    				<option><xsl:value-of select="php:function('lang','Add a box')"/></option>
	    			<xsl:for-each select = "dashlets_available/dashlets_available_item" >
   						<option class="fieldInputSelectOptionIndent" value="{dashlet_name}">
 							<xsl:value-of select="php:functionString('lang',dashlet_label)"/>
						</option>
	    			</xsl:for-each>
	    		</select>
			</td>
		</tr>		
		<tr style="width:100%" valign="top">		
			<xsl:for-each select = "dashboard/columns/columns_item">
				<td>
					<div id="column-{column_nbr}" class="dashletColumn" style="width:100%">
						<xsl:for-each select = "dashlets/dashlets_item">
							<div id="{dashlet_name}" class="dashlet">
								<xsl:call-template name="DashboardBox">
									<xsl:with-param name="dashletLabel" select="dashlet_label"/>
									<xsl:with-param name="dashletName" select="dashlet_name"/>
									<xsl:with-param name="appName" select="app_name"/>
								</xsl:call-template>						
							</div>
						</xsl:for-each>
					</div>
				</td>
			</xsl:for-each>
		</tr>		
	</table>	
	<script language="JavaScript" type="text/javascript">		
		<xsl:for-each select = "dashboard/columns/columns_item">
			Sortable.create('column-<xsl:value-of select="column_nbr"/>',{tag:'div',dropOnEmpty:true,constraint:false,containment:$$('.dashletColumn'),only:'dashlet',onUpdate:function(){dash.moveDashlet();}});
			$('column-<xsl:value-of select="column_nbr"/>').setStyle({
				height: (document.body.scrollHeight-$('column-<xsl:value-of select="column_nbr"/>').cumulativeOffset().top)+'px'
				});
		</xsl:for-each>
	</script>							
	
</xsl:template>


<xsl:template name="DashboardBox">
	<xsl:param name="dashletLabel"/>
	<xsl:param name="dashletName"/>	
	<xsl:param name="appName"/>	
	<xsl:call-template name="headerDashboardBox">
		<xsl:with-param name="dashletLabel" select="$dashletLabel"/>
		<xsl:with-param name="dashletName" select="$dashletName"/>
		<xsl:with-param name="appName" select="$appName"/>
	</xsl:call-template>
	<xsl:choose>
		<xsl:when test="is_custom = 'Y'">
			<xsl:call-template name="customDashboard">
				<xsl:with-param name="appName" select="$appName"/>
				<xsl:with-param name="dashletName" select="$dashletName"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="dashlet_name"/>
		</xsl:otherwise>
	</xsl:choose>			
</xsl:template>

<xsl:template name="headerDashboardBox">
	<xsl:param name="dashletLabel"/>
	<xsl:param name="dashletName"/>	
	<xsl:param name="appName"/>	
	
    <table class="dashlet_header" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td class="dashlet_title start_direction">
				<xsl:choose>
					<xsl:when test="string-length($appName)">
						<img class="icon" src="{$api_image_path}/{$appName}_16.png"/>
					</xsl:when>
					<xsl:otherwise>
						<img class="icon" src="{$api_image_path}/{$dashletName}_16.png"/>
					</xsl:otherwise>
				</xsl:choose>&#160;<span id="{$dashletName}-label"><xsl:value-of select="php:functionString('lang',$dashletLabel)"/></span>
			</td>
			<td class="end_direction">
				<span onClick="dash.removeDashlet(this,'{$dashletName}');" class="dashlet_button_hide" onMouseOver="this.className ='link dashlet_button_show'" onMouseOut="this.className ='dashlet_button_hide'">
					<xsl:value-of select="php:function('lang','x')"/>
				</span>&#160;
			</td>
		</tr>
	</table>
</xsl:template>


<xsl:template match="dashlet_name[.='quickAdd']">
	<div class="dashlet_body" id="quickadd">
		<xsl:variable name="quickadd"><xsl:value-of select="/APPSHORE/APP/quickadd" /></xsl:variable>	
		<xsl:for-each select = "/APPSHORE/API/apps/apps_item[quickadd='Y']">
			<div class="dashlet_bodyline" >
				<img class="image" width="16" src="{$api_image_path}/{name}.gif"/>				
				<a style="padding-left:5px" href="{$baseurl}&amp;op={name}.base.edit{$quickadd}">
					<xsl:value-of select="title"/>
				</a>
			</div>
		</xsl:for-each>
	</div>
</xsl:template>

<xsl:template match="dashlet_name[.='history']">
	<div class="dashlet_body" id="history">
		<xsl:for-each select = "/APPSHORE/API/histories/histories_item">
			<div class="dashlet_bodyline" >
				<img class="icon" src="{$api_image_path}/{name}_16.png"/>&#160;
				<a href="{$baseurl}&amp;op={name}.base.edit&amp;{filter}">							
			    	<img class="image" src="{$api_image_path}/edit.png"/>
			    </a>&#160;
				<a href="{$baseurl}&amp;op={opname}&amp;{filter}">
					<xsl:value-of select="label"/>
				</a>
			</div>
		</xsl:for-each>
	</div>
</xsl:template>

<xsl:template match="dashlet_name[.='quickSearch']">
	<form name="quickSearch" method="post" >
		<input type="hidden" name="op" value="base.search.quicksearch"/>	
		<input type="text" size="25" name="criteria" >
			<xsl:attribute name="value">
				<xsl:value-of select="quicksearch/criteria" />
			</xsl:attribute>
		</input><br/>
		<input type="hidden" name="key" />				
		<input type="submit" class="formBarButton" name="search" onclick="document.quickSearch.key.value='Search'">
	    	<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Search')"/></xsl:attribute>
		</input>
	</form>	
</xsl:template>

</xsl:stylesheet>
