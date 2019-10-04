<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.0'>
<xsl:output indent='yes'/>

<xsl:template match="APP">
    <table height="300px" width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
			<td >
				<xsl:choose>
					<xsl:when test="action/reports = 'languagestarscms.start_popup' ">
					    <xsl:call-template name='fc_date'/>
					</xsl:when>
					<xsl:when test="action/reports = 'languagestarscms.start_popup_2' ">
					    <xsl:call-template name='original_contact_date'/>
					</xsl:when>
					<xsl:when test="action/reports = 'languagestarscms.start_popup_4' ">
					    <xsl:call-template name='recent_contact_date'/>
					</xsl:when>
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name='fc_date'>
<script LANGUAGE="JavaScript" >
<![CDATA[
	function radioClear(tname)
	{
		if (tname=='p')
		{
			$('within_rd').checked=true;
			document.nuc_date.period.options.selectedIndex=0;
		}
		else
		{
			$('within_p').checked=true;
			document.nuc_date.p1.value='';
			document.nuc_date.p2.value='';
		}
	}
	
	function radioClick(from)
	{
		if (from=='p')
		{
			document.nuc_date.p1.value='';
			document.nuc_date.p2.value='';
		}
		else
		{
			document.nuc_date.period.options.selectedIndex=0;
		}
	}
]]>
</script>

	
	<form id='nuc_date' name='nuc_date' method='post'>
		<input type='hidden' name='op' value='reports.languagestarscms.start_popup'/>
		<input type="hidden" name="key" id="key"/>	
		<input type="hidden" name="report_id" value="{recordset/report_id}" />
		<input type="hidden" name="report_popup_type" value="{recordset/report_popup_type}" />
		<input type="hidden" name="col_uc" value="{recordset/col_uc}"/>
		
		<table class="clearboth formTable">
			<tr>
				<td>
					<div style="padding-bottom:170px;">
						<div class="clearboth formTitle">
							<xsl:value-of select="php:function('lang','Free class date')"/>
						</div>		
						<div  class="clearboth" style="padding-top:10px;">
							<div class="start_float fieldLabel">
								<input type="radio" id="within_rd" name="within_prd" onclick="radioClick('rd')" value="rd"/>&#160;
							</div>
							<div class="start_float">
								<div class="start_float" style="width:10em">
									<div class="fieldLabel">
										<xsl:value-of select="php:function('lang','From')"/>
									</div>
									<div class="fieldText">
										<input id="p1" name="p1" size="10"  onclick="radioClear('p')" value=""/>

										<xsl:call-template name="calendar">
											<xsl:with-param name="field">p1</xsl:with-param>
										</xsl:call-template>
									</div>
								</div>
								<div class="start_float">
									<div class="fieldLabel">
										<xsl:value-of select="php:function('lang','To')"/>
									</div>
									<div class="fieldText">
										<input id="p2" name="p2" size="10"  onclick="radioClear('p')" value=""/>
										<xsl:call-template name="calendar">
											<xsl:with-param name="field">p2</xsl:with-param>
									</xsl:call-template>
									</div>
								</div>
							</div>
						</div>
						<div class="clearboth" style="padding-top: 10px;">
							<div class="start_float fieldLabel">
								<input type="radio" id="within_p" name="within_prd" checked="1" onclick="radioClick('p')" value="p"/>&#160;
							</div>
							<div class="start_float">
								<div class="fieldLabel">
									<xsl:value-of select="php:function('lang','Period')"/>
								</div>
								<div class="fieldText">
									<select name="period" onfocus="radioClear('rd')">
										<option/>
										<xsl:for-each select = "/APPSHORE/APP/parameter/parameter_item" >
											<option value="{period}">
												<xsl:if test="period = /APPSHORE/APP/recordset/period">
													<xsl:attribute name="selected" select="'true'"/>
												</xsl:if>
												<xsl:value-of select="php:functionString('lang',period_name)"/>
											</option>
										</xsl:for-each>
									</select>
								</div>
							</div>
						</div>
					</div>
				</td>
			</tr>
		</table>
								
		<div class="clearboth formBar">
			<input type="submit" class="formBarButton" id="Continue" name="Continue" onclick="$('key').value=this.name">
				<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Continue')"/></xsl:attribute>
			</input>&#160;
			<input type="submit" class="formBarButton" id="Clear" name="Clear" onclick="$('key').value=this.name;passBackTuple('',0);popupClose();">
				<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Clear')"/></xsl:attribute>
			</input>&#160;
			<input type="button" class="formBarButton" onclick="popupClose();">
				<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
			</input>
		</div>
	</form>
	
</xsl:template>

<xsl:template name='original_contact_date'>
<script LANGUAGE="JavaScript" >
<![CDATA[
	function radioClear(tname)
	{
		if (tname=='p')
		{
			$('within_rd').checked=true;
			document.nuc_date.period.options.selectedIndex=0;
		}
		else
		{
			$('within_p').checked=true;
			document.nuc_date.p1.value='';
			document.nuc_date.p2.value='';
		}
	}
	
	function radioClick(from)
	{
		if (from=='p')
		{
			document.nuc_date.p1.value='';
			document.nuc_date.p2.value='';
		}
		else
		{
			document.nuc_date.period.options.selectedIndex=0;
		}
	}
]]>
</script>

	
	<form id='nuc_date' name='nuc_date' method='post'>
		<input type='hidden' name='op' value='reports.languagestarscms.start_popup_2'/>
		<input type="hidden" name="key" id="key"/>	
		<input type="hidden" name="report_id" value="{recordset/report_id}" />
		<input type="hidden" name="report_popup_type" value="{recordset/report_popup_type}" />
		<input type="hidden" name="col_uc" value="{recordset/col_uc}"/>
		
		<table class="clearboth formTable">
			<tr>
				<td>
					<div style="padding-bottom:170px;">
						<div class="clearboth formTitle">
							<xsl:value-of select="php:function('lang','Original contact date')"/>
						</div>		
						<div  class="clearboth" style="padding-top:10px;">
							<div class="start_float fieldLabel">
								<input type="radio" id="within_rd" name="within_prd" onclick="radioClick('rd')" value="rd"/>&#160;
							</div>
							<div class="start_float">
								<div class="start_float" style="width:10em">
									<div class="fieldLabel">
										<xsl:value-of select="php:function('lang','From')"/>
									</div>
									<div class="fieldText">
										<input id="p1" name="p1" size="10"  onclick="radioClear('p')" value=""/>

										<xsl:call-template name="calendar">
											<xsl:with-param name="field">p1</xsl:with-param>
										</xsl:call-template>
									</div>
								</div>
								<div class="start_float">
									<div class="fieldLabel">
										<xsl:value-of select="php:function('lang','To')"/>
									</div>
									<div class="fieldText">
										<input id="p2" name="p2" size="10"  onclick="radioClear('p')" value=""/>
										<xsl:call-template name="calendar">
											<xsl:with-param name="field">p2</xsl:with-param>
									</xsl:call-template>
									</div>
								</div>
							</div>
						</div>
						<div class="clearboth" style="padding-top: 10px;">
							<div class="start_float fieldLabel">
								<input type="radio" id="within_p" name="within_prd" checked="1" onclick="radioClick('p')" value="p"/>&#160;
							</div>
							<div class="start_float">
								<div class="fieldLabel">
									<xsl:value-of select="php:function('lang','Period')"/>
								</div>
								<div class="fieldText">
									<select name="period" onfocus="radioClear('rd')">
										<option/>
										<xsl:for-each select = "/APPSHORE/APP/parameter/parameter_item" >
											<option value="{period}">
												<xsl:if test="period = /APPSHORE/APP/recordset/period">
													<xsl:attribute name="selected" select="'true'"/>
												</xsl:if>
												<xsl:value-of select="php:functionString('lang',period_name)"/>
											</option>
										</xsl:for-each>
									</select>
								</div>
							</div>
						</div>
					</div>
				</td>
			</tr>
		</table>
								
		<div class="clearboth formBar">
			<input type="submit" class="formBarButton" id="Continue" name="Continue" onclick="$('key').value=this.name">
				<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Continue')"/></xsl:attribute>
			</input>&#160;
			<input type="submit" class="formBarButton" id="Clear" name="Clear" onclick="$('key').value=this.name;passBackTuple('',0);popupClose();">
				<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Clear')"/></xsl:attribute>
			</input>&#160;
			<input type="button" class="formBarButton" onclick="popupClose();">
				<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
			</input>
		</div>
	</form>
	
</xsl:template>


<xsl:template name='recent_contact_date'>
<script LANGUAGE="JavaScript" >
<![CDATA[
	function radioClear(tname)
	{
		if (tname=='p')
		{
			$('within_rd').checked=true;
			document.nuc_date.period.options.selectedIndex=0;
		}
		else
		{
			$('within_p').checked=true;
			document.nuc_date.p1.value='';
			document.nuc_date.p2.value='';
		}
	}
	
	function radioClick(from)
	{
		if (from=='p')
		{
			document.nuc_date.p1.value='';
			document.nuc_date.p2.value='';
		}
		else
		{
			document.nuc_date.period.options.selectedIndex=0;
		}
	}
]]>
</script>

	
	<form id='nuc_date' name='nuc_date' method='post'>
		<input type='hidden' name='op' value='reports.languagestarscms.start_popup_4'/>
		<input type="hidden" name="key" id="key"/>	
		<input type="hidden" name="report_id" value="{recordset/report_id}" />
		<input type="hidden" name="report_popup_type" value="{recordset/report_popup_type}" />
		<input type="hidden" name="col_uc" value="{recordset/col_uc}"/>
		
		<table class="clearboth formTable">
			<tr>
				<td>
					<div style="padding-bottom:170px;">
						<div class="clearboth formTitle">
							<xsl:value-of select="php:function('lang','Recent contact date')"/>
						</div>		
						<div  class="clearboth" style="padding-top:10px;">
							<div class="start_float fieldLabel">
								<input type="radio" id="within_rd" name="within_prd" onclick="radioClick('rd')" value="rd"/>&#160;
							</div>
							<div class="start_float">
								<div class="start_float" style="width:10em">
									<div class="fieldLabel">
										<xsl:value-of select="php:function('lang','From')"/>
									</div>
									<div class="fieldText">
										<input id="p1" name="p1" size="10"  onclick="radioClear('p')" value=""/>

										<xsl:call-template name="calendar">
											<xsl:with-param name="field">p1</xsl:with-param>
										</xsl:call-template>
									</div>
								</div>
								<div class="start_float">
									<div class="fieldLabel">
										<xsl:value-of select="php:function('lang','To')"/>
									</div>
									<div class="fieldText">
										<input id="p2" name="p2" size="10"  onclick="radioClear('p')" value=""/>
										<xsl:call-template name="calendar">
											<xsl:with-param name="field">p2</xsl:with-param>
									</xsl:call-template>
									</div>
								</div>
							</div>
						</div>
						<div class="clearboth" style="padding-top: 10px;">
							<div class="start_float fieldLabel">
								<input type="radio" id="within_p" name="within_prd" checked="1" onclick="radioClick('p')" value="p"/>&#160;
							</div>
							<div class="start_float">
								<div class="fieldLabel">
									<xsl:value-of select="php:function('lang','Period')"/>
								</div>
								<div class="fieldText">
									<select name="period" onfocus="radioClear('rd')">
										<option/>
										<xsl:for-each select = "/APPSHORE/APP/parameter/parameter_item" >
											<option value="{period}">
												<xsl:if test="period = /APPSHORE/APP/recordset/period">
													<xsl:attribute name="selected" select="'true'"/>
												</xsl:if>
												<xsl:value-of select="php:functionString('lang',period_name)"/>
											</option>
										</xsl:for-each>
									</select>
								</div>
							</div>
						</div>
					</div>
				</td>
			</tr>
		</table>
								
		<div class="clearboth formBar">
			<input type="submit" class="formBarButton" id="Continue" name="Continue" onclick="$('key').value=this.name">
				<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Continue')"/></xsl:attribute>
			</input>&#160;
			<input type="submit" class="formBarButton" id="Clear" name="Clear" onclick="$('key').value=this.name;passBackTuple('',0);popupClose();">
				<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Clear')"/></xsl:attribute>
			</input>&#160;
			<input type="button" class="formBarButton" onclick="popupClose();">
				<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Cancel')"/></xsl:attribute>
			</input>
		</div>
	</form>
	
</xsl:template>

</xsl:stylesheet>
