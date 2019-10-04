<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:variable name="baseurl" select="/APPSHORE/API/baseurl"/>
<xsl:variable name="basepath" select="/APPSHORE/API/basepath"/>
<xsl:variable name="api_image_path"><xsl:value-of select="$basepath"/>/api/images</xsl:variable>
<xsl:variable name="app_image_path"><xsl:value-of select="$basepath"/>/<xsl:value-of select="/APPSHORE/API/op/appname" />/images</xsl:variable>
<xsl:variable name="lib_js_path">lib/js</xsl:variable>

<xsl:template name="common_javascript">	
	<script type="text/javascript" src="includes/prototype/prototype-1.6.1.js"/>
	<script type="text/javascript" src="includes/prototype/scriptaculous/scriptaculous.js?load=effects,dragdrop"/>
	<script type="text/javascript" src="includes/prototype/tablekit.js"/>
	<script type="text/javascript" src="{$lib_js_path}/common.js?language={/APPSHORE/API/current_user/language_id}"/>		
	<script type="text/javascript" src="{$lib_js_path}/scriptaculous_control_appshore.js"/>		
	<script type="text/javascript" src="{$lib_js_path}/grid.js"/>		
	<script type="text/javascript" src="includes/prototype/windows/window.js"/>

	<script type="text/javascript" src="includes/underscore-min.js"></script>
	<script type="text/javascript" src="includes/jquery/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">
	  jQuery.noConflict();
	</script>	
	<script type="text/javascript" src="includes/jquery/jquery.multiSelect.20120221.js"/>

</xsl:template>

<xsl:template name="main_window_footer">
	<xsl:if test = "/APPSHORE/API/powered_by">
		<div class="clearboth copyright" align="center" style="padding-top:5em;color:grey">
			<xsl:value-of select="php:function('lang','Powered by')"/>&#160;<a target="_new" href="http://{/APPSHORE/API/brand_website}"><xsl:value-of select="/APPSHORE/API/brand"/></a>
		</div>
	</xsl:if>
	<xsl:if test = "/APPSHORE/API/performance">
		<div class="clearboth copyright" align="center" style="color:grey">
			<xsl:value-of select="php:function('lang','Server response time')"/>&#160;<xsl:value-of select="/APPSHORE/API/performance" />&#160;<xsl:value-of select="php:function('lang','seconds')"/>
		</div>
	</xsl:if>
</xsl:template>

<xsl:template name="rounded">
	<xsl:param name="row" select="'toff'"/>
	<xsl:choose>
		<xsl:when test="$row = 'toff'">
			<b class="rounded"><b class="r1 row_off"></b><b class="r2 row_off"></b><b class="r3 row_off"></b><b class="r4 row_off"></b></b>
		</xsl:when>
		<xsl:when test="$row = 'ton'">
			<b class="rounded"><b class="r1 row_on"></b><b class="r2 row_on"></b><b class="r3 row_on"></b><b class="r4 row_on"></b></b>
		</xsl:when>
		<xsl:when test="$row = 'boff'">
			<b class="rounded"><b class="r4 row_off"></b><b class="r3 row_off"></b><b class="r2 row_off"></b><b class="r1 row_off"></b></b>
		</xsl:when>
		<xsl:when test="$row = 'boff'">
			<b class="rounded"><b class="r4 row_on"></b><b class="r3 row_on"></b><b class="r2 row_on"></b><b class="r1 row_on"></b></b>
		</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template name="translate">
	<xsl:param name="phrase"/>
	<xsl:param name="template" select="''"/>
	<xsl:choose>			
		<xsl:when test="$template = ''">
			<xsl:value-of select="php:functionString('lang',$phrase)"/>
		</xsl:when>
		<xsl:otherwise >
			<xsl:value-of disable-output-escaping="yes" select="php:functionString('lang',$template)"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="messages">
	<xsl:if test="count(messages_item)">
		<xsl:apply-templates select="messages_item" />
	</xsl:if>
</xsl:template> 

<xsl:template match="messages_item">
	<script type="text/javascript">
		document.observe("dom:loaded", function() {
			top.growler.growl('<xsl:value-of select="text"/>');
		});
	</script>
</xsl:template>

<xsl:template match="messages_item[type='error']">
	<script type="text/javascript">
		document.observe("dom:loaded", function() {
			top.growler.error('<xsl:value-of select="text"/>');
		});
	</script>
</xsl:template>

<xsl:template match="messages_item[type='warning']">
	<script type="text/javascript">
		document.observe("dom:loaded", function() {
			top.growler.warning('<xsl:value-of select="text"/>');
		});
	</script>
</xsl:template>

<xsl:template match="messages_item[type='notice']">
	<script type="text/javascript">
		document.observe("dom:loaded", function() {
			top.growler.notice('<xsl:value-of select="text"/>');
		});
	</script>
</xsl:template>

<xsl:template match="messages_item[type='link']">
	<script type="text/javascript">
		document.observe("dom:loaded", function() {
			top.growler.link('<a href="{$baseurl}&amp;op={op}"><xsl:value-of select="text"/></a>');
		});
	</script>
</xsl:template>

</xsl:stylesheet>
