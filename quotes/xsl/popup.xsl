<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.0'>
<xsl:output indent='yes'/>

<xsl:template match="APP">
    <table height="100%" width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
			<td >
				<xsl:choose>
					<xsl:when test="action/quotes = 'search'">
					    <xsl:call-template name='quotes_popup_search'/>
					    <xsl:call-template name='quotes_popup_list'/>
					</xsl:when>
					<xsl:when test="action/quotes = 'popup_view'">
					    <xsl:call-template name='quotes_popup_view'/>
					</xsl:when>					
					<xsl:when test="action/quotes = 'print'">
				    	<xsl:call-template name="custom_view">
				    		<xsl:with-param name="appName">quotes</xsl:with-param>
				    		<xsl:with-param name="appLabel">Quote</xsl:with-param>
				    		<xsl:with-param name="nodeName">quote</xsl:with-param>
				    		<xsl:with-param name="recordId">quote_id</xsl:with-param>		
				    		<xsl:with-param name="recordName">quote_name</xsl:with-param>					    		
				    	</xsl:call-template>				    	
					</xsl:when>					
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name='quotes_popup_search'>

	<form name='quote_popup_search' method='post'>
	<input type='hidden' name='op' value='quotes.popup.searchQuote'/>
	<table class="popupcontent" cellSpacing='1' cellPadding='1' border='0' width='100%' valign='top'>
		<tr align='left'>
			<td >
				<xsl:value-of select="php:function('lang','Quote')"/>
			</td>
			<td >
				<xsl:value-of select="php:function('lang','Owner')"/>
			</td>				
		</tr>
		<tr align='left'>
			<td >
				<input name='subject' size="30">
					<xsl:attribute name='value'>
						<xsl:value-of select='/APPSHORE/APP/recordset/subject' />
					</xsl:attribute>
				</input>
			</td>
			<td>
				<select name="user_id"  >
								<option></option>
					<xsl:for-each select = "users/users_item" >
						<xsl:choose>
							<xsl:when test="user_id = /APPSHORE/APP/recordset/user_id">
								<option selected="true">
									<xsl:attribute name="value"><xsl:value-of select="user_id" /></xsl:attribute>
									<xsl:value-of select="user_name"/>
								</option>
							</xsl:when>
							<xsl:otherwise>
								<option>
									<xsl:attribute name="value"><xsl:value-of select="user_id" /></xsl:attribute>
									<xsl:value-of select="user_name"/>
								</option>
							</xsl:otherwise>
						</xsl:choose>			
					</xsl:for-each>
				</select>
			</td>					
		</tr>
	</table>
	<xsl:call-template name="footerSearchForm">
		<xsl:with-param name="thisForm">quote_popup_search</xsl:with-param>
	</xsl:call-template>	
	</form>
</xsl:template>

<xsl:template name='quotes_popup_list'>
	<form name='quote_popup_listing' method='post' >
	<input type='hidden' name='op' value='quotes.popup.searchQuote'/>
	<xsl:for-each select = "recordset/node()">	
		<xsl:if test="name()">	
			<input type="hidden" name="{name()}" value="{node()}" />
		</xsl:if>
	</xsl:for-each>	

	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel"><xsl:value-of select="php:function('lang','Quotes')"/></xsl:with-param>
	</xsl:call-template>

	<table class="popupcontent" border='0' cellpadding='1' cellspacing='1' width='100%'>
		<tr class="label" align='left' >
			<td>
				<a href="javascript: orderby(document.quote_popup_listing, 'subject');"><xsl:value-of select="php:function('lang','Subject')"/></a>
			</td>
			<td>
				<a href="javascript: orderby(document.quote_popup_listing, 'user_name');"><xsl:value-of select="php:function('lang','Owner')"/></a>
			</td>
			<td>
				<a href="javascript: orderby(document.quote_popup_listing, 'account_name');"><xsl:value-of select="php:function('lang','Account')"/></a>
			</td>
		</tr>
		<xsl:for-each select = 'quotes/quotes_item'>
			<tr  class='unselectedtext' onMouseOver='this.className ="selectedtext"' onMouseOut='this.className = "unselectedtext"'>
				<td width="*">
					<a href="javascript:passBackTuple('{subject}','{quote_id}');popupClose();">
						<xsl:value-of select="subject"/>
					</a>
				</td>
				<td width="*">
					<xsl:value-of select="user_name"/>
				</td>
				<td width="*">
					<xsl:value-of select="account_name"/>
				</td>
			</tr>
		</xsl:for-each>
	</table>
   
	<xsl:call-template name="footerPopupList">
		<xsl:with-param name="thisForm">quote_popup_listing</xsl:with-param>
	</xsl:call-template>&#160;
	<input type='button' class="button" onclick="passBackTuple('',0);">
        <xsl:attribute name="value">
            <xsl:value-of select="php:function('lang','Clear')"/>
        </xsl:attribute>
    </input>&#160;
	<input type='button' class="button" onclick="popupClose();">
        <xsl:attribute name="value">
            <xsl:value-of select="php:function('lang','Cancel')"/>
        </xsl:attribute>
    </input>
	</form>
</xsl:template>

<xsl:template name="quotes_popup_view">
		
	<table border="0" width="100%" height="140px" cellpadding="1" cellspacing="1">
		<tr>
			<td align="right" class="label" width="25%"><xsl:value-of select="php:function('lang','Due Date')"/>:</td>
			<td align="left" class="field" width="25%">
                <xsl:value-of select="quote/due_date"/>
            </td>
			<td align="right" class="label" width="25%"><xsl:value-of select="php:function('lang','Status')"/>:</td>
			<td align="left" class="field" width="25%"><xsl:value-of select="quote/status_name"/></td>
		</tr>
        <tr>  
			<td align="right" class="label"><xsl:value-of select="php:function('lang','Priority')"/>:</td>
			<td align="left" class="field" colspan="3"><xsl:value-of select="quote/priority_name"/></td>
		</tr>
	    <tr>
		    <td align="right" class="label"><xsl:value-of select="php:function('lang','Related to')"/>:</td>
		    <td align="left" class="field" colspan="3"><xsl:value-of select="quote/app_label"/>&#160;
				<a href="{$baseurl}&amp;op={quote/table_name}.base.view&amp;{quote/record_id_name}={quote/related_record_id}" target="_top">
					<xsl:value-of select="quote/related_name"/>
			    </a>
            </td>
        </tr>				
		<tr>
			<td align="right" class="label" ><xsl:value-of select="php:function('lang','Note')"/>:</td>
			<td align="left" class="field" colspan="3">
				<textarea class="textarea" style="height:80px;width:450px" readonly="true" name="note" >
					<xsl:value-of select="quote/note" />
				</textarea>
			</td>
		</tr>
	</table>
</xsl:template>

</xsl:stylesheet>
