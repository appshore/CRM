<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="APP[action/subscription]">
	<xsl:choose>
		<xsl:when test="action/subscription = 'close_confirmed'">
	    	<xsl:call-template name="close_confirmed"/>
		</xsl:when>
		<xsl:otherwise>
		    <table width="100%" cellSpacing="0" cellPadding="0"  bdata="0" >
				<tr width="100%" valign="top">
					<td class="left_panel" id="left_panel" style="display:{/APPSHORE/API/cookie/left_panel}">
					    <xsl:call-template name="verticalMenus">		    
							<xsl:with-param name="appName">administration</xsl:with-param>
							<xsl:with-param name="appLabel">Administration</xsl:with-param>
						</xsl:call-template>	
					</td>
		            <td id="right_panel" class="right_panel">
						<xsl:choose>
							<xsl:when test="action/subscription = 'close'">
						    	<xsl:call-template name="close"/>
							</xsl:when>
							<xsl:when test="action/subscription = 'upgrade'">
						    	<xsl:call-template name="upgrade"/>
							</xsl:when>
							<xsl:when test="action/subscription = 'upgrade_success'">
						    	<xsl:call-template name="upgrade_success"/>
							</xsl:when>
							<xsl:when test="action/subscription = 'upgrade_cancel'">
						    	<xsl:call-template name="upgrade_cancel"/>
							</xsl:when>																				
							<xsl:when test="action/subscription = 'GoogleWallet'">				
						    	<xsl:call-template name="GoogleWallet"/>
							</xsl:when>	
							<xsl:when test="action/subscription = 'Paypal'">				
						    	<xsl:call-template name="Paypal"/>
							</xsl:when>	
							<xsl:when test="action/subscription = 'beta'">
						    	<xsl:call-template name="beta"/>
							</xsl:when>
						</xsl:choose>
					</td>
				</tr>
			</table>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="beta">

	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel"><xsl:value-of select="/APPSHORE/API/brand"/> Beta Period</xsl:with-param>
	</xsl:call-template>

	<div>			
		<br/>
		<xsl:value-of select="php:function('lang','ROI Architect is currently running in testing mode for the next few weeks.')"/><br/><br/>
		<xsl:value-of select="php:function('lang','We do not feel it right to charge you during a beta test.')"/>&#160;				
		<xsl:value-of select="php:function('lang','So please enjoy ROI Architect freely until the end of the period.')"/><br/><br/>				
		<xsl:value-of select="php:function('lang',&quot;All your information is preserved and won&apos;t be destroyed or altered.&quot;)"/><br/><br/>				
		<xsl:value-of select="php:function('lang','You will receive an email 10 days before the end of the beta period to allow you to export your information if you do not wish to stay with us.')"/><br/><br/>				
		<xsl:value-of select="php:function('lang','Do not hesitate to contact us at ')"/> 
			<xsl:call-template name="mailto">
				<xsl:with-param name="email"><xsl:value-of select="/APPSHORE/API/support_email"/></xsl:with-param>
				<xsl:with-param name="name"><xsl:value-of select="/APPSHORE/API/brand"/> Team</xsl:with-param>
				<xsl:with-param name="subject"><xsl:value-of select="/APPSHORE/API/my_company/company_alias" />, <xsl:value-of select="/APPSHORE/API/current_user/full_name" />, feedback about <xsl:value-of select="/APPSHORE/API/brand"/></xsl:with-param>
			</xsl:call-template>&#160;
		<xsl:value-of select="php:function('lang','to raise bugs, to request some improvements or to give us some feedback about this service.')"/><br/><br/>				
		<xsl:value-of select="php:function('lang','Thank you for helping us to make ROI Architect better!')"/><br/><br/>
		<xsl:value-of select="php:function('lang','The ROI Architect Team')"/>										
	</div>
</xsl:template>

<xsl:template name="close_confirmed">
	<script language="JavaScript" type="text/javascript">
	<![CDATA[
		window.setTimeout("location.href = 'http://www.appshore.com';",3000);  
	]]>
	</script>

	<h3 style="text-align:center;padding:3em">		
		<xsl:value-of select="php:function('lang','Your ROI Architect account is now closed')"/><br/><br/>
		<xsl:value-of select="php:function('lang','The ROI Architect Team')"/>										
	</h3>
</xsl:template>

<xsl:template name="close">
	<script type="text/javascript">
		<![CDATA[

		function is_boxchecked( Mycheck) 
		{
			if ( Mycheck.checked == true )
				Mycheck.value = 'Y';
			else
				Mycheck.value = 'N';
		}

		]]>
	</script>

	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Close <xsl:value-of select="/APPSHORE/API/brand"/></xsl:with-param>
	</xsl:call-template>

	<form name="close" method="post">
		<input type="hidden" id="op" name="op" value="administration.subscription.close"/>
		<input type="hidden" id="key" name="key" />

		<div class="helpmsg">
			<xsl:value-of disable-output-escaping="yes" select="php:function('lang','administration.subscription.close.help')"/>
		</div>

		<div style="height:2em;line-height:2em;vertical-align:middle">
			<xsl:value-of select="php:function('lang','Yes, I confirm that I want to close my ROI Architect account')"/>&#160;
			<input type="checkbox" id="confirm" name="confirm" >
				<xsl:attribute name="onclick">is_boxchecked(this)</xsl:attribute>
				<xsl:attribute name="value"><xsl:value-of select="subscription/confirm" /></xsl:attribute>
				<xsl:if test="subscription/confirm = 'Y'">
					<xsl:attribute name="checked"/>
				</xsl:if>
			</input>
		</div>
		
		<input type="submit" class="formBarButton" name="close" onclick="document.close.key.value='Close'">
	        <xsl:attribute name="value">
	            <xsl:value-of select="php:function('lang','Close ROI Architect')"/>
	        </xsl:attribute>
	    </input>

	</form>
</xsl:template>


<xsl:template name="upgrade_success">

	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Upgrade <xsl:value-of select="/APPSHORE/API/brand"/></xsl:with-param>
	</xsl:call-template>

	<div>			
		<br/>
		<xsl:value-of select="php:function('lang','You have successfully modified your ROI Architect subscription.')"/><br/><br/>
		<xsl:value-of select="php:function('lang','This new subscription is effective immediately.')"/><br/><br/>				
		<xsl:value-of select="php:function('lang','Thank you for your business')"/><br/><br/>
		<xsl:value-of select="php:function('lang','The ROI Architect Team')"/>										
	</div>
</xsl:template>


<xsl:template name="upgrade_cancel">

	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Upgrade <xsl:value-of select="/APPSHORE/API/brand"/></xsl:with-param>
	</xsl:call-template>

	<div>
		<br/>
		<xsl:value-of select="php:function('lang','You have canceled your order or an error has occurred during the ordering process.')"/><br/><br/>
		<xsl:value-of select="php:function('lang','If you did not intend to cancel your order, or you are having difficulty in the ordering process, please contact ROI Architect at')"/>&#160;
		<xsl:call-template name="mailto">
			<xsl:with-param name="email"><xsl:value-of select="/APPSHORE/API/support_email"/></xsl:with-param>
			<xsl:with-param name="name"><xsl:value-of select="/APPSHORE/API/brand"/> Team</xsl:with-param>
			<xsl:with-param name="subject"><xsl:value-of select="/APPSHORE/API/my_company/company_name" />, <xsl:value-of select="/APPSHORE/API/current_user/full_name" />, Upgrading <xsl:value-of select="/APPSHORE/API/brand"/></xsl:with-param>
		</xsl:call-template><br/><br/>
		<xsl:value-of select="php:function('lang','Thank you for your business')"/><br/><br/>
		<xsl:value-of select="php:function('lang','The ROI Architect Team')"/>										
	</div>				
</xsl:template>

<xsl:template name="upgrade_maint">
	<div>
		<br/>
		<xsl:value-of select="php:function('lang','Please contact')"/>&#160;
		<xsl:call-template name="mailto">
			<xsl:with-param name="email"><xsl:value-of select="/APPSHORE/API/support_email"/></xsl:with-param>
			<xsl:with-param name="name"><xsl:value-of select="/APPSHORE/API/brand"/> Team</xsl:with-param>
			<xsl:with-param name="subject"><xsl:value-of select="/APPSHORE/API/my_company/company_name" />, <xsl:value-of select="/APPSHORE/API/current_user/full_name" />, Upgrading <xsl:value-of select="/APPSHORE/API/brand"/></xsl:with-param>
		</xsl:call-template>&#160;
		<xsl:value-of select="php:function('lang','to add or remove users from your license.')"/>
	</div>
</xsl:template>


<xsl:template name="upgrade">

	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Upgrade <xsl:value-of select="/APPSHORE/API/brand"/></xsl:with-param>
	</xsl:call-template>			

	<form id="upgrade" name="upgrade" method="post" >
		<input type="hidden" name="op" id="op" value="administration.subscription.upgrade"/>
		<input type="hidden" name="key" id="key" value=""/>				

	<div class="helpmsg">
		<xsl:value-of disable-output-escaping="yes" select="php:function('lang','administration.subscription.upgrade.help.1')"/>&#160;
		<xsl:call-template name="mailto">
			<xsl:with-param name="email"><xsl:value-of select="php:function('lang','billing@appshore.com')"/></xsl:with-param>
			<xsl:with-param name="name"><xsl:value-of select="php:function('lang','billing@appshore.com')"/></xsl:with-param>
			<xsl:with-param name="subject"><xsl:value-of select="/APPSHORE/API/my_company/company_name" />, <xsl:value-of select="/APPSHORE/API/current_user/full_name" />: Billing request</xsl:with-param>
		</xsl:call-template>
	</div>
		
	<div class="helpmsg" style="margin-top:20px">
		<xsl:value-of disable-output-escaping="yes" select="php:function('lang','administration.subscription.upgrade.help.2')"/>
	</div>
	
	<div >
		<xsl:value-of select="php:function('lang','Current ROI Architect edition')"/>&#160;
		<xsl:value-of select="subscription/current/edition_name"/>
	</div>
	<div style="font-weight:bold">	
		<xsl:value-of select="php:function('lang','New ROI Architect edition')"/>&#160;
		<select name="edition_id" onchange="document.upgrade.key.value='Update';document.upgrade.submit();">
			<xsl:for-each select = "editions/editions_item" >
				<option value="{edition_id}">
					<xsl:if test="edition_id = /APPSHORE/APP/subscription/new/edition_id">
						<xsl:attribute name="selected" value="true"/>
					</xsl:if>
					<xsl:value-of select="combined_edition_name"/>
				</option>
			</xsl:for-each>
		</select>
	</div>

	
	<div class="helpmsg" style="margin-top:20px">
		<xsl:value-of disable-output-escaping="yes" select="php:function('lang','administration.subscription.upgrade.help.3')"/>
	</div>
	
	<div>	
		<xsl:value-of select="php:function('lang','How many months?')"/>&#160;
		<select name="period" onchange="document.upgrade.key.value='Update';document.upgrade.submit();">
			<xsl:for-each select = "periods/periods_item" >
				<option value="{period}">
					<xsl:if test="period = /APPSHORE/APP/subscription/new/period">
						<xsl:attribute name="selected" value="true"/>
					</xsl:if>
					<xsl:value-of select="period"/>
				</option>
			</xsl:for-each>
		</select>
	</div>
	<xsl:if test="subscription/current/due_date">
		<div>	
			<xsl:value-of select="php:function('lang','Current due date')"/>&#160;
			<xsl:value-of select="subscription/current/due_date"/>
		</div>
    </xsl:if>				
	<xsl:if test="subscription/new/due_date">
		<div style="font-weight:bold">
			<xsl:value-of select="php:function('lang','New due date')"/>&#160;
			<xsl:value-of select="subscription/new/due_date"/>
		</div>
    </xsl:if>				
	
	<div class="helpmsg" style="margin-top:20px">
		<xsl:value-of disable-output-escaping="yes" select="php:function('lang','administration.subscription.upgrade.help.5')"/>
	</div>
	
	<xsl:choose>
		<xsl:when test="subscription/new/amount = 0">
			<div style="font-weight:bold;margin-top:20px">
				<xsl:value-of select="php:function('lang','You have nothing to pay.')"/>&#160;
			</div>
		</xsl:when>
		<xsl:when test="not(subscription/new/amount)">
			<div style="font-weight:bold;margin-top:20px">
				<xsl:value-of select="php:function('lang','Your basket is empty')"/>&#160;
			</div>
		</xsl:when>
		<xsl:otherwise>
			<div style="font-weight:bold;margin-top:20px">
				<xsl:value-of select="php:function('lang','Amount to pay')"/>&#160;
				USD <xsl:value-of select="subscription/new/amount" />
			</div>
		</xsl:otherwise>
	</xsl:choose>

	<div style="margin-top:20px">
		<input type="submit" class="formBarButton" name="Update" onclick="document.upgrade.key.value=this.name">
	        <xsl:attribute name="value"><xsl:value-of select="php:function('lang','Update the basket')"/></xsl:attribute>
	    </input>&#160;
	</div>
	
	<xsl:if test="subscription/is_update = 'true'">
		<div id="nextstep">
			<xsl:choose>
				<xsl:when test="subscription/new/amount = 0">
					<div class="helpmsg" style="margin-top:20px">
						<xsl:value-of disable-output-escaping="yes" select="php:function('lang','administration.subscription.upgrade.help.6')"/>
					</div>
					<div style="margin-top:20px">
						<input type="submit" class="formBarButton" name="Confirm" onclick="document.upgrade.key.value=this.name">
							<xsl:if test="not(subscription/new/updated)"><xsl:attribute name="disabled" value="true" /></xsl:if>
							<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Confirm the new subscription')"/></xsl:attribute>
						</input>
					</div>
				</xsl:when>
				<xsl:when test="not(subscription/new/amount)">
					<div style="margin-top:20px">
					&#160;
					</div>
				</xsl:when>
				<xsl:otherwise>	    
					<div class="helpmsg" style="margin-top:20px">
						<xsl:value-of disable-output-escaping="yes" select="php:function('lang','administration.subscription.upgrade.help.7')"/>
					</div>
					<div style="margin-top:20px">
						<input type="submit" class="formBarButton" name="GoogleWallet" onclick="document.upgrade.key.value=this.name">
							<xsl:if test="not(subscription/new/updated)"><xsl:attribute name="disabled" value="true" /></xsl:if>
							<xsl:attribute name="value"><xsl:value-of select="php:function('lang','Google Wallet')"/></xsl:attribute>
						</input>&#160;
						<input type="submit" class="formBarButton" name="Paypal" onclick="document.upgrade.key.value=this.name">
							<xsl:if test="not(subscription/new/updated)"><xsl:attribute name="disabled" value="true" /></xsl:if>
							<xsl:attribute name="value"><xsl:value-of select="php:function('lang','PayPal')"/></xsl:attribute>
						</input>
					</div>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:if>

	</form>	
</xsl:template>

<xsl:template name='GoogleWallet'>
	<script language="JavaScript" type="text/javascript">
	<![CDATA[
		window.setTimeout("document.checkoutform.submit();",4000);
	]]>
	</script>
	
	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Upgrade <xsl:value-of select="/APPSHORE/API/brand"/></xsl:with-param>
	</xsl:call-template>			

<!--	<form name="checkoutform" action="https://sandbox.google.com/checkout/api/checkout/v2/checkoutForm/Merchant/{google/merchant_id}" -->
	<form name="checkoutform" action="https://checkout.google.com/api/checkout/v2/checkoutForm/Merchant/{google/merchant_id}" 
		method="post" accept-charset="utf-8">
		<input type="hidden" name="shopping-cart.items.item-1.item-name" value="{google/item_name_1}"/>
		<input type="hidden" name="shopping-cart.items.item-1.item-description" value="{google/item_description_1}"/>
		<input type="hidden" name="shopping-cart.items.item-1.unit-price" value="{google/item_price_1}"/>
		<input type="hidden" name="shopping-cart.items.item-1.unit-price.currency" value="{google/item_currency_1}"/>
		<input type="hidden" name="shopping-cart.items.item-1.quantity" value="{google/item_quantity_1}"/>

		<input type="hidden" name="shopping-cart.items.item-1.digital-content.display-disposition" value="OPTIMISTIC"/>
		<input type="hidden" name="shopping-cart.items.item-1.digital-content.description">
			<xsl:attribute name="value">
				<xsl:value-of select="php:function('lang','Please click the following link to return to your ROI Architect account and to activate your new subscription.')"/>&#160;
				&amp;lt;a href="<xsl:value-of select="$baseurl"/><xsl:value-of select="google/return"/>"&amp;gt;<xsl:value-of select="php:function('lang','Return to your ROI Architect account')"/>&amp;lt;/a&amp;gt;
			</xsl:attribute>
		</input>
		
		<input type="hidden" name="checkout-flow-support.merchant-checkout-flow-support.edit-cart-url"
			value="{$baseurl}{google/cancel_return}"/>
		<input type="hidden" name="checkout-flow-support.merchant-checkout-flow-support.continue-shopping-url"
			value="{$baseurl}{google/return}"/>
			

    <table class="formtext" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td colspan="2">
				<br/>
				<xsl:value-of select="php:function('lang','In 5 seconds you will be automatically redirected to the Google Wallet web site.')"/>
				<br/><br/>
			</td>
		</tr>
		<tr>
			<td valign="middle" width="*">
				<xsl:value-of select="php:function('lang','Click the Google Wallet button if nothing happens.')"/>
			</td>		
			<td valign="middle" align="left" width="60%">
				<input type="hidden" name="_charset_"/>
				<input type="image" name="Google Wallet" alt="Fast checkout through Google"
					src="https://checkout.google.com/buttons/checkout.gif?merchant_id={google/merchant_id}&amp;w=180&amp;h=46&amp;style=white&amp;variant=text&amp;loc=en_US"
					height="46" width="180"/>				
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<br/>
				<xsl:value-of select="php:function('lang','Please go back to your ROI Architect account after your payment to complete the process.')"/><br/><br/>
				<xsl:value-of select="php:function('lang','Thank you for your business')"/><br/><br/>				
				<xsl:value-of select="php:function('lang','The ROI Architect Team')"/>				
			</td>
		</tr>				
	</table>
	</form>				
</xsl:template>

	
<xsl:template name='Paypal'>
	<script language="JavaScript" type="text/javascript">
	<![CDATA[
		window.setTimeout("document.checkoutform.submit();",4000);
	]]>
	</script>
	
	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Upgrade <xsl:value-of select="/APPSHORE/API/brand"/></xsl:with-param>
	</xsl:call-template>			

	<form name="checkoutform" action="https://www.paypal.com/cgi-bin/webscr" method="post">
		<input type="hidden" name="cmd" 			value="_xclick"/>
		<input type="hidden" name="business" 		value="{paypal/business}"/>
		<input type="hidden" name="mbr" 			value="{paypal/mbr}"/>
		<input type="hidden" name="item_name" 		value="{paypal/item_name}"/>
		<input type="hidden" name="item_number" 	value="{paypal/item_number}"/>
		<input type="hidden" name="no_shipping" 	value="{paypal/no_shipping}"/>
		<input type="hidden" name="src" 			value="1"/>
		<input type="hidden" name="sra" 			value="1"/>		
		<input type="hidden" name="rm" 				value="2"/>		
		<input type="hidden" name="cbt" 			value="Return to {/APPSHORE/API/brand}"/>
		<input type="hidden" name="return" 			value="{$baseurl}{paypal/return}"/>		
		<input type="hidden" name="cancel_return" 	value="{$baseurl}{paypal/cancel_return}"/>
		<input type="hidden" name="no_note" 		value="{paypal/no_note}"/>
		<input type="hidden" name="invoice" 		value="{paypal/order_id}"/>		
		<input type="hidden" name="currency_code" 	value="{paypal/currency_code}"/>
		<input type="hidden" name="amount" 			value="{paypal/amount}"/>
		<input type="hidden" name="email" 			value="{paypal/email}"/>		
		<input type="hidden" name="first_name" 		value="{paypal/first_name}"/>
		<input type="hidden" name="last_name" 		value="{paypal/last_name}"/>
		<input type="hidden" name="address1"		value="{paypal/address1}"/>					
		<input type="hidden" name="city" 			value="{paypal/city}"/>
		<input type="hidden" name="zip" 			value="{paypal/zip}"/>			
		<input type="hidden" name="state" 			value="{paypal/state}"/>
		<input type="hidden" name="country"			value="{paypal/country}"/>						

    <table class="formtext" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td colspan="2">
				<br/>
				<xsl:value-of select="php:function('lang','In 5 seconds you will be automatically redirected to the Paypal web site.')"/>
				<br/><br/>
			</td>
		</tr>
		<tr>
			<td valign="middle" width="*">
				<xsl:value-of select="php:function('lang','Click the Paypal button if nothing happens.')"/>
			</td>		
			<td valign="middle" align="left" width="60%">
				<input type="image" src="https://www.paypal.com/en_US/i/btn/btn_paynowCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!"/>					
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<br/>
				<xsl:value-of select="php:function('lang','Please go back to your ROI Architect account after your payment to complete the process.')"/><br/><br/>				
				<xsl:value-of select="php:function('lang','Thank you for your business')"/><br/><br/>				
				<xsl:value-of select="php:function('lang','The ROI Architect Team')"/>			
			</td>
		</tr>				
	</table>
	</form>				
</xsl:template>



</xsl:stylesheet>
