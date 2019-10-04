<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP[action/invoices]">
    <table width="100%" cellSpacing="0" cellPadding="0"  border="0" >
		<tr width="100%" valign="top">
			<td class="left_panel" id="left_panel" style="display:{/APPSHORE/API/cookie/left_panel}">
			    <xsl:call-template name="verticalMenus">		    
					<xsl:with-param name="appName">administration</xsl:with-param>
					<xsl:with-param name="appLabel">Administration</xsl:with-param>
				</xsl:call-template>	
			</td>
            <td id="right_panel" class="right_panel">
				<xsl:choose>
					<xsl:when test="action/invoices = 'search'">
				    	<xsl:call-template name="invoices_search"/>
				    	<xsl:call-template name="invoices_list"/>
					</xsl:when>
					<xsl:when test="action/invoices = 'view'">				
				    	<xsl:call-template name="invoice_view"/>
				    	<xsl:call-template name="order_per_invoice"/>	    	
					</xsl:when>							
				</xsl:choose>
			</td>
		</tr>
	</table>
</xsl:template>


<xsl:template name="invoices_search">
	<form name="invoice_search" method="post">
	<input type="hidden" name="op" value="administration.billing_invoices.search"/>

	<xsl:call-template name="headerSearchForm">
		<xsl:with-param name="appLabel">Invoices</xsl:with-param>
	</xsl:call-template>	

	<table cellSpacing="1" cellPadding="1" border="0" width="100%" valign="top">
		<tr  width="100%">
			<td ><xsl:value-of select="php:function('lang','Creation')"/></td>				
			<td ><xsl:value-of select="php:function('lang','Invoice Id')"/></td>	
			<td ><xsl:value-of select="php:function('lang','Invoice status')"/></td>	
			<td ><xsl:value-of select="php:function('lang','Order Id')"/></td>	
		</tr>
		<tr >
			<td >
				<select name="creation">
								<option></option>				
					<xsl:for-each select = "creations/creations_item">
						<xsl:choose>
							<xsl:when test="creation = /APPSHORE/APP/recordset/creation">
								<option selected="true">
									<xsl:attribute name="value"><xsl:value-of select="creation" /></xsl:attribute>
									<xsl:value-of select="creation_name"/>
								</option>
							</xsl:when>
							<xsl:otherwise>
								<option>
									<xsl:attribute name="value"><xsl:value-of select="creation" /></xsl:attribute>
									<xsl:value-of select="creation_name"/>
								</option>
							</xsl:otherwise>
						</xsl:choose>							
					</xsl:for-each>
				</select>
			</td>			
			<td >
				<input name="invoice_id" size="15">
					<xsl:attribute name="value" >
						<xsl:value-of select="/APPSHORE/APP/recordset/invoice_id" />
					</xsl:attribute>
				</input>
			</td>	
			<td >
				<select name="invoice_status">
								<option></option>				
					<xsl:for-each select = "invoice_statuses/invoice_statuses_item">
						<xsl:choose>
							<xsl:when test="invoice_status = /APPSHORE/APP/recordset/invoice_status">
								<option selected="true">
									<xsl:attribute name="value"><xsl:value-of select="invoice_status" /></xsl:attribute>
									<xsl:value-of select="invoice_status_name"/>
								</option>
							</xsl:when>
							<xsl:otherwise>
								<option>
									<xsl:attribute name="value"><xsl:value-of select="invoice_status" /></xsl:attribute>
									<xsl:value-of select="invoice_status_name"/>
								</option>
							</xsl:otherwise>
						</xsl:choose>							
					</xsl:for-each>
				</select>
			</td>
			<td >
				<input name="order_id" size="15">
					<xsl:attribute name="value" >
						<xsl:value-of select="/APPSHORE/APP/recordset/order_id" />
					</xsl:attribute>
				</input>
			</td>													
		</tr>
	</table>
    <xsl:call-template name="footerSearchForm">
		<xsl:with-param name="thisForm">invoice_search</xsl:with-param>
	</xsl:call-template> 
	</form>	
</xsl:template>


<xsl:template name="invoices_list">

	<form name="invoice_listing" method="post" >
	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Invoices</xsl:with-param>
		<xsl:with-param name="appName">invoices_list</xsl:with-param>		
	</xsl:call-template>
	<div id="invoices_list">
		
	<input type="hidden" name="op" value="administration.billing_invoices.search"/>
	<xsl:for-each select = "recordset/node()">	
		<xsl:if test="name()">	
			<input type="hidden" name="{name()}" value="{node()}" />
		</xsl:if>
	</xsl:for-each>	
							
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr class="label" align="center">		
			<td>&#160;</td>	
			<td>
				<a href="javascript: orderby(document.invoice_listing, 'created');">
                    <xsl:value-of select="php:function('lang','Creation')"/>
                </a>
			</td>	
			<td>
				<a href="javascript: orderby( document.invoice_listing, 'invoice_id');" >
                    <xsl:value-of select="php:function('lang','Invoice Id')"/>
                </a>
			</td>							
			<td>
                <xsl:value-of select="php:function('lang','Product')"/>
 			</td>
			<td>
				<a href="javascript: orderby( document.invoice_listing, 'invoice_status');">
                    <xsl:value-of select="php:function('lang','Status')"/>
                </a>
			</td>		
			<td><xsl:value-of select="php:function('lang','Amount')"/></td>						
			<td>
				<a href="javascript: orderby( document.invoice_listing, 'order_id');" >
                    <xsl:value-of select="php:function('lang','Order Id')"/>
                </a>
			</td>	
			<td>
				<a href="javascript: orderby( document.invoice_listing, 'first_month');" >
                    <xsl:value-of select="php:function('lang','First month')"/>
                </a>
			</td>			</tr>
		<xsl:for-each select = "invoices/invoices_item">
			<tr class="unselectedtext" align="center" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">			
				<td width="2%" align="center">
					<a href="{$baseurl}&amp;op=administration.billing_invoices.view&amp;invoice_id={invoice_id}">
	                    <img class="image" src="{$api_image_path}/view.png"/>
					</a>							
				</td>		
				<td >
					<xsl:value-of select="created"/>
				</td>	
				<td  align="center">
					<a href="{$baseurl}&amp;op=administration.billing_invoices.view&amp;invoice_id={invoice_id}">
						<xsl:value-of select="invoice_id"/>
					</a>
				</td>										
				<td align="left">
					<a href="{$baseurl}&amp;op=administration.billing_invoices.view&amp;invoice_id={invoice_id}">
						<xsl:value-of select="product_name"/>
					</a>
				</td>
				<td >
					<xsl:value-of select="invoice_status_name"/>
				</td>	
				<td >
					<xsl:value-of select="amount"/>
				</td>								
				<td  align="center">
					<a href="{$baseurl}&amp;op=administration.billing_orders.view&amp;order_id={order_id}">
						<xsl:value-of select="order_id"/>
					</a>
				</td>	
				<td width="*">
					<xsl:value-of select="first_month"/>
				</td>																													
			</tr>	
		</xsl:for-each>
	</table>   
    <xsl:call-template name="footerListForm">
		<xsl:with-param name="thisForm">invoice_listing</xsl:with-param>
	</xsl:call-template>    
	</div>
	</form>

</xsl:template>

<xsl:template name="invoices_per_order">
	<br/>
	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Invoices</xsl:with-param>
	</xsl:call-template>		
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr class="label" align="center">		
			<td>&#160;</td>	
			<td><xsl:value-of select="php:function('lang','Creation')"/></td>				
			<td><xsl:value-of select="php:function('lang','Invoice Id')"/></td>
			<td><xsl:value-of select="php:function('lang','Invoice status')"/></td>		
			<td><xsl:value-of select="php:function('lang','Amount')"/></td>				
			<td><xsl:value-of select="php:function('lang','First month')"/></td>				
		</tr>
		<xsl:for-each select = "invoices/invoices_item">
			<tr class="unselectedtext" align="center" onMouseOver="this.className = 'selectedtext'" onMouseOut="this.className = 'unselectedtext'">			
				<td width="2%" align="center">
					<a href="{$baseurl}&amp;op=administration.billing_invoices.view&amp;invoice_id={invoice_id}">
	                    <img class="image" src="{$api_image_path}/view.png"/>
					</a>							
				</td>		
				<td width="*">
					<xsl:value-of select="created"/>
				</td>						
				<td width="*" align="center">
					<a href="{$baseurl}&amp;op=administration.billing_invoices.view&amp;invoice_id={invoice_id}">
						<xsl:value-of select="invoice_id"/>
					</a>
				</td>
				<td width="*">
					<xsl:value-of select="invoice_status_name"/>
				</td>	
				<td width="*">
					<xsl:value-of select="amount"/>
				</td>
				<td width="*">
					<xsl:value-of select="first_month"/>
				</td>																																			
			</tr>	
		</xsl:for-each>
	</table>   

</xsl:template>


<xsl:template name="invoice_view">
	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Invoice</xsl:with-param>
		<xsl:with-param name="appName">invoice</xsl:with-param>		
	</xsl:call-template>
	<table border="0" width="100%" cellpadding="1" cellspacing="1">
		<tr>
			<td align="right" class="label" width="20%"><xsl:value-of select="php:function('lang','Invoice Id')"/>:</td>
			<td align="left" class="field"  width="30%"><xsl:value-of select="invoice/invoice_id"/></td>		
			<td align="right" class="label" width="20%"><xsl:value-of select="php:function('lang','Invoice status')"/>:</td>
			<td align="left" class="field"  width="30%"><xsl:value-of select="invoice/invoice_status_name"/></td>
		</tr>		
		<tr>
			<td align="right" class="label" ><xsl:value-of select="php:function('lang','Amount')"/>:</td>
			<td align="left" class="field"  ><xsl:value-of select="invoice/amount"/></td>
			<td align="right" class="label" ><xsl:value-of select="php:function('lang','First month')"/>:</td>
			<td align="left" class="field"  ><xsl:value-of select="php:function('lang','<xsl:value-of select="invoice/first_month"/>')"/></td>

			
		</tr>
		<tr>
			<td class="label" align="right" ><xsl:value-of select="php:function('lang','Creation')"/>:</td>
			<td align="left" class="field"  ><xsl:value-of select="invoice/created"/></td>		
			<td align="right" class="label" ><xsl:value-of select="php:function('lang','Last update')"/>:</td>
			<td align="left" class="field"  ><xsl:value-of select="invoice/updated"/></td>
		</tr>		
	</table>

</xsl:template>


</xsl:stylesheet>
