<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP[action/import]">
    <table height="100%" width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
		    <xsl:call-template name="leftPanel"/>
            <td id="right_panel" class="right_panel">
				<xsl:choose>
					<xsl:when test="action/import = 'upload'">
				    	<xsl:call-template name="import_upload"/>
					</xsl:when>
					<xsl:when test="action/import = 'selectFields'">
				    	<xsl:call-template name="import_selectFields"/>
					</xsl:when>
					<xsl:when test="action/import = 'importFile'">
				    	<xsl:call-template name="import_importFile"/>
					</xsl:when>					
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name="import_upload">
				
	<form name="import_upload" enctype="multipart/form-data" method="post">
		<input type="hidden" name="op" >
			<xsl:attribute name="value"><xsl:value-of select="/APPSHORE/API/op/appname" />.<xsl:value-of select="/APPSHORE/API/op/classname" />.upload</xsl:attribute>
		</input>			

	<div class="clearboth formTitle">
			<xsl:value-of select="php:function('lang','Import')"/>
	</div>
	
	<div class="helpmsg">
 		<xsl:value-of disable-output-escaping="yes" select="php:function('lang','lib.import.help.psjob')"/>
 		<xsl:value-of select="php:function('lang','Technical support')"/>:
		<xsl:call-template name="mailto">
			<xsl:with-param name="email"><xsl:value-of select="php:function('lang','support@appshore.com')"/></xsl:with-param>
			<xsl:with-param name="name"><xsl:value-of select="php:function('lang','Support team')"/></xsl:with-param>
			<xsl:with-param name="subject"><xsl:value-of select="/APPSHORE/API/my_company/company_name" />, <xsl:value-of select="/APPSHORE/API/current_user/full_name" />: <xsl:value-of select="php:function('lang','Data import request')"/></xsl:with-param>
		</xsl:call-template>
	</div>

	<table style="width:100%">
		<tr style="width:100%">
			<td class="fieldLabelContainer" style="width:50%">
				<div class="fieldLabel">
					<xsl:value-of select="php:function('lang','File name')"/>
				</div>
				<div class="fieldText">
					<input type="hidden" name="filename" >
						<xsl:attribute name="value"><xsl:value-of select="import/filename"/></xsl:attribute>
					</input>			
					<input name="userfile" class="formBarButton" size="40" type="file" onclick="document.import_upload.filename.value=this.value;"/>
					<!-- userfile is a mandatory name see php upload file procedure -->				
					<xsl:if test="/APPSHORE/APP/error/userfile">
				        <span class="failure">
				            <br/><xsl:value-of select="/APPSHORE/APP/error/userfile" />
				        </span>
				    </xsl:if>
				</div>
			</td>
			<td class="fieldLabelContainer" style="width:50%">
				<div class="fieldLabel">
					<xsl:value-of select="php:function('lang','File format')"/>
				</div>
				<div class="fieldText">
					<select class="fieldInputCheckbox" id="format_id" name="format_id">
						<xsl:for-each select="format/format_item" >
							<option value="{format_id}">
								<xsl:value-of select="format_name"/>
							</option>
						</xsl:for-each>
					</select>	
				</div>
			</td>
		</tr>
		<tr>
			<td class="fieldLabelContainer">
				<div class="fieldLabel">
					<xsl:value-of select="php:function('lang','Header row')"/>
				</div>
				<div class="fieldText">
					<input class="fieldInputCheckbox" type="checkbox" name="header" >
						<xsl:attribute name="onclick">is_boxchecked(this)</xsl:attribute>
						<xsl:attribute name="value"><xsl:value-of select="import/header" /></xsl:attribute>
						<xsl:if test="import/header = 'Y'">
							<xsl:attribute name="checked"/>
						</xsl:if>					
					</input>
				</div>
			</td>
			<td class="fieldLabelContainer">
				<div class="fieldLabel">
					<xsl:value-of select="php:function('lang','Create related records')"/>
				</div>
				<div class="fieldText">
					<input class="fieldInputCheckbox" type="checkbox" name="related" >
						<xsl:attribute name="onclick">is_boxchecked(this)</xsl:attribute>
						<xsl:attribute name="value"><xsl:value-of select="import/related" /></xsl:attribute>
						<xsl:if test="import/related = 'Y'">
							<xsl:attribute name="checked"/>
						</xsl:if>					
					</input>
				</div>
			</td>
		</tr>
		<tr>
			<td class="fieldLabelContainer">
				<div class="fieldLabel">
					<xsl:value-of select="php:function('lang','Duplicate records')"/>
				</div>
				<div class="fieldText">
					<select class="fieldInputSelect" id="duplicate_id" name="duplicate_id">
						<xsl:for-each select="duplicates/duplicates_item" >
							<option value="{duplicate_id}">
								<xsl:value-of select="duplicate_name"/>
							</option>
						</xsl:for-each>
					</select>	
				</div>
			</td>
			<td class="fieldLabelContainer">
				<div class="fieldLabel">
					<xsl:value-of select="php:function('lang','Fields mapping')"/>
				</div>
				<div class="fieldText">
					<select class="fieldInputSelect" name="mapping_id">
						<xsl:for-each select="mapping/mapping_item" >
							<option value="{mapping_id}">
								<xsl:value-of select="mapping_name"/>
							</option>
						</xsl:for-each>
					</select>	
				</div>
			</td>
		</tr>
	</table>
								
	<div class="clearboth formBar">
		<input type="hidden" name="key" />				
		<input type="submit" class="formBarButton" name="Next" onclick="document.import_upload.key.value='Next'">
		    <xsl:attribute name="value">
		        <xsl:value-of select="php:function('lang','Next')"/>
		    </xsl:attribute>
		</input>            
	</div>

	</form>
</xsl:template>

<xsl:template name="import_selectFields">
	<form name="import_selectFields" method="post" >
		<input type="hidden" name="op" >
			<xsl:attribute name="value"><xsl:value-of select="/APPSHORE/API/op/appname" />.<xsl:value-of select="/APPSHORE/API/op/classname" />.selectFields</xsl:attribute>
		</input>			

	<div class="clearboth formTitle">
		<xsl:value-of select="php:function('lang','Select fields')"/>
	</div>
	
	<xsl:if test="/APPSHORE/APP/columns/columns_item[field_name != /APPSHORE/APP/index_name]/is_mandatory = 'Y'">	
		<div class="clearboth fieldLabel">
			<xsl:value-of select="php:function('lang','Mandatory fields')"/>
		</div>
	
		<div class="clearboth fieldLabelMandatory">
			<xsl:for-each select = "/APPSHORE/APP/columns/columns_item[field_name != /APPSHORE/APP/index_name and is_mandatory = 'Y']" >					
				<xsl:value-of select="php:functionString('lang',field_label)"/>&#160;
			</xsl:for-each>	
		</div>
	</xsl:if>

	<table border="0" width="100%" cellpadding="1" cellspacing="1" style="padding-top:10px">	
		<tr class="label" align="center" width="100%">
			<td><xsl:value-of select="php:function('lang','Database fields')"/></td>
			<xsl:choose>
				<xsl:when test = "sample/sample_item/header">
					<td><xsl:value-of select="php:function('lang','Header row')"/></td>
					<td><xsl:value-of select="php:function('lang','Row 1')"/></td>
					<td><xsl:value-of select="php:function('lang','Row 2')"/></td>
				</xsl:when>
				<xsl:otherwise>
					<td><xsl:value-of select="php:function('lang','Row 1')"/></td>
					<td><xsl:value-of select="php:function('lang','Row 2')"/></td>
					<td><xsl:value-of select="php:function('lang','Row 3')"/></td>
				</xsl:otherwise>					
			</xsl:choose>			
		</tr>	
		<xsl:for-each select = "sample/sample_item">
			<xsl:variable name="match" select="header"/>
			<tr class="unselectedtext" align="left" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">
				<td style="min-width:10em">
					<select style="width:100%" name="{field}">
							<option/>
						<xsl:for-each select = "/APPSHORE/APP/columns/columns_item" >
							<option class="mandatory_field" value="{field_name}">
								<xsl:if test="$match = field_match">
									<xsl:attribute name="selected" value="true"/>
								</xsl:if>
								<xsl:value-of select="php:functionString('lang',field_label)"/>
							</option>
						</xsl:for-each>
					</select>
				</td>			
				<xsl:choose>
					<xsl:when test = "header">
						<td style="min-width:10em"><xsl:value-of select="header"/></td>
						<td style="min-width:10em"><xsl:value-of select="column1"/></td>
						<td style="min-width:10em"><xsl:value-of select="column2"/></td>
					</xsl:when>
					<xsl:otherwise>
						<td style="min-width:10em"><xsl:value-of select="column1"/></td>
						<td style="min-width:10em"><xsl:value-of select="column2"/></td>
						<td style="min-width:10em"><xsl:value-of select="column3"/></td>
					</xsl:otherwise>					
				</xsl:choose>
			</tr>
		</xsl:for-each>				
	</table>
	
	<div class="clearboth formBar">
		<input type="hidden" name="key" />				
		<input type="submit" class="formBarButton" name="Previous" onclick="document.import_selectFields.key.value='Previous'">
		    <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Previous')"/></xsl:attribute>
		</input>&#160;						
		<input type="submit" class="formBarButton" name="Next" onclick="document.import_selectFields.key.value='Next'">
		    <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Next')"/></xsl:attribute>
		</input>
	</div>

	</form>
</xsl:template>

<xsl:template name="import_importFile">

	<form name="import_importFile" method="post">
		<input type="hidden" name="op" >
			<xsl:attribute name="value"><xsl:value-of select="/APPSHORE/API/op/appname" />.<xsl:value-of select="/APPSHORE/API/op/classname" />.importFile</xsl:attribute>
		</input>			

	<div class="clearboth formTitle">
		<xsl:value-of select="php:function('lang','Import')"/>
	</div>

	<div class="clearboth fieldLabelContainer" style="padding-top: 10px;">
		<div class="fieldLabel">
			<xsl:value-of select="php:function('lang','Rows processed')"/>
		</div>
		<div class="fieldText">
			<xsl:value-of select="import/rows"/>
		</div>
	</div>
	
	<table class="clearboth" border="0" cellpadding="0" cellspacing="0" width="40em">
		<tr width="40em">
			<td width="20em">&#160;
			</td>			
			<td width="10em">
				<xsl:value-of select="php:function('lang','Created')"/>
			</td>		
			<td width="10em">
				<xsl:value-of select="php:function('lang','Rejected')"/>
			</td>					
		</tr>		
		<xsl:for-each select = "import/specific/node()[name()]">
			<tr>
				<td >
					<xsl:value-of select="name()"/>
				</td>			
				<td>
					<xsl:value-of select="created"/>
				</td>		
				<td>
					<xsl:value-of select="rejected"/>
				</td>					
			</tr>		
		</xsl:for-each>					
	</table>

	</form>
</xsl:template>

</xsl:stylesheet>
