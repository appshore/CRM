<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP">
   <table height="100%" width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
			<td >
				<xsl:choose>
					<xsl:when test="action/sales = 'edit'">
				    	<xsl:call-template name="sale_edit"/>
					</xsl:when>	
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name="sale_edit">

	<div class="formTitle">
		<xsl:value-of select="php:function('lang','Team')"/>:&#160;
		<xsl:choose>
			<xsl:when test="string-length(/APPSHORE/APP/team/team_id)">
                <xsl:value-of select="/APPSHORE/APP/team/team_name"/>
			</xsl:when>
			<xsl:otherwise>
				<span style="color:black;font-weight:normal;font-style:italic"><xsl:value-of select="php:function('lang','New')"/></span>
			</xsl:otherwise>
		</xsl:choose>
	</div>


	<form name='sale_edit' method='post'>
		<input type="hidden" name="op" id="op" value="administration.sales_popup.edit"/>
		<input type='hidden' name='team_id' id="team_id" value="{/APPSHORE/APP/team/team_id}"/>
		<input type="hidden" name="key" id="key"/>
		
		<xsl:call-template name="buttons_sales_team"/>

		<div class="formTable" style="width:99%">
			<div class="fieldLabelContainer">
				<div class="fieldLabel fieldLabelMandatory">
					<xsl:value-of select="php:function('lang','Sales team')"/>
				</div>
				<div>
					<input class="fieldInputText" type="text" id="team_name" name="team_name" >
						<xsl:attribute name="value">
							<xsl:value-of select="/APPSHORE/APP/team/team_name" />
						</xsl:attribute>
					</input>
				</div>
			</div>				
			<div class="fieldLabelContainer">
				<div class="fieldLabel">
					<xsl:value-of select="php:function('lang','Main sales team')"/>
				</div>
				<div>
					<select class="fieldInputSelect" name="team_top_id" id="team_top_id">
							<option value="0"/>
						<xsl:for-each select = "/APPSHORE/APP/teams/teams_item">
							<option value="{team_id}">
						       <xsl:if test="team_id = /APPSHORE/APP/team/team_top_id">
							        <xsl:attribute name="selected" value="true"/>
							    </xsl:if>
								<xsl:call-template name="loop">
									<xsl:with-param name="i" select="'1'"/>
									<xsl:with-param name="count" select="level"/>
								</xsl:call-template>
								<xsl:value-of select="team_name" />
							</option>
						</xsl:for-each>	
					</select>
				</div>
			</div>
			<div class="fieldLabelContainer">
				<div class="fieldLabel">
					<xsl:value-of select="php:function('lang','Manager')"/>
				</div>
				<div>
					<select class="fieldInputSelect" name="manager_id" id="manager_id">
							<option/>
						<xsl:for-each select = "/APPSHORE/APP/users/users_item">
							<option value="{user_id}">
								<xsl:if test="user_id = /APPSHORE/APP/team/manager_id">
									<xsl:attribute name="selected" value="true"/>
							    </xsl:if>
								<xsl:value-of select="full_name" />
							</option>
						</xsl:for-each>	
					</select>
				</div>
			</div>
			
		</div>		
		
		<xsl:call-template name="buttons_sales_team"/>

	</form>

</xsl:template>


<xsl:template name="buttons_sales_team">	
	<div class="formBar">	
		<input type="submit" class="formBarButton" id="Save" name="Save" onclick="document.sale_edit.key.value='Save';">
	   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Save the record')"/></xsl:attribute>                    
	        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Save')"/></xsl:attribute>
        </input>&#160;        	
		<input type="reset" class="formBarButton">
	   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Reset')"/></xsl:attribute>                    
	        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Reset')"/></xsl:attribute>
        </input>&#160;
		<xsl:choose>
			<xsl:when test="save = 'true'">
				<input type="button" class="formBarButton" id="Quit" name="Quit" onclick="top.location.reload();popupClose();">
			   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Quit')"/></xsl:attribute>                    
			        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Quit')"/></xsl:attribute>
			    </input>
			</xsl:when>
			<xsl:otherwise>					
				<input type="button" class="formBarButton" id="Cancel" name="Cancel" onclick="popupClose();">
			   		<xsl:attribute name="title"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>                    
			        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
			    </input>
			</xsl:otherwise>
		</xsl:choose>
	</div>			
</xsl:template>

<xsl:template name="loop">
	<xsl:param name="i"/>
	<xsl:param name="count"/>
	<xsl:if test="$i &lt; $count">
<!--    body of the loop goes here    -->
		&#160;&#160;&#160;&#160;&#160;
<!--    end of body of the loop   -->
		<xsl:call-template name="loop">
			<xsl:with-param name="i" select="$i + 1"/>
			<xsl:with-param name="count" select="$count"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
