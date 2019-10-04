<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.0'>
<xsl:output indent='yes'/>

<xsl:template match="APP">
    <table height="100%" width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
			<td >
				<xsl:choose>
					<xsl:when test="action/reports = 'popup_nuc_date' ">
					    <xsl:call-template name='nuc_date'/>
					</xsl:when>
					<xsl:when test="action/reports = 'popup_range_date' ">
					    <xsl:call-template name='range_date'/>
					</xsl:when>
					<xsl:when test="action/reports = 'popup_users_scope' ">
					    <xsl:call-template name='users_scope'/>
					</xsl:when>
					<xsl:when test="action/reports = 'no_data_found' ">
					    <xsl:call-template name='no_data_found'/>
					</xsl:when>
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>
<!-- ******************************************************************************************* -->
<xsl:template name='nuc_date'>
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
		<input type='hidden' name='op' value='reports.parameter_popup.popup_nuc_date'/>
		<input type="hidden" name="key" id="key"/>	
		<input type="hidden" name="report_id" value="{recordset/report_id}" />
		<input type="hidden" name="report_popup_type" value="{recordset/report_popup_type}" />
		<input type="hidden" name="col_uc" value="'nuc'"/>
		
		<table class="clearboth formTable">
		<tr><td>
			<div style="padding-bottom:170px;">
				<div class="clearboth formTitle">
					<xsl:value-of select="php:function('lang','Within')"/>
				</div>		
				<div  class="clearboth" style="padding-top:10px;">
					<div class="start_float fieldLabel">
						<input type="radio" id="within_rd" name="within_prd" onclick="radioClick('rd')" value="rd"/>&#160;
					</div>
					<div class="start_float">
						<div class="start_float" style="width:10em">
							<div class="fieldLabelMandatory">
								<xsl:value-of select="php:function('lang','From')"/>
							</div>
							<div class="fieldText">
								<input id="p1" name="p1" size="10"  onclick="radioClear('p')" value=""/>

								<xsl:call-template name="calendar">
									<xsl:with-param name="field">p1</xsl:with-param>
									<xsl:with-param name="label"></xsl:with-param>
								</xsl:call-template>
							</div>
						</div>
						<div class="start_float">
							<div class="fieldLabelMandatory">
								<xsl:value-of select="php:function('lang','To')"/>
							</div>
							<div class="fieldText">
								<input id="p2" name="p2" size="10"  onclick="radioClear('p')" value=""/>
								<xsl:call-template name="calendar">
									<xsl:with-param name="field">p2</xsl:with-param>
									<xsl:with-param name="label"></xsl:with-param>
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
						<div class="fieldLabelMandatory">
							<xsl:value-of select="php:function('lang','Period')"/>
						</div>
						<div class="fieldText">
							<select name="period" onclick="radioClear('rd')">
								<option/>
								<xsl:for-each select = "parameter/parameter_item" >
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
		</td></tr>
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

<!-- ******************************************************************************************* -->
<xsl:template name='range_date'>
<script LANGUAGE="JavaScript" >
<![CDATA[
	function radioClear(tname)
	{
		if (tname=='p')
		{
			$('within_rd').checked=true;
			document.range_date.period.options.selectedIndex=0;
		}
		else
		{
			$('within_p').checked=true;
			document.range_date.p1.value='';
			document.range_date.p2.value='';
		}
	}
	
	function radioClick(from)
	{
		if (from=='p')
		{
			document.range_date.p1.value='';
			document.range_date.p2.value='';
		}
		else
		{
			document.range_date.period.options.selectedIndex=0;
		}
	}
]]>
</script>
	<form id='range_date' name='range_date' method='post'>
		<input type='hidden' name='op' value='reports.parameter_popup.popup_range_date'/>
		<input type="hidden" name="key" id="key"/>	
		<input type="hidden" name="report_id" value="{recordset/report_id}" />
		<input type="hidden" name="report_popup_type" value="{recordset/report_popup_type}" />
		
		<table class="clearboth formTable">
		<tr><td>
			<div class="start_float" style="width:50%;padding-bottom:170px;">
				<div class="clearboth formTitle">
					<xsl:value-of select="php:function('lang','On column')"/>
				</div>		
				<div class="clearboth fieldLabelContainer" style="padding-top: 10px;">
					<div class="start_float fieldText">
						<input class="fieldInputRadio" type="radio" name="col_uc" checked="true" value="u"/>&#160;
					</div>
					<div class="start_float fieldLabel">
						<xsl:value-of select="php:function('lang','Update Date')"/>
					</div>
				</div>
				<div class="clearboth fieldLabelContainer" style="padding-top: 10px;">
					<div class="start_float fieldText">
						<input class="fieldInputRadio" type="radio" name="col_uc" value="c"/>&#160;
					</div>
					<div class="start_float fieldLabel">
						<xsl:value-of select="php:function('lang','Creation Date')"/>
					</div>
				</div>
			</div>
			<div class="end_float" style="width:50%">
				<div class="clearboth formTitle">
					<xsl:value-of select="php:function('lang','Within')"/>
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
									<xsl:with-param name="label"></xsl:with-param>
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
									<xsl:with-param name="label"></xsl:with-param>
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
							<select name="period" onclick="radioClear('rd')">
								<option/>
								<xsl:for-each select = "parameter/parameter_item" >
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
		</td></tr>
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


<!-- ******************************************************************************************* -->
<xsl:template name='users_scope'>

<script LANGUAGE="JavaScript" >
<![CDATA[
	function passUsersList( l2, MyList) 
	{ 
		MyList.value.length = 0;	
	    for ( i=0; i < l2.length ; i++) 
		{
			if ( i > 0 && MyList.value.length && (l2.options[i].selected == true) )	
				MyList.value += ',';	
			if (l2.options[i].selected == true )
					MyList.value +=l2.options[i].value;			
		}
	}	
]]>
</script>
	<form name='users_scope' method='post'>
		<input type='hidden' name='op' value='reports.parameter_popup.popup_users_scope'/>
		<input type="hidden" name="key" id="key"/>	
		<input type="hidden" name="report_id" value="{recordset/report_id}" />
		<input type='hidden' name='selectedusers' value="{/APPSHORE/APP/selected/selected_item/user_id}" />

		<table class="clearboth formTable">
		<tr><td>
			<div class="start_float" style="width:33%">
				<div class="clearboth formTitle">
					<xsl:value-of select="php:function('lang','On column')"/>
				</div>		
				<div class="clearboth fieldLabelContainer" style="padding-top: 10px;">
					<div class="start_float fieldText">
						<input class="fieldInputRadio" type="radio" name="col_uc" checked="true" value="u"/>&#160;
					</div>
					<div class="start_float fieldLabel">
						<xsl:value-of select="php:function('lang','Update Date')"/>
					</div>
				</div>
				<div class="clearboth fieldLabelContainer" style="padding-top: 10px;">
					<div class="start_float fieldText">
						<input class="fieldInputRadio" type="radio" name="col_uc" value="c"/>&#160;
					</div>
					<div class="start_float fieldLabel">
						<xsl:value-of select="php:function('lang','Creation Date')"/>
					</div>
				</div>
			</div>
			<div class="start_float" style="width:33%">
			    <div class="clearboth formTitle">
					<xsl:value-of select="php:function('lang','Within')"/>
				</div>		
				<div class="fieldLabel">
					<xsl:value-of select="php:function('lang','Period')"/>
				</div>
				<div class="fieldText">
					<select name="period">
						<option/>
						<xsl:for-each select = "parameter/parameter_item" >
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
			<div class="end_float" style="width:33%">
			    <div class="clearboth formTitle">
					<xsl:value-of select="php:function('lang','For selected')"/>
				</div>		
				<div class="fieldLabel">
					<xsl:value-of select="php:function('lang','Sales representative')"/>
				</div>
				<div class="fieldText">
					<select style='width:200px' size="10" name="list1"  multiple="true" >
						<xsl:for-each select = "scope_users/scope_users_item" >
							<option value="{user_id}">
								<xsl:value-of select="full_name"/> - <xsl:value-of select="user_name"/>
							</option>
						</xsl:for-each>
					</select>
				</div>
			</div>
		</td></tr>
		</table>
								
		<div class="clearboth formBar">
			<input type="submit" class="formBarButton" id="Continue" name="Continue" onclick="$('key').value=this.name;passUsersList(list1,selectedusers);">
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

<xsl:template name='no_data_found'>
	<script language="JavaScript" type="text/javascript" >
		document.observe("dom:loaded", function() {
			setTimeout('popupClose()',1);
		});
	</script>
	
</xsl:template>


</xsl:stylesheet>
