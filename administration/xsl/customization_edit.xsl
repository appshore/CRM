<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template name="fieldBox">
	<xsl:variable name="fieldHeight"><xsl:call-template name="customHeight"><xsl:with-param name="field_height" select="field_height"/></xsl:call-template></xsl:variable>
	<div class="custom_box_dotted fieldContainer" id="{field_name}" title="{field_label}">
		<xsl:choose>
			<xsl:when test="field_type = 'IM'">
				<xsl:attribute name="style">height:<xsl:value-of select="field_height*1.1"/>em;</xsl:attribute>
			</xsl:when>
			<xsl:when test="field_type = 'ML'">
				<xsl:attribute name="style">height:<xsl:value-of select="(field_height*3) + 1.5"/>em;</xsl:attribute>
			</xsl:when>
			<xsl:when test="field_type = 'WS' ">
				<xsl:attribute name="style">height:<xsl:value-of select="$fieldHeight"/>em;</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="style">height:<xsl:value-of select="$fieldHeight + 1"/>em;</xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<div>
			<xsl:attribute name="class">
				fieldLabel
				<xsl:if test="(is_readonly = 'N') and (is_unique = 'Y')"> fieldLabelUnique</xsl:if>
				<xsl:if test="(is_readonly = 'N') and (is_mandatory = 'Y')"> fieldLabelMandatory</xsl:if>
			</xsl:attribute>
			<xsl:value-of select="field_label" />
		</div>
		<div id="field_{field_name}" >
			<xsl:choose>
			
				<xsl:when test="field_type = 'CH'">
					<xsl:attribute name="style">height:<xsl:value-of select="$fieldHeight"/>em</xsl:attribute>
					<input type="checkbox" />
				</xsl:when>
				
				<xsl:when test="field_type = 'CU' or field_type = 'CD'">
					<xsl:attribute name="style">height:<xsl:value-of select="$fieldHeight"/>em</xsl:attribute>
					<xsl:value-of select="/APPSHORE/API/current_user/currency_id" />&#160;<input type="text" size="10" />
				</xsl:when>
				
				<xsl:when test="field_type = 'DA'">
					<xsl:attribute name="style">height:<xsl:value-of select="$fieldHeight"/>em</xsl:attribute>
					<input type="text" style="width:50%;"/>&#160;<img class="image" src="{$api_image_path}/cal.gif"/>
				</xsl:when> 
				
				<xsl:when test="field_type = 'DD'">
					<xsl:attribute name="style">height:<xsl:value-of select="$fieldHeight"/>em</xsl:attribute>
					<select style="width:50%;">
						<option/>
						<option><xsl:value-of select="field_label" /></option>
						<option><xsl:value-of select="field_label" /></option>
						<option><xsl:value-of select="field_label" /></option>
						<option><xsl:value-of select="field_label" /></option>
					</select>
				</xsl:when>
				
				<xsl:when test="field_type = 'DT'">
					<xsl:attribute name="style">height:<xsl:value-of select="$fieldHeight"/>em</xsl:attribute>
					<input type="text" size="10"/>&#160;
					<img class="image" src="{$api_image_path}/cal.gif"/>&#160;
					<input type="text" size="5"/>&#160;hh:mm
				</xsl:when>
								
				<xsl:when test="field_type = 'IM'">
					<img class="image" src="{$api_image_path}/people.png"/>
				</xsl:when>
				
				<xsl:when test="field_type = 'PE' or field_type = 'PD'">
					<xsl:attribute name="style">height:<xsl:value-of select="$fieldHeight"/>em</xsl:attribute>
					<input class="fieldInputPercentage" type="text" />%
				</xsl:when>
				
				<xsl:when test="field_type = 'ML'">
					<div>
						<xsl:attribute name="style">height:<xsl:value-of select="$fieldHeight + 2"/>em</xsl:attribute>
						<xsl:value-of select="field_label"/>
					</div>
				</xsl:when>
				
				<xsl:when test="field_type = 'MV'">
					<xsl:attribute name="style">height:<xsl:value-of select="$fieldHeight"/>em</xsl:attribute>
					<select style="width:50%;">
						<option/>
						<option><xsl:value-of select="field_label" /></option>
						<option><xsl:value-of select="field_label" /></option>
						<option><xsl:value-of select="field_label" /></option>
						<option><xsl:value-of select="field_label" /></option>
					</select>
				</xsl:when>
				
				<xsl:when test="field_type = 'NU' or field_type = 'ND'">
					<xsl:attribute name="style">height:<xsl:value-of select="$fieldHeight"/>em</xsl:attribute>
					<input type="text" size="10" />
				</xsl:when>
			
				<xsl:when test="field_type = 'RD'">
					<xsl:attribute name="style">height:<xsl:value-of select="$fieldHeight"/>em</xsl:attribute>
					<select>
						<option/>
						<option>0</option>
						<option>1</option>
						<option>2</option>
						<option>3</option>
						<option>4</option>
						<option>5</option>
						<option>6</option>
					</select>&#160;
					<select>
						<option/>
						<option><xsl:value-of select="php:function('lang','days')"/></option>
						<option><xsl:value-of select="php:function('lang','weeks')"/></option>
					</select>
				</xsl:when>
				
				<xsl:when test="field_type = 'RM'">
					<xsl:attribute name="style">height:<xsl:value-of select="$fieldHeight"/>em</xsl:attribute>
					<select>
						<option/>
						<option>1</option>
						<option>2</option>
						<option>3</option>
						<option>4</option>
						<option>5</option>
						<option>10</option>
						<option>15</option>
						<option>20</option>
						<option>30</option>
						<option>45</option>
					</select>&#160;
					<select>
						<option/>
						<option><xsl:value-of select="php:function('lang','minutes')"/></option>
						<option><xsl:value-of select="php:function('lang','hours')"/></option>
						<option><xsl:value-of select="php:function('lang','days')"/></option>
						<option><xsl:value-of select="php:function('lang','weeks')"/></option>
					</select>
				</xsl:when>
				
				<xsl:when test="field_type = 'RR'">
					<xsl:attribute name="style">height:<xsl:value-of select="$fieldHeight"/>em</xsl:attribute>
					<input type="text" readonly="true" style="width:50%;"/>&#160;
					<img class="icon" src="{$api_image_path}/maglass_16.png"/>
				</xsl:when>
				
				<xsl:when test="field_type = 'TI'">
					<xsl:attribute name="style">height:<xsl:value-of select="$fieldHeight"/>em</xsl:attribute>
					<input type="text" size="5"/>&#160;hh:mm
				</xsl:when>
				
				<xsl:when test="field_type = 'TS'">
					<xsl:attribute name="style">height:<xsl:value-of select="$fieldHeight"/>em</xsl:attribute>
					<xsl:value-of select="php:function('lang','Date - Time')"/>&#160;<xsl:value-of select="php:function('lang','by')"/>&#160;<xsl:value-of select="php:function('lang','User name')"/>
				</xsl:when>
				
				<xsl:when test="field_type = 'WS'">
					<xsl:attribute name="style">height:<xsl:value-of select="$fieldHeight - 1"/>em</xsl:attribute>
					www.wwf.org<br/>
					<img src="http://open.thumbshots.org/image.pxf?url=http://www.wwf.org" border="0"/>
				</xsl:when>
				
				<xsl:otherwise>
					<xsl:attribute name="style">height:<xsl:value-of select="$fieldHeight"/>em</xsl:attribute>
					<input type="text" style="width:50%;"/>
				</xsl:otherwise>
				
			</xsl:choose>
		</div>
	</div>
</xsl:template>

</xsl:stylesheet>
