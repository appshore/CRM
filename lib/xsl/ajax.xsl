<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP">
	<xsl:choose>		
		<xsl:when test="action/ajax = 'search'">
	    	<xsl:call-template name="search"/>    	
		</xsl:when>
		<xsl:when test="action/ajax = 'grid'">
	    	<xsl:call-template name="grid"/>    	
		</xsl:when>													
		<xsl:otherwise>
	    	<xsl:call-template name="default_render"/>    	
		</xsl:otherwise>													
	</xsl:choose>
</xsl:template>

<xsl:template name="search">
	<ul>
		<xsl:for-each select = "search/search_item">
			<li><xsl:value-of select="result"/></li>	
		</xsl:for-each>
	</ul>
</xsl:template> 

<xsl:template name="grid">
	<ajax-response>
		<response type="object" id="data_grid_updater">
			<rows update_ui="true" >
				<xsl:for-each select = "/APPSHORE/APP/datas/datas_item">
					<tr>
						<xsl:for-each select = "node()">
							<xsl:if test="name()">	
								<td>
									<xsl:value-of select="node()"/>
								</td>
							</xsl:if>
						</xsl:for-each>
					</tr>	
				</xsl:for-each>
			</rows>
		</response>
	</ajax-response>
</xsl:template> 

<xsl:template name="default_render">
<xsl:value-of disable-output-escaping="yes" select="/APPSHORE/APP" />
</xsl:template> 

</xsl:stylesheet>

