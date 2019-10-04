<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name='customization_translation'>	

	<script language="JavaScript" type="text/javascript" src="http://www.google.com/jsapi"></script>
	<script LANGUAGE="JavaScript" >
		google.load("language", "1");
	</script>
	<script language="JavaScript" type="text/javascript" src="{$lib_js_path}/gtranslation.js"/>

	<form id='translation' name='translation' method='post' >
		<input type='hidden' name='op' id="op" value='www.customization_translation.edit'/>
		<input type="hidden" name="key" id="key" />
		<input type="hidden" name="character" id="character" value="{/APPSHORE/APP/character}"/>
		<input type="hidden" name="selected" id="selected" />	
		
	<div class="formTitleTags start_float">
    	<xsl:value-of select="php:function('lang','Translation')"/>&#160;<div class="end_float" id='branding'></div>
		<script LANGUAGE="JavaScript" >
			google.language.getBranding('branding');
		</script>
	</div>
	
	<div class="helpmsg">
		<xsl:value-of disable-output-escaping="yes" select="php:function('lang','administration.customization.translation.help')"/>
	</div>
	
	<div class="clearboth fieldLabelContainer" style="padding:0px 0 10px 0">
		<div class="fieldLabel start_float">
			<xsl:value-of select="php:function('lang','Select a language')"/>
		</div>
		<div class="clearboth fieldText" >
			<select name="language_id" onchange='translation.submit();return true;'>
					<option/>				
				<xsl:for-each select = "languages/languages_item" >
                    <option value="{language_id}">
						<xsl:if test="language_id = /APPSHORE/APP/language/language_id">
							<xsl:attribute name="selected">true</xsl:attribute>
						</xsl:if>
				         <xsl:value-of select="language_name" />
				     </option>
				</xsl:for-each>	
			</select>
		</div>				
	</div>
	
	<xsl:if test = "translation/translation_item" >		
	
		<xsl:call-template name="translationButtons">
				<xsl:with-param name="thisForm">translation</xsl:with-param>
				<xsl:with-param name="isTop">true</xsl:with-param>
		</xsl:call-template> 		

		<div class="clearboth fieldText" style="font-size:16px;text-align:center">
			<xsl:for-each select = "characters/characters_item" >		
				<a href="#" onclick="$('character').value = this.innerHTML; translation.submit();">
					<xsl:if test="char = /APPSHORE/APP/character">
						<xsl:attribute name="style">font-weight:bold</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="char" />
				</a>
				&#160;
			</xsl:for-each>
		</div>				
		<table cellSpacing="1" cellPadding="1" border="0" width="100%" >
			<tr align="center">
			    <xsl:call-template name="checkAllListForm">
					<xsl:with-param name="thisForm">translation</xsl:with-param>				
				</xsl:call-template>				
				<td class="label" id="phrase_col">
					<xsl:value-of select="php:function('lang','Keyword')"/>
				</td>
				<td class="label" id="source_col">
					<xsl:value-of select="php:function('lang','English text')"/>
				</td>				
				<td class="label" id="source_col">
					<xsl:value-of select="php:function('lang','Default translation')"/>
				</td>				
				<td class="label" ></td>
				<td class="label" id="target_col">
					<xsl:value-of select="php:function('lang','Customized translation')"/>
				</td>				
				<td class="label" >
					<img class="image" src="{$api_image_path}/google.jpg" onclick="gTranslateAll(document.translation,'{/APPSHORE/APP/language/google_language_code}');">
						<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Apply a translation from Google on all blank fields')"/></xsl:attribute>
					</img>				
				</td>
			</tr> 
			<xsl:for-each select = "translation/translation_item" >		
				<tr>
				    <xsl:call-template name="checkListForm">
						<xsl:with-param name="thisForm">translation</xsl:with-param>
						<xsl:with-param name="thisId"><xsl:value-of select="rowid"/></xsl:with-param>					
						<xsl:with-param name="scope"><xsl:if test="not(phrase = '')"><xsl:value-of select="scope"/></xsl:if></xsl:with-param>					
					</xsl:call-template>			
					<xsl:choose>
						<xsl:when test="(scope = 1) and (phrase = '')">
							<td class="field" style="vertical-align:top;width:20%" >
								<textarea  style="width:99%" >
									<xsl:value-of select="phrase" />	
								</textarea>
							</td>
						</xsl:when>
						<xsl:otherwise>
							<td class="field" style="vertical-align:top;" >
								<textarea class="field" style="border:0;width:99%" >
									<xsl:value-of select="phrase" />	
								</textarea>
							</td>
						</xsl:otherwise>
					</xsl:choose>					
					<td class="field" style="vertical-align:top;width:25%" >
						<textarea id="phrase_{rowid}" name="phrase_{rowid}" class="field" style="border:0;width:99%" >
							<xsl:value-of select="english" />	
						</textarea>
					</td>				
					<td class="field" style="vertical-align:top;width:30%" >
						<textarea id="source_{rowid}" name="source_{rowid}" class="field" style="border:0;width:99%" >
							<xsl:value-of select="source" />	
						</textarea>
					</td>				
					<td align="center" class="field" style="width:2em" >
						<xsl:if test="not(source = '')">
							<img class="image" src="{$api_image_path}/ar_right.gif" onclick="dTranslate('{rowid}');">
								<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Apply the default translation')"/></xsl:attribute>
							</img>
						</xsl:if>										
					</td>				
					<td class="field" style="vertical-align:top;;width:30%" >		
						<textarea id="target_{rowid}" name="target_{rowid}" class="target" onchange="this.style.color='green'" style="width:100%">
				        	<xsl:if test="not(source = target)"><xsl:value-of select="target" /></xsl:if>
				        </textarea>
					</td>				
					<td align="center" class="field" style="width:2em" >
						<img class="image" src="{$api_image_path}/google.jpg" onclick="gTranslate('{rowid}','{/APPSHORE/APP/language/google_language_code}');">
							<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Apply a translation from Google')"/></xsl:attribute>
						</img>
					</td>
				</tr>
			</xsl:for-each>	
		</table>	
		<table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
			    <xsl:call-template name="checkAllListForm">
					<xsl:with-param name="thisForm">translation</xsl:with-param>
				</xsl:call-template> 
			</tr>
		</table>	        	

		<xsl:call-template name="translationButtons">
				<xsl:with-param name="thisForm">translation</xsl:with-param>
		</xsl:call-template> 		

		<script >
			document.observe('dom:loaded', function(){
				resizeTextArea();
			});
		</script>		
					
	</xsl:if>   	
		
	</form>	
</xsl:template>


<xsl:template name="translationButtons">	
	<xsl:param name="thisForm"/>
	<xsl:param name="isTop"/>

	<xsl:if test="/APPSHORE/APP/scope > 0">  
	    <div>	
			<input type="button" class="formBarButton" id="Delete"  name="Delete" onclick="gridGetSelected(document.{$thisForm}, document.{$thisForm}.selected);document.{$thisForm}.key.value='Delete';document.{$thisForm}.submit();">
	            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Delete')"/></xsl:attribute>
 	        </input>&#160;
			<input type="submit" class="formBarButton" id="Save" name="Save" onclick="document.{$thisForm}.key.value='Save'">
 	            <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
	        </input>&#160;
		</div>	        	
	</xsl:if>  	
</xsl:template>

</xsl:stylesheet>
