<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP[action/export]">
    <table height="100%" width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
			<xsl:call-template name="leftPanel"/>
            <td id="right_panel" class="right_panel">
				<xsl:choose>
					<xsl:when test="action/export = 'download'">
				    	<xsl:call-template name="export_download"/>
					</xsl:when>
					<xsl:when test="action/export = 'selectFields'">
				    	<xsl:call-template name="export_selectFields"/>
					</xsl:when>
					<xsl:when test="action/export = 'exportFile'">
				    	<xsl:call-template name="export_exportFile"/>
					</xsl:when>					
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name="export_download">

	<script language='javascript' >
		<![CDATA[
		
		function checkTheBox( Mycheck)
		{
			if ( Mycheck.checked == true )
				Mycheck.value = 1;
			else
				Mycheck.value = 0;
		}
		
		]]>
	</script>
	<form name="export_download" enctype="multipart/form-data" method="post">
		<input type="hidden" name="op" >
			<xsl:attribute name="value"><xsl:value-of select="/APPSHORE/API/op/appname" />.export.download</xsl:attribute>
		</input>			

    <table class="boxtitle" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td>
				<xsl:value-of select="php:function('lang','export')"/>
			</td>
		</tr>
	</table>

	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr>
			<td class="label" align="right" width="25%"><xsl:value-of select="php:function('lang','File format')"/>:</td>			
			<td  class="field" align="left" width="75%">
				<select name="format_id"  >
					<xsl:for-each select = "format/format_item" >
						<option value="{format_id}" >
							<xsl:value-of select="format_name"/>
						</option>
					</xsl:for-each>
				</select>	
			</td>		
		</tr>
		<tr>
			<td class="label" align="right" width="25%"><xsl:value-of select="php:function('lang','File name')"/>:</td>			
			<td  class="field" align="left" width="75%">
				<input type="hidden" name="filename" >
					<xsl:attribute name="value"><xsl:value-of select="export/filename"/></xsl:attribute>
				</input>			
				<input name="userfile" size="40" type="file" onclick="document.export_download.filename.value=this.value;"/>
				<!-- userfile is a mandatory name see php download file procedure -->				
				<xsl:if test="/APPSHORE/APP/error/userfile">
                    <span class="failure">
                        <br/><xsl:value-of select="/APPSHORE/APP/error/userfile" />
                    </span>
                </xsl:if>
			</td>		
		</tr>		
		<tr>
			<td class="label" align="right" width="25%"><xsl:value-of select="php:function('lang','Header column')"/>:</td>
			<td  class="field" align="left" width="75%">
				<input type="checkbox" name="header" >
					<xsl:attribute name="onclick">checkTheBox(this)</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="export/header" /></xsl:attribute>
					<xsl:if test="export/header = '1'">
						<xsl:attribute name="checked"/>
					</xsl:if>					
				</input>
			</td>
		</tr>								
	</table>
	
	<table border="0" width="100%" cellpadding="0" cellspacing="0">
		<tr align="left">
			<td >
				<br/>
				<input type="hidden" name="key" />				
				<input type="submit" name="Next" onclick="document.export_download.key.value='Next'">
                    <xsl:attribute name="value">
                        <xsl:value-of select="php:function('lang','Next')"/>
                    </xsl:attribute>
                </input>             
				<br/>                
			</td>
		</tr>
	</table>

	</form>
</xsl:template>

<xsl:template name="export_selectFields">
	<form name="export_selectFields" method="post" >
		<input type="hidden" name="op" >
			<xsl:attribute name="value"><xsl:value-of select="/APPSHORE/API/op/appname" />.export.selectFields</xsl:attribute>
		</input>			

    <table class="boxtitle" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td>
				<xsl:value-of select="php:function('lang','Select fields')"/>
			</td>
		</tr>
	</table>

	<table border="0" width="100%" cellpadding="1" cellspacing="1">	
		<tr class="label" align="center" width="100%">
			<td width="25%"><xsl:value-of select="php:function('lang','Database fields')"/></td>
			<xsl:choose>
				<xsl:when test = "sample/sample_item/header">
					<td width="25%"><xsl:value-of select="php:function('lang','Header row')"/></td>
					<td width="25%"><xsl:value-of select="php:function('lang','Row 1')"/></td>
					<td width="25%"><xsl:value-of select="php:function('lang','Row 2')"/></td>
				</xsl:when>
				<xsl:otherwise>
					<td width="25%"><xsl:value-of select="php:function('lang','Row 1')"/></td>
					<td width="25%"><xsl:value-of select="php:function('lang','Row 2')"/></td>
					<td width="25%"><xsl:value-of select="php:function('lang','Row 3')"/></td>
				</xsl:otherwise>					
			</xsl:choose>			
		</tr>	
		<xsl:for-each select = "sample/sample_item">
			<xsl:variable name="match" ><xsl:value-of select="header"/></xsl:variable>
			<tr class="unselectedtext" align="center" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
				<td width="25%">
					<select name="{field}">
							<option/>
						<xsl:for-each select = "/APPSHORE/APP/columns/columns_item" >
							<option value="{column_name}">
								<xsl:if test="$match = column_match">
									<xsl:attribute name="selected" value="true"/>
								</xsl:if>
								<xsl:value-of select="column_label"/>
							</option>
						</xsl:for-each>
					</select>
				</td>			
				<xsl:choose>
					<xsl:when test = "header">
						<td width="25%"><xsl:value-of select="header"/></td>
						<td width="25%"><xsl:value-of select="column1"/></td>
						<td width="25%"><xsl:value-of select="column2"/></td>
					</xsl:when>
					<xsl:otherwise>
						<td width="25%"><xsl:value-of select="column1"/></td>
						<td width="25%"><xsl:value-of select="column2"/></td>
						<td width="25%"><xsl:value-of select="column3"/></td>
					</xsl:otherwise>					
				</xsl:choose>
			</tr>
		</xsl:for-each>				
	</table>
	
	<table border="0" width="100%" cellpadding="0" cellspacing="0">
		<tr align="left">
			<td >
				<br/>
				<input type="hidden" name="key" />				
				<input type="submit" name="Previous" onclick="document.export_selectFields.key.value='Previous'">
                    <xsl:attribute name="value">
                        <xsl:value-of select="php:function('lang','Previous')"/>
                    </xsl:attribute>
                </input>             
				&#160;						
				<input type="submit" name="Next" onclick="document.export_selectFields.key.value='Next'">
                    <xsl:attribute name="value">
                        <xsl:value-of select="php:function('lang','Next')"/>
                    </xsl:attribute>
                </input>             
				<br/>                
			</td>
		</tr>
	</table>

	</form>
</xsl:template>

<xsl:template name="export_exportFile">

	<script language='javascript' >
		<![CDATA[
		
		function checkTheBox( Mycheck)
		{
			if ( Mycheck.checked == true )
				Mycheck.value = 1;
			else
				Mycheck.value = 0;
		}
		
		]]>
	</script>
	<form name="export_exportFile" method="post">
		<input type="hidden" name="op" >
			<xsl:attribute name="value"><xsl:value-of select="/APPSHORE/API/op/appname" />.export.exportFile</xsl:attribute>
		</input>			

    <table class="boxtitle" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td>
				<xsl:value-of select="php:function('lang','export')"/>
			</td>
		</tr>
	</table>

	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr>
			<td class="label" align="right" width="25%"><xsl:value-of select="php:function('lang','Rows processed')"/>:</td>			
			<td  class="field" align="left" width="75%" colspan="2">
				<xsl:value-of select="export/rows"/>
			</td>		
		</tr>
		<xsl:for-each select = "export/specific/node()">
			<xsl:if test = "name()">
				<tr>
					<td class="label" align="right" width="25%"><xsl:value-of select="name()"/>:</td>			
					<td  class="field" align="left" width="25%">
						<xsl:value-of select="php:function('lang','Created')"/>:&#160;<xsl:value-of select="created"/>
					</td>		
					<td  class="field" align="left" width="25%">
						<xsl:value-of select="php:function('lang','Rejected')"/>:&#160;<xsl:value-of select="rejected"/>
					</td>					
				</tr>		
			</xsl:if>
		</xsl:for-each>					
	</table>

	</form>
</xsl:template>

</xsl:stylesheet>
