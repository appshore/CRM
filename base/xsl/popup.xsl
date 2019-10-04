<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="/">
	<html>
		<head>
			<xsl:call-template name="commonHead"/>

			<link rel="stylesheet" type="text/css" href="includes/prototype/windows/themes/default.css"/>

			<xsl:call-template name="common_javascript"/>

			<script type="text/javascript" src="includes/overlibmws/overlibmws.js"/>
			<script type="text/javascript" src="includes/prototype/cookie.js"/>
		</head>

		<body id='popup'>
			<xsl:apply-templates select="/APPSHORE/API/messages" />
			<!-- MAIN -->
			<xsl:choose>
				<!-- Normal APP output -->
				<xsl:when test="/APPSHORE/APP">
					<xsl:apply-templates select="/APPSHORE/APP" />
				</xsl:when>
				<!-- HTML output -->
				<xsl:when test="/APPSHORE/APPHTML">
					<xsl:value-of disable-output-escaping="yes" select="/APPSHORE/APPHTML" />
				</xsl:when>
			</xsl:choose>	

			<script type="text/javascript">
				document.observe('dom:loaded', function(){
					if( top.document.getElementById('popupfrm') )
						top.document.getElementById('popupfrm').height = document.body.scrollHeight;
				});
			</script>		
	
			<script type="text/javascript">
				jQuery(document).ready(function($) {
					jQuery('form select.fieldInputSelectMultiple').multiSelect({
						selectAll: false,
						noneSelected: '',
						oneOrMoreSelected: '*'
					});
				});
			</script>
		</body>
	</html>
</xsl:template> 

</xsl:stylesheet>
