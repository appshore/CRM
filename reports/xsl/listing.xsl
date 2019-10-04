<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="report_print">
	
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
	<xsl:for-each select = "/APPSHORE/APP/xmlreport/label_header">
		<tr class="label" align="left">

			<xsl:call-template name="headerlabels">
				<xsl:with-param name="lab"><xsl:value-of select="label" /></xsl:with-param>
			</xsl:call-template>

		</tr>
	</xsl:for-each>
	<xsl:for-each select = "/APPSHORE/APP/xmlreport/column_header">
		<tr class="columnH" align="left">
			<xsl:call-template name="headercolumns">
				<xsl:with-param name="col"><xsl:value-of select="column" /></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="foottotal">
				<xsl:with-param name="col"><xsl:value-of select="column" /></xsl:with-param>
			</xsl:call-template>
		</tr>
	</xsl:for-each>
	
	</table>
</xsl:template>


<xsl:template name="headerlabels">
	<xsl:param name="lab"/>
	<td>
		<xsl:value-of select="$lab" />
	</td>
</xsl:template>


<xsl:template name="headercolumns">
	<xsl:param name="col"/>

	<xsl:for-each select = "/APPSHORE/APP/xmlreport/recordgroup/record/record_item/node()[$col]">
				<xsl:value-of select="node()">	
				<xsl:choose>
					<xsl:when test="position() mod 20 = 1"><tr></tr>
					</xsl:when>
					<xsl:otherwise><td></td>
					</xsl:otherwise>
				</xsl:choose>
				</xsl:value-of>
        </xsl:for-each>

</xsl:template>

<xsl:template name="foottotal">
	<xsl:param name="col"/>
	<tr>
	<xsl:for-each select = "/APPSHORE/APP/xmlreport/grandtotal/node()[$col]">
		<td>
 
			<xsl:value-of select="count" />
			<xsl:value-of select="sum" />
			<xsl:value-of select="average" />
			<xsl:value-of select="min" />	
			<xsl:value-of select="max" />

		</td>
	</xsl:for-each>

	</tr>
</xsl:template>
	

</xsl:stylesheet>
